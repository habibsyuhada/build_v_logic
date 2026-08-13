import 'package:content_schema/content_schema.dart';

import '../model/sim_state.dart';
import '../prng/xoshiro128.dart';
import '../replay/battle_event.dart';
import 'chain_walker.dart';
import 'defense_blocks.dart';
import 'defense_ctx.dart';
import 'virus_blocks.dart';
import 'virus_ctx.dart';

class TickRunResult {
  final bool stalled;
  const TickRunResult({required this.stalled});
}

/// Runs one virus copy's program for the current tick (§3.1 step 3).
TickRunResult runVirusTick({
  required VirusRuntime virus,
  required DagDef program,
  required SimState state,
  required BalanceConfig balance,
  required Xoshiro128 rng,
  required Map<String, BlockDef> catalog,
  required List<BattleEvent> events,
  required int tick,
}) {
  final ctx = VirusCtx(
    virus: virus,
    state: state,
    balance: balance,
    rng: rng,
    tick: tick,
    emit: (type, data) => events.add(BattleEvent(tick: tick, type: type, data: data)),
  );

  final walker = ChainWalker(
    program: program,
    catalog: catalog,
    maxEvalSteps: balance.maxEvalStepsPerTick,
    rng: rng,
    actorIsAlive: () => virus.alive,
    evalSensor: (blockId, params) {
      final fn = virusSensorRegistry[blockId];
      return fn == null ? false : fn(ctx, params);
    },
    execAction: (blockId, params) {
      final block = catalog[blockId];
      if (block != null) {
        ctx.spendEnergy(block.energyCost);
        if (!virus.alive) {
          virus.lastActionBlockId = blockId;
          return;
        }
        ctx.addNoise(block.noise);
      }
      virus.lastActionBlockId = blockId;
      final fn = virusActionRegistry[blockId];
      fn?.call(ctx, params);
    },
  );

  walker.runChain(program.entry);
  if (walker.stalled) {
    events.add(BattleEvent(tick: tick, type: 'virus_stalled', data: {'virus_id': virus.id}));
  }
  return TickRunResult(stalled: walker.stalled);
}

/// Runs one node's defense-logic program for the current tick (§3.1 steps
/// 1-2: defense sensors then defense actions — modeled here as a single
/// walk since a sensor-then-action chain is exactly what the DAG encodes).
TickRunResult runDefenseTick({
  required NodeRuntime node,
  required DagDef program,
  required SimState state,
  required BalanceConfig balance,
  required Xoshiro128 rng,
  required Map<String, BlockDef> catalog,
  required List<BattleEvent> events,
  required int tick,
}) {
  final ctx = DefenseCtx(
    node: node,
    state: state,
    balance: balance,
    rng: rng,
    tick: tick,
    emit: (type, data) => events.add(BattleEvent(tick: tick, type: type, data: data)),
  );

  final walker = ChainWalker(
    program: program,
    catalog: catalog,
    maxEvalSteps: balance.maxEvalStepsPerTick,
    rng: rng,
    actorIsAlive: () => true,
    evalSensor: (blockId, params) {
      final fn = defenseSensorRegistry[blockId];
      return fn == null ? false : fn(ctx, params);
    },
    execAction: (blockId, params) {
      final block = catalog[blockId];
      final fn = defenseActionRegistry[blockId];
      if (fn != null && block != null) fn(ctx, params, block);
    },
  );

  walker.runChain(program.entry);
  if (walker.stalled) {
    events.add(BattleEvent(tick: tick, type: 'defense_stalled', data: {'node_id': node.id}));
  }
  return TickRunResult(stalled: walker.stalled);
}
