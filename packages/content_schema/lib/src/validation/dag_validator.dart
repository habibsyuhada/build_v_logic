import '../models/block_def.dart';
import '../models/dag_def.dart';
import 'validation_result.dart';

/// Validates a virus/defense DAG against a block catalog (§2.5, §3.2, §3.3):
/// - entry and all `out` targets reference real nodes
/// - every node's block_id is known (and, if [unlockedBlockIds] given,
///   unlocked by the player)
/// - total size fits [capacityKb] if provided
/// - unreachable nodes and dead-end sensors are reported as warnings
///   (matching the editor lint in §3.3), not hard errors — a stray
///   disconnected block is a mistake, not an exploit.
///
/// Note: unbounded pure-sensor cycles are intentionally NOT rejected here.
/// The interpreter's 64-eval-step-per-tick cap (§3.2) turns any runaway
/// loop into a harmless single-tick "stall", which the design explicitly
/// treats as visible, in-fiction feedback rather than an error condition.
/// See docs/DECISIONS.md.
ValidationResult validateDag(
  DagDef dag, {
  required Map<String, BlockDef> blockCatalog,
  Set<String>? unlockedBlockIds,
  int? capacityKb,
}) {
  final errors = <String>[];
  final warnings = <String>[];

  final nodeIds = <String>{};
  for (final n in dag.nodes) {
    if (!nodeIds.add(n.id)) {
      errors.add('duplicate DAG node id: ${n.id}');
    }
  }

  if (!nodeIds.contains(dag.entry)) {
    errors.add('entry node ${dag.entry} does not exist');
  }

  var totalSizeKb = 0;
  for (final n in dag.nodes) {
    final block = blockCatalog[n.blockId];
    if (block == null) {
      errors.add('node ${n.id} references unknown block_id ${n.blockId}');
      continue;
    }
    if (unlockedBlockIds != null && !unlockedBlockIds.contains(n.blockId)) {
      errors.add('node ${n.id} uses locked block ${n.blockId}');
    }
    totalSizeKb += block.sizeKb;

    for (final target in n.out.values) {
      if (!nodeIds.contains(target)) {
        errors.add('node ${n.id} has out-edge to unknown node $target');
      }
    }

    if (n.out.isEmpty && block.family != BlockFamily.action) {
      warnings.add('node ${n.id} (${n.blockId}) has no out edge');
    }
  }

  if (capacityKb != null && totalSizeKb > capacityKb) {
    errors.add(
        'virus size ${totalSizeKb}KB exceeds capacity ${capacityKb}KB');
  }

  final reachable = <String>{};
  if (nodeIds.contains(dag.entry)) {
    final queue = [dag.entry];
    reachable.add(dag.entry);
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      final node = dag.nodeById(current);
      if (node == null) continue;
      for (final next in node.out.values) {
        if (reachable.add(next)) queue.add(next);
      }
    }
  }
  for (final n in dag.nodes) {
    if (!reachable.contains(n.id)) {
      warnings.add('node ${n.id} (${n.blockId}) is unreachable from entry');
    }
  }

  return ValidationResult(errors: errors, warnings: warnings);
}
