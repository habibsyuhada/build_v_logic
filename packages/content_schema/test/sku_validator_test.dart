import 'package:content_schema/content_schema.dart';
import 'package:test/test.dart';

void main() {
  group('validateSkuSet', () {
    test('accepts a well-formed catalog', () {
      final skus = [
        const SkuDef(id: 'keys_tier_1', type: SkuType.keysPack, priceUsdCents: 99, keysAmount: 100),
        const SkuDef(id: 'battle_pass_season', type: SkuType.battlePassSeason, priceUsdCents: 799),
      ];
      final result = validateSkuSet(skus);
      expect(result.isValid, isTrue, reason: result.errors.join('; '));
    });

    test('rejects duplicate ids', () {
      final skus = [
        const SkuDef(id: 'a', type: SkuType.keysPack, priceUsdCents: 99, keysAmount: 100),
        const SkuDef(id: 'a', type: SkuType.keysPack, priceUsdCents: 199, keysAmount: 200),
      ];
      expect(validateSkuSet(skus).isValid, isFalse);
    });

    test('rejects non-positive price', () {
      final skus = [
        const SkuDef(id: 'a', type: SkuType.keysPack, priceUsdCents: 0, keysAmount: 100),
      ];
      expect(validateSkuSet(skus).isValid, isFalse);
    });

    test('rejects a keys_pack with no keys_amount', () {
      final skus = [
        const SkuDef(id: 'a', type: SkuType.keysPack, priceUsdCents: 99),
      ];
      expect(validateSkuSet(skus).isValid, isFalse);
    });

    test('round-trips through JSON', () {
      const sku = SkuDef(id: 'keys_tier_1', type: SkuType.keysPack, priceUsdCents: 99, keysAmount: 100);
      final decoded = SkuDef.fromJson(sku.toJson());
      expect(decoded.id, sku.id);
      expect(decoded.type, sku.type);
      expect(decoded.keysAmount, 100);
    });
  });
}
