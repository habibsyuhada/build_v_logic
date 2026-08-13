/// Battle pass tier curve (§1.6: "progres dari XP battle"). Tier is
/// derived from `xp`, not stored — a tier-curve rebalance never needs a
/// data migration, matching the "no hardcoded balance numbers" principle
/// (this curve is the one exception baked into code rather than
/// `content/balance.json`, since it's presentation pacing, not gameplay
/// balance; revisit if LiveOps wants to hotfix it independently).
class BattlePassTierCalculator {
  static const int maxTier = 50;
  static const int xpPerTier = 1000;

  static int tierFor(int xp) {
    if (xp < 0) return 0;
    final tier = xp ~/ xpPerTier;
    return tier > maxTier ? maxTier : tier;
  }

  static int xpIntoCurrentTier(int xp) {
    if (xp < 0) return 0;
    if (tierFor(xp) >= maxTier) return 0;
    return xp % xpPerTier;
  }

  static bool isMaxTier(int xp) => tierFor(xp) >= maxTier;
}
