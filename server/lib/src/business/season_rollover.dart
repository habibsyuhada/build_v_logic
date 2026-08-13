/// One player's standing, used to compute season-end ranking.
class SeasonStanding {
  final String playerId;
  final int seasonRating;
  const SeasonStanding({required this.playerId, required this.seasonRating});
}

/// A ranked result, ready to persist as `SeasonResult` rows.
class RankedStanding {
  final String playerId;
  final int finalRating;
  final int rank; // 1-based, ties broken by stable input order
  const RankedStanding({required this.playerId, required this.finalRating, required this.rank});
}

/// Season lifecycle math (§1.5.2: "musim 4 minggu"). Pure — no
/// database/clock dependency (the caller supplies "now" and the standings
/// list), so rollover timing and ranking are both independently testable.
class SeasonRollover {
  static const Duration seasonLength = Duration(days: 28);

  static bool isDue({required DateTime now, required DateTime seasonEndsAt}) {
    return !now.isBefore(seasonEndsAt);
  }

  static DateTime nextSeasonEnd({required DateTime seasonStartsAt}) =>
      seasonStartsAt.add(seasonLength);

  /// Ranks standings highest-rating-first. Stable: equal ratings keep
  /// their relative input order rather than being reordered arbitrarily
  /// (explicit index tiebreaker, not relying on `List.sort`'s own
  /// stability guarantees).
  static List<RankedStanding> rank(List<SeasonStanding> standings) {
    final indexed = [for (var i = 0; i < standings.length; i++) (i, standings[i])];
    indexed.sort((a, b) {
      final byRating = b.$2.seasonRating.compareTo(a.$2.seasonRating);
      return byRating != 0 ? byRating : a.$1.compareTo(b.$1);
    });
    return [
      for (var i = 0; i < indexed.length; i++)
        RankedStanding(playerId: indexed[i].$2.playerId, finalRating: indexed[i].$2.seasonRating, rank: i + 1),
    ];
  }
}
