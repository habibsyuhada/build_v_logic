import 'package:payload_server/src/business/rating_calculator.dart';
import 'package:test/test.dart';

void main() {
  group('RatingCalculator.expectedScore', () {
    test('equal ratings give a 50% expected score', () {
      final e = RatingCalculator.expectedScore(rating: 1000, opponentRating: 1000);
      expect(e, closeTo(0.5, 0.001));
    });

    test('a much higher-rated attacker has a high expected score', () {
      final e = RatingCalculator.expectedScore(rating: 1400, opponentRating: 1000);
      expect(e, greaterThan(0.9));
    });

    test('a much lower-rated attacker has a low expected score', () {
      final e = RatingCalculator.expectedScore(rating: 600, opponentRating: 1000);
      expect(e, lessThan(0.1));
    });
  });

  group('RatingCalculator.kFactorFor', () {
    test('provisional players (few games) get the higher K', () {
      expect(RatingCalculator.kFactorFor(0), RatingCalculator.kProvisional);
      expect(RatingCalculator.kFactorFor(9), RatingCalculator.kProvisional);
    });

    test('established players get the lower K', () {
      expect(RatingCalculator.kFactorFor(10), RatingCalculator.kEstablished);
      expect(RatingCalculator.kFactorFor(500), RatingCalculator.kEstablished);
    });
  });

  group('RatingCalculator.attackerRatingDelta', () {
    test('an even matchup win gains roughly half of K', () {
      final delta = RatingCalculator.attackerRatingDelta(
        attackerRating: 1000,
        defenderRating: 1000,
        attackerGamesPlayed: 100,
        attackerWon: true,
      );
      expect(delta, closeTo(RatingCalculator.kEstablished / 2, 1));
      expect(delta, greaterThan(0));
    });

    test('an even matchup loss loses roughly half of K', () {
      final delta = RatingCalculator.attackerRatingDelta(
        attackerRating: 1000,
        defenderRating: 1000,
        attackerGamesPlayed: 100,
        attackerWon: false,
      );
      expect(delta, lessThan(0));
    });

    test('beating a much higher-rated defender gains close to the full K', () {
      final delta = RatingCalculator.attackerRatingDelta(
        attackerRating: 800,
        defenderRating: 1400,
        attackerGamesPlayed: 100,
        attackerWon: true,
      );
      expect(delta, greaterThan(RatingCalculator.kEstablished * 0.9));
    });

    test('losing to a much lower-rated defender loses close to the full K', () {
      final delta = RatingCalculator.attackerRatingDelta(
        attackerRating: 1400,
        defenderRating: 800,
        attackerGamesPlayed: 100,
        attackerWon: false,
      );
      expect(delta, lessThan(-RatingCalculator.kEstablished * 0.9));
    });

    test('a provisional player swings by a larger K', () {
      final provisionalDelta = RatingCalculator.attackerRatingDelta(
        attackerRating: 1000,
        defenderRating: 1000,
        attackerGamesPlayed: 1,
        attackerWon: true,
      );
      final establishedDelta = RatingCalculator.attackerRatingDelta(
        attackerRating: 1000,
        defenderRating: 1000,
        attackerGamesPlayed: 1000,
        attackerWon: true,
      );
      expect(provisionalDelta, greaterThan(establishedDelta));
    });
  });
}
