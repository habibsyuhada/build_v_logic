import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:payload_server/src/business/defense_submission_validator.dart';
import 'package:test/test.dart';

final _catalog = {
  'intruder_detected':
      const BlockDef(id: 'intruder_detected', family: BlockFamily.defenseSensor, sizeKb: 1),
  'if_else': const BlockDef(id: 'if_else', family: BlockFamily.controlFlow, sizeKb: 1),
  'quarantine': const BlockDef(id: 'quarantine', family: BlockFamily.defenseAction, sizeKb: 1),
};

const _smallGuardLogic = DagDef(nodes: [
  DagNode(id: 'a', blockId: 'intruder_detected', out: {'next': 'b'}),
  DagNode(id: 'b', blockId: 'if_else', out: {'true': 'c'}),
  DagNode(id: 'c', blockId: 'quarantine'),
], entry: 'a');

NetworkDef _network({Map<String, dynamic>? defenseLogicOnGate}) => NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['gate']),
      NetworkNodeDef(id: 'gate', type: NodeType.relay, edges: const ['data'],
          defenseLogic: defenseLogicOnGate),
      const NetworkNodeDef(
          id: 'data', type: NodeType.data, edges: [], data: DataDef(value: 10, verified: true)),
      const NetworkNodeDef(id: 's1', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's2', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's3', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's4', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's5', type: NodeType.relay, edges: []),
    ]);

void main() {
  test('rejects malformed JSON', () {
    final result = DefenseSubmissionValidator.validate(
      networkDefJson: 'not json',
      blockCatalog: _catalog,
      unlockedBlockIds: _catalog.keys.toSet(),
    );
    expect(result.isValid, isFalse);
  });

  test('accepts a valid network with a small defense-logic within the 6-block cap', () {
    final network = _network(defenseLogicOnGate: _smallGuardLogic.toJson());
    final result = DefenseSubmissionValidator.validate(
      networkDefJson: jsonEncode(network.toJson()),
      blockCatalog: _catalog,
      unlockedBlockIds: _catalog.keys.toSet(),
    );
    expect(result.isValid, isTrue, reason: result.errors.join('; '));
  });

  test('rejects defense-logic over the 6-block cap (§1.4)', () {
    final tooManyNodes = DagDef(
      nodes: [
        for (var i = 0; i < 7; i++)
          DagNode(id: 'n$i', blockId: 'intruder_detected', out: i < 6 ? {'next': 'n${i + 1}'} : {}),
      ],
      entry: 'n0',
    );
    final network = _network(defenseLogicOnGate: tooManyNodes.toJson());
    final result = DefenseSubmissionValidator.validate(
      networkDefJson: jsonEncode(network.toJson()),
      blockCatalog: _catalog,
      unlockedBlockIds: _catalog.keys.toSet(),
    );
    expect(result.isValid, isFalse);
    expect(result.errors.any((e) => e.contains('max 6')), isTrue);
  });

  test('rejects a network that fails the anti-turtle check', () {
    final network = NetworkDef(id: 'turtle', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['dead_end']),
      const NetworkNodeDef(id: 'dead_end', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: []), // unreachable
      const NetworkNodeDef(id: 's1', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's2', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's3', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's4', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's5', type: NodeType.relay, edges: []),
    ]);
    final result = DefenseSubmissionValidator.validate(
      networkDefJson: jsonEncode(network.toJson()),
      blockCatalog: _catalog,
      unlockedBlockIds: _catalog.keys.toSet(),
    );
    expect(result.isValid, isFalse);
    expect(result.errors.any((e) => e.contains('anti-turtle')), isTrue);
  });

  test('rejects defense-logic using a locked block', () {
    final network = _network(defenseLogicOnGate: _smallGuardLogic.toJson());
    final result = DefenseSubmissionValidator.validate(
      networkDefJson: jsonEncode(network.toJson()),
      blockCatalog: _catalog,
      unlockedBlockIds: {'intruder_detected', 'if_else'}, // quarantine NOT unlocked
    );
    expect(result.isValid, isFalse);
    expect(result.errors.any((e) => e.contains('locked block')), isTrue);
  });
}
