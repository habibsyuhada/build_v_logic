import 'package:payload_server/src/business/matchmaker.dart';
import 'package:test/test.dart';

void main() {
  test('returns null when there are no candidates at all', () {
    final result = Matchmaker.selectDefender(attackerRating: 1000, candidates: []);
    expect(result, isNull);
  });

  test('picks the closest-rated real candidate within range', () {
    final result = Matchmaker.selectDefender(
      attackerRating: 1000,
      candidates: const [
        DefenderCandidate(defenseId: 'far', rating: 1500),
        DefenderCandidate(defenseId: 'close', rating: 1050),
        DefenderCandidate(defenseId: 'closer-but-ghost', rating: 1010, isGhost: true),
      ],
    );
    expect(result!.defenseId, 'close');
  });

  test('falls back to a ghost when no real candidate is within range', () {
    final result = Matchmaker.selectDefender(
      attackerRating: 1000,
      maxRatingDelta: 50,
      candidates: const [
        DefenderCandidate(defenseId: 'far-real', rating: 2000),
        DefenderCandidate(defenseId: 'nearby-ghost', rating: 1030, isGhost: true),
      ],
    );
    expect(result!.defenseId, 'nearby-ghost');
    expect(result.isGhost, isTrue);
  });

  test('never returns null when ghosts exist, guaranteeing matchmaking is never empty', () {
    final result = Matchmaker.selectDefender(
      attackerRating: 5000, // wildly out of range of everything
      maxRatingDelta: 1,
      candidates: const [
        DefenderCandidate(defenseId: 'only-ghost', rating: 1000, isGhost: true),
      ],
    );
    expect(result, isNotNull);
  });

  test('prefers real over ghost when both are equally close', () {
    final result = Matchmaker.selectDefender(
      attackerRating: 1000,
      candidates: const [
        DefenderCandidate(defenseId: 'real', rating: 1010),
        DefenderCandidate(defenseId: 'ghost', rating: 1010, isGhost: true),
      ],
    );
    expect(result!.defenseId, 'real');
  });
}
