import 'package:content_schema/content_schema.dart';
import 'package:test/test.dart';

void main() {
  group('validateBlockSet', () {
    test('accepts a well-formed catalog', () {
      final blocks = [
        const BlockDef(
          id: 'move_random',
          family: BlockFamily.action,
          sizeKb: 2,
          energyCost: 2,
          noise: 1,
        ),
        const BlockDef(
          id: 'firewall_detected',
          family: BlockFamily.sensor,
          sizeKb: 1,
        ),
      ];
      final result = validateBlockSet(blocks);
      expect(result.isValid, isTrue, reason: result.errors.join('; '));
    });

    test('rejects duplicate ids', () {
      final blocks = [
        const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 1),
        const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 2),
      ];
      final result = validateBlockSet(blocks);
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.contains('duplicate block id')), isTrue);
    });

    test('rejects non-positive size_kb', () {
      final blocks = [
        const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 0),
      ];
      final result = validateBlockSet(blocks);
      expect(result.isValid, isFalse);
    });

    test('round-trips through JSON', () {
      const block = BlockDef(
        id: 'exploit',
        family: BlockFamily.action,
        sizeKb: 6,
        energyCost: 10,
        noise: 4,
        paramsSchema: [ParamSchema(name: 'id', type: 'string')],
        unlockMission: 'ch1_m3',
      );
      final decoded = BlockDef.fromJson(block.toJson());
      expect(decoded.id, block.id);
      expect(decoded.family, block.family);
      expect(decoded.sizeKb, block.sizeKb);
      expect(decoded.paramsSchema.single.name, 'id');
      expect(decoded.unlockMission, 'ch1_m3');
    });
  });
}
