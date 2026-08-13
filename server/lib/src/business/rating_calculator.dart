import 'dart:math' as math;

/// Elo-like PvP rating (§1.5 "matchmaking berdasar rating (Elo-like, K
/// disesuaikan)"). Pure function, no database/session dependency, so it's
/// fully unit-testable.
///
/// K starts high for new/volatile players and settles once a player has
/// played enough games — the "K disesuaikan" the plan calls for.
class RatingCalculator {
  static const int kProvisional = 40;
  static const int kEstablished = 20;

  /// Games played (by either side) below which a player is "provisional"
  /// and swings the K-factor higher.
  static const int provisionalGameThreshold = 10;

  static int kFactorFor(int gamesPlayed) =>
      gamesPlayed < provisionalGameThreshold ? kProvisional : kEstablished;

  /// Standard Elo expected-score formula.
  static double expectedScore({required int rating, required int opponentRating}) {
    final exponent = (opponentRating - rating) / 400.0;
    return 1.0 / (1.0 + math.pow(10, exponent));
  }

  /// Rating delta for the attacker (the defender's delta is the negation,
  /// since exactly one rating pool moves between the two — no rating is
  /// created or destroyed by a single battle).
  ///
  /// [attackerWon] is a plain win/loss signal (draws aren't part of PvP
  /// ladder battles per §1.2's battle model — every battle ends with the
  /// virus either exfiltrating/surviving or not).
  static int attackerRatingDelta({
    required int attackerRating,
    required int defenderRating,
    required int attackerGamesPlayed,
    required bool attackerWon,
  }) {
    final expected = expectedScore(rating: attackerRating, opponentRating: defenderRating);
    final actual = attackerWon ? 1.0 : 0.0;
    final k = kFactorFor(attackerGamesPlayed);
    return (k * (actual - expected)).round();
  }
}
