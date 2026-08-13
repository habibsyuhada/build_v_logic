import 'package:content_schema/content_schema.dart';
import 'package:test/test.dart';

void main() {
  final catalog = {
    'move_random': const BlockDef(
        id: 'move_random', family: BlockFamily.action, sizeKb: 2),
    'firewall_detected': const BlockDef(
        id: 'firewall_detected', family: BlockFamily.sensor, sizeKb: 1),
    'if_else': const BlockDef(
        id: 'if_else', family: BlockFamily.controlFlow, sizeKb: 1),
  };

  group('validateDag', () {
    test('accepts a minimal valid virus', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'move_random'),
      ], entry: 'a');
      final result = validateDag(dag, blockCatalog: catalog);
      expect(result.isValid, isTrue, reason: result.errors.join('; '));
    });

    test('rejects unknown entry', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'move_random'),
      ], entry: 'nope');
      final result = validateDag(dag, blockCatalog: catalog);
      expect(result.isValid, isFalse);
    });

    test('rejects unknown block_id', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'not_a_block'),
      ], entry: 'a');
      final result = validateDag(dag, blockCatalog: catalog);
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('unknown block_id')), isTrue);
    });

    test('rejects locked blocks', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'move_random'),
      ], entry: 'a');
      final result =
          validateDag(dag, blockCatalog: catalog, unlockedBlockIds: {});
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('locked block')), isTrue);
    });

    test('rejects over-budget virus', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'move_random'),
      ], entry: 'a');
      final result = validateDag(dag, blockCatalog: catalog, capacityKb: 1);
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('exceeds capacity')), isTrue);
    });

    test('warns on unreachable node but stays valid', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'move_random'),
        const DagNode(id: 'orphan', blockId: 'move_random'),
      ], entry: 'a');
      final result = validateDag(dag, blockCatalog: catalog);
      expect(result.isValid, isTrue);
      expect(result.warnings.any((w) => w.contains('unreachable')), isTrue);
    });

    test('warns on sensor with no out edge (dead end)', () {
      const dag = DagDef(nodes: [
        const DagNode(id: 'a', blockId: 'firewall_detected'),
      ], entry: 'a');
      final result = validateDag(dag, blockCatalog: catalog);
      expect(result.isValid, isTrue);
      expect(result.warnings.any((w) => w.contains('no out edge')), isTrue);
    });
  });
}
