import 'package:content_schema/content_schema.dart';

import '../prng/xoshiro128.dart';

/// Fixed control-flow block ids (§1.3), shared verbatim between virus
/// programs and defense-logic programs.
const Set<String> controlFlowBlockIds = {
  'if_else',
  'priority',
  'repeat',
  'random_branch',
  'sequence',
};

/// Memory blocks that behave like sensors (evaluate, don't mutate) vs like
/// actions (mutate, don't branch). See docs/DECISIONS.md "interpreter
/// branching model" for why this split exists.
const Set<String> memorySensorLikeBlockIds = {'node_marked', 'counter_gt', 'timer_after'};
const Set<String> memoryActionLikeBlockIds = {'mark_node', 'counter_inc'};

bool isSensorLikeBlock(String blockId, BlockDef block) {
  if (block.family == BlockFamily.sensor || block.family == BlockFamily.defenseSensor) {
    return true;
  }
  if (block.family == BlockFamily.memory) {
    return memorySensorLikeBlockIds.contains(blockId);
  }
  return false;
}

bool isActionLikeBlock(String blockId, BlockDef block) {
  if (block.family == BlockFamily.action || block.family == BlockFamily.defenseAction) {
    return true;
  }
  if (block.family == BlockFamily.memory) {
    return memoryActionLikeBlockIds.contains(blockId);
  }
  return false;
}

/// Walks one DAG program for one actor (a virus copy or a defending node)
/// for a single tick, per the branching model in docs/DECISIONS.md:
///
/// - Sensor-family (and sensor-like memory) blocks evaluate a predicate,
///   store it as [lastSensorResult], and always continue to `out['next']`
///   (or the single entry in `out` if unnamed) — sensors never branch
///   themselves.
/// - Control-flow blocks are the only nodes that branch: `if_else` reads
///   [lastSensorResult]; `random_branch` flips a fair coin via the shared
///   seeded RNG; `priority` and `repeat` recurse into sub-chains that share
///   this walker's eval-step budget.
/// - Action-family (and action-like memory) blocks execute an effect, then
///   continue to `out['next']`.
///
/// The whole walk (including recursive sub-chains from `repeat`/`priority`)
/// is capped at [maxEvalSteps] node visits (§3.2: 64 per tick) — exceeding
/// it sets [stalled] and aborts the walk, matching the "hang" feedback
/// described in PAYLOAD_PLAN.md §3.2.
class ChainWalker {
  final DagDef program;
  final Map<String, BlockDef> catalog;
  final bool Function(String blockId, Map<String, dynamic> params) evalSensor;
  final void Function(String blockId, Map<String, dynamic> params) execAction;
  final bool Function() actorIsAlive;
  final Xoshiro128 rng;
  final int maxEvalSteps;

  int evalStepsUsed;
  bool? lastSensorResult;
  bool stalled = false;

  ChainWalker({
    required this.program,
    required this.catalog,
    required this.evalSensor,
    required this.execAction,
    required this.actorIsAlive,
    required this.rng,
    required this.maxEvalSteps,
    this.evalStepsUsed = 0,
    this.lastSensorResult,
  });

  ChainWalker _sub() => ChainWalker(
        program: program,
        catalog: catalog,
        evalSensor: evalSensor,
        execAction: execAction,
        actorIsAlive: actorIsAlive,
        rng: rng,
        maxEvalSteps: maxEvalSteps,
        evalStepsUsed: evalStepsUsed,
        lastSensorResult: lastSensorResult,
      );

  void _absorb(ChainWalker sub) {
    evalStepsUsed = sub.evalStepsUsed;
    lastSensorResult = sub.lastSensorResult;
    if (sub.stalled) stalled = true;
  }

  String? _singleOut(DagNode node) => node.out.length == 1 ? node.out.values.first : null;

  /// Runs the chain from [startId]. Returns true iff at least one action
  /// executed along the way (used by `priority` to decide a candidate
  /// "succeeded", and by `repeat` bookkeeping).
  bool runChain(String startId) {
    var currentId = startId;
    var actionExecuted = false;

    while (true) {
      if (evalStepsUsed >= maxEvalSteps) {
        stalled = true;
        return actionExecuted;
      }
      final node = program.nodeById(currentId);
      if (node == null) return actionExecuted;
      evalStepsUsed++;

      final block = catalog[node.blockId];
      if (block == null) return actionExecuted;

      String? next;
      if (block.family == BlockFamily.controlFlow) {
        next = _handleControlFlow(node);
        if (evalStepsUsed >= maxEvalSteps && stalled) return actionExecuted;
      } else if (isSensorLikeBlock(node.blockId, block)) {
        lastSensorResult = evalSensor(node.blockId, node.params);
        next = node.out['next'] ?? _singleOut(node);
      } else {
        execAction(node.blockId, node.params);
        actionExecuted = true;
        next = node.out['next'] ?? _singleOut(node);
        if (!actorIsAlive()) return actionExecuted;
      }

      if (next == null) return actionExecuted;
      currentId = next;
    }
  }

  String? _handleControlFlow(DagNode node) {
    switch (node.blockId) {
      case 'sequence':
        return node.out['next'] ?? _singleOut(node);

      case 'if_else':
        final branch = (lastSensorResult ?? false) ? 'true' : 'false';
        return node.out[branch];

      case 'random_branch':
        final branch = rng.chancePercent(50) ? 'true' : 'false';
        return node.out[branch];

      case 'repeat':
        final times = (node.params['x'] as int?) ?? 1;
        final body = node.out['body'];
        if (body != null) {
          for (var i = 0; i < times; i++) {
            if (evalStepsUsed >= maxEvalSteps) {
              stalled = true;
              break;
            }
            final sub = _sub();
            sub.runChain(body);
            _absorb(sub);
            if (!actorIsAlive() || stalled) break;
          }
        }
        return node.out['after'];

      case 'priority':
        final keys = node.out.keys.where((k) => k != 'after').toList()..sort();
        for (final k in keys) {
          if (evalStepsUsed >= maxEvalSteps) {
            stalled = true;
            break;
          }
          final candidateId = node.out[k];
          if (candidateId == null) continue;
          final sub = _sub();
          final won = sub.runChain(candidateId);
          _absorb(sub);
          if (won || !actorIsAlive() || stalled) break;
        }
        return node.out['after'];

      default:
        return null;
    }
  }
}
