import 'package:content_schema/content_schema.dart';
import 'package:test/test.dart';

NetworkNodeDef _node(String id, NodeType type, List<String> edges) =>
    NetworkNodeDef(id: id, type: type, edges: edges);

void main() {
  group('validateNetwork', () {
    test('rejects networks with fewer than 8 nodes', () {
      final net = NetworkDef(id: 'tiny', nodes: [
        _node('n1', NodeType.entry, ['n2']),
        _node('n2', NodeType.data, []),
      ]);
      final result = validateNetwork(net);
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('node count')), isTrue);
    });

    test('rejects a network with no path from entry to data/core (anti-turtle)', () {
      final nodes = [
        _node('entry', NodeType.entry, ['r1']),
        _node('r1', NodeType.relay, []), // dead end, never reaches data
        for (var i = 0; i < 5; i++) _node('relay$i', NodeType.relay, []),
        _node('data', NodeType.data, []),
      ];
      final net = NetworkDef(id: 'turtle', nodes: nodes);
      final result = validateNetwork(net);
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('anti-turtle')), isTrue);
    });

    test('accepts a minimal valid 8-node network with a real path', () {
      final nodes = [
        _node('entry', NodeType.entry, ['r1']),
        _node('r1', NodeType.relay, ['r2']),
        _node('r2', NodeType.relay, ['r3']),
        _node('r3', NodeType.relay, ['r4']),
        _node('r4', NodeType.relay, ['r5']),
        _node('r5', NodeType.relay, ['data']),
        _node('data', NodeType.data, []),
        _node('core', NodeType.core, []),
      ];
      final net = NetworkDef(id: 'valid', nodes: nodes);
      final result = validateNetwork(net);
      expect(result.isValid, isTrue, reason: result.errors.join('; '));
    });

    test('rejects edges pointing to unknown nodes', () {
      final nodes = [
        for (var i = 0; i < 7; i++) _node('n$i', NodeType.relay, []),
        _node('entry', NodeType.entry, ['ghost']),
      ];
      final net = NetworkDef(id: 'dangling', nodes: nodes);
      final result = validateNetwork(net);
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('unknown node')), isTrue);
    });
  });
}
