import 'package:payload_server/src/business/battle_pass_tier_calculator.dart';
import 'package:test/test.dart';

void main() {
  group('tierFor', () {
    test('0 xp is tier 0', () {
      expect(BattlePassTierCalculator.tierFor(0), 0);
    });

    test('negative xp clamps to tier 0', () {
      expect(BattlePassTierCalculator.tierFor(-100), 0);
    });

    test('advances one tier per 1000 xp', () {
      expect(BattlePassTierCalculator.tierFor(999), 0);
      expect(BattlePassTierCalculator.tierFor(1000), 1);
      expect(BattlePassTierCalculator.tierFor(2500), 2);
    });

    test('caps at maxTier', () {
      expect(BattlePassTierCalculator.tierFor(999999), BattlePassTierCalculator.maxTier);
    });
  });

  group('xpIntoCurrentTier', () {
    test('is the remainder within the current tier', () {
      expect(BattlePassTierCalculator.xpIntoCurrentTier(1250), 250);
    });

    test('negative xp yields 0', () {
      expect(BattlePassTierCalculator.xpIntoCurrentTier(-5), 0);
    });

    test('is 0 once at max tier', () {
      final maxXp = BattlePassTierCalculator.maxTier * BattlePassTierCalculator.xpPerTier + 500;
      expect(BattlePassTierCalculator.xpIntoCurrentTier(maxXp), 0);
    });
  });

  group('isMaxTier', () {
    test('false below the cap', () {
      expect(BattlePassTierCalculator.isMaxTier(1000), isFalse);
    });

    test('true at and beyond the cap', () {
      final capXp = BattlePassTierCalculator.maxTier * BattlePassTierCalculator.xpPerTier;
      expect(BattlePassTierCalculator.isMaxTier(capXp), isTrue);
      expect(BattlePassTierCalculator.isMaxTier(capXp + 5000), isTrue);
    });
  });
}
