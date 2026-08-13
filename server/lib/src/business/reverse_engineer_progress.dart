/// Reverse-engineer mechanics (§1.5.4): watching a blueprint's replay 3x
/// reveals one block. Pure function over counts, no database dependency.
class ReverseEngineerProgress {
  static const int replaysPerBlock = 3;

  /// How many blocks are revealed after [replaysWatched] replays, capped
  /// at [totalBlocks] (watching more replays than needed does nothing
  /// further).
  static int blocksRevealedFor({required int replaysWatched, required int totalBlocks}) {
    final revealed = replaysWatched ~/ replaysPerBlock;
    return revealed > totalBlocks ? totalBlocks : revealed;
  }

  static bool isFullyRevealed({required int replaysWatched, required int totalBlocks}) {
    return blocksRevealedFor(replaysWatched: replaysWatched, totalBlocks: totalBlocks) >=
        totalBlocks;
  }

  /// Replays still needed before the design can be copied.
  static int replaysRemaining({required int replaysWatched, required int totalBlocks}) {
    final needed = totalBlocks * replaysPerBlock;
    final remaining = needed - replaysWatched;
    return remaining > 0 ? remaining : 0;
  }
}
