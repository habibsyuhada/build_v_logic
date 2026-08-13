import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/replay/flame/network_layout.dart';

void main() {
  test('entry node is placed at column 0', () {
    final network = NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: []),
    ]);
    final layout = computeNetworkLayout(network);
    expect(layout['entry']!.dx, 0);
  });

  test('BFS depth determines the column (x position)', () {
    final network = NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['a']),
      const NetworkNodeDef(id: 'a', type: NodeType.relay, edges: ['b']),
      const NetworkNodeDef(id: 'b', type: NodeType.data, edges: []),
    ]);
    final layout = computeNetworkLayout(network);
    expect(layout['entry']!.dx, lessThan(layout['a']!.dx));
    expect(layout['a']!.dx, lessThan(layout['b']!.dx));
  });

  test('nodes unreachable from entry still get a position, in a trailing column', () {
    final network = NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: []),
      const NetworkNodeDef(id: 'island', type: NodeType.honeypot, edges: []),
    ]);
    final layout = computeNetworkLayout(network);
    expect(layout.containsKey('island'), isTrue);
    expect(layout['island']!.dx, greaterThan(layout['data']!.dx));
  });

  test('every node gets a unique position (no overlap within a column)', () {
    final network = NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['a', 'b', 'c']),
      const NetworkNodeDef(id: 'a', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'b', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'c', type: NodeType.relay, edges: []),
    ]);
    final layout = computeNetworkLayout(network);
    final ys = [layout['a']!.dy, layout['b']!.dy, layout['c']!.dy];
    expect(ys.toSet().length, 3);
  });
}
