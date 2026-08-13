import 'package:payload_server/src/business/reverse_engineer_progress.dart';
import 'package:test/test.dart';

void main() {
  group('blocksRevealedFor', () {
    test('reveals one block per 3 replays watched', () {
      expect(ReverseEngineerProgress.blocksRevealedFor(replaysWatched: 0, totalBlocks: 10), 0);
      expect(ReverseEngineerProgress.blocksRevealedFor(replaysWatched: 2, totalBlocks: 10), 0);
      expect(ReverseEngineerProgress.blocksRevealedFor(replaysWatched: 3, totalBlocks: 10), 1);
      expect(ReverseEngineerProgress.blocksRevealedFor(replaysWatched: 8, totalBlocks: 10), 2);
    });

    test('caps at totalBlocks even with excess replays', () {
      expect(ReverseEngineerProgress.blocksRevealedFor(replaysWatched: 999, totalBlocks: 5), 5);
    });
  });

  group('isFullyRevealed', () {
    test('false before enough replays', () {
      expect(ReverseEngineerProgress.isFullyRevealed(replaysWatched: 5, totalBlocks: 2), isFalse);
    });

    test('true once enough replays have been watched', () {
      expect(ReverseEngineerProgress.isFullyRevealed(replaysWatched: 6, totalBlocks: 2), isTrue);
    });
  });

  group('replaysRemaining', () {
    test('counts down to zero', () {
      expect(ReverseEngineerProgress.replaysRemaining(replaysWatched: 4, totalBlocks: 2), 2);
    });

    test('never goes negative once fully revealed', () {
      expect(ReverseEngineerProgress.replaysRemaining(replaysWatched: 100, totalBlocks: 2), 0);
    });
  });
}
