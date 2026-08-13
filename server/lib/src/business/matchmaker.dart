/// One candidate defense the matchmaker can pick from — either a live
/// player's defense or a ghost-network snapshot (§1.5.3: "bot defender
/// yang meniru snapshot pertahanan pemain nyata (anonymized) supaya
/// matchmaking tidak pernah kosong sejak hari pertama").
class DefenderCandidate {
  final String defenseId;
  final int rating;
  final bool isGhost;

  const DefenderCandidate({required this.defenseId, required this.rating, this.isGhost = false});
}

/// Picks an opponent by rating proximity (§1.5: "matchmaking berdasar
/// rating"). Pure function over a candidate list — real matchmaking would
/// build that list from a live-player query first, and only fall back to
/// ghost snapshots, which this function models directly so it doesn't need
/// a database to be tested.
class Matchmaker {
  /// Prefers the closest-rated *real* candidate within [maxRatingDelta];
  /// falls back to the closest-rated ghost candidate (any distance) so a
  /// match is never empty; returns null only if [candidates] is empty.
  static DefenderCandidate? selectDefender({
    required int attackerRating,
    required List<DefenderCandidate> candidates,
    int maxRatingDelta = 200,
  }) {
    if (candidates.isEmpty) return null;

    int distance(DefenderCandidate c) => (c.rating - attackerRating).abs();

    final realWithinRange = candidates.where((c) => !c.isGhost && distance(c) <= maxRatingDelta).toList()
      ..sort((a, b) => distance(a).compareTo(distance(b)));
    if (realWithinRange.isNotEmpty) return realWithinRange.first;

    final sorted = List<DefenderCandidate>.of(candidates)
      ..sort((a, b) => distance(a).compareTo(distance(b)));
    return sorted.first;
  }
}
