import 'dart:ui' show Offset;

import 'package:content_schema/content_schema.dart';

const double layerSpacing = 160;
const double nodeSpacing = 100;

/// Deterministic left-to-right layered layout (§3.4 "jaringan digambar
/// sebagai peta sirkuit"): BFS depth from the entry node becomes the
/// column; nodes unreachable from entry get one extra trailing column so
/// nothing overlaps or goes unpositioned.
Map<String, Offset> computeNetworkLayout(NetworkDef network) {
  final entry = network.nodes.firstWhere(
    (n) => n.type == NodeType.entry,
    orElse: () => network.nodes.first,
  );

  final depth = <String, int>{entry.id: 0};
  final queue = [entry.id];
  while (queue.isNotEmpty) {
    final current = queue.removeAt(0);
    final node = network.nodeById(current);
    if (node == null) continue;
    for (final next in node.edges) {
      if (depth.containsKey(next)) continue;
      depth[next] = depth[current]! + 1;
      queue.add(next);
    }
  }

  final maxDepth = depth.values.isEmpty ? 0 : depth.values.reduce((a, b) => a > b ? a : b);
  final unreachableColumn = maxDepth + 1;

  final byColumn = <int, List<String>>{};
  for (final node in network.nodes) {
    final column = depth[node.id] ?? unreachableColumn;
    byColumn.putIfAbsent(column, () => []).add(node.id);
  }

  final positions = <String, Offset>{};
  for (final colEntry in byColumn.entries) {
    final column = colEntry.key;
    final ids = colEntry.value;
    final totalHeight = (ids.length - 1) * nodeSpacing;
    for (var i = 0; i < ids.length; i++) {
      final y = (i * nodeSpacing) - totalHeight / 2;
      positions[ids[i]] = Offset(column * layerSpacing, y);
    }
  }
  return positions;
}
