import '../models/network_def.dart';
import 'validation_result.dart';

/// Validates a network topology: node count bounds (§1.2: 8-40 nodes),
/// edge integrity, and the "no unreachable core" anti-turtle rule (§1.4):
/// the network must always have at least one valid path from an entry node
/// to a data or core node.
ValidationResult validateNetwork(NetworkDef network) {
  final errors = <String>[];
  final warnings = <String>[];

  if (network.nodes.length < 8 || network.nodes.length > 40) {
    errors.add(
        'network ${network.id}: node count must be 8-40 (got ${network.nodes.length})');
  }

  final ids = <String>{};
  for (final n in network.nodes) {
    if (!ids.add(n.id)) {
      errors.add('network ${network.id}: duplicate node id ${n.id}');
    }
  }

  for (final n in network.nodes) {
    for (final edge in n.edges) {
      if (!ids.contains(edge)) {
        errors.add(
            'network ${network.id}: node ${n.id} has edge to unknown node $edge');
      }
    }
  }

  final entryIds =
      network.nodes.where((n) => n.type == NodeType.entry).map((n) => n.id);
  final targetIds = network.nodes
      .where((n) => n.type == NodeType.data || n.type == NodeType.core)
      .map((n) => n.id)
      .toSet();

  if (entryIds.isEmpty) {
    errors.add('network ${network.id}: no entry node');
  }
  if (targetIds.isEmpty) {
    errors.add('network ${network.id}: no data or core node');
  }

  if (entryIds.isNotEmpty && targetIds.isNotEmpty) {
    final adjacency = {for (final n in network.nodes) n.id: n.edges};
    var reachesTarget = false;
    for (final start in entryIds) {
      if (_reachesAny(start, targetIds, adjacency)) {
        reachesTarget = true;
        break;
      }
    }
    if (!reachesTarget) {
      errors.add(
          'network ${network.id}: no valid path from any entry to a data/core node (anti-turtle)');
    }
  }

  return ValidationResult(errors: errors, warnings: warnings);
}

bool _reachesAny(
    String start, Set<String> targets, Map<String, List<String>> adjacency) {
  final visited = <String>{start};
  final queue = [start];
  while (queue.isNotEmpty) {
    final current = queue.removeAt(0);
    if (targets.contains(current)) return true;
    for (final next in adjacency[current] ?? const <String>[]) {
      if (visited.add(next)) queue.add(next);
    }
  }
  return false;
}
