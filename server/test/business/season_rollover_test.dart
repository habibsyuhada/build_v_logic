import 'package:payload_server/src/business/season_rollover.dart';
import 'package:test/test.dart';

void main() {
  group('isDue', () {
    test('false before the season end time', () {
      final ends = DateTime.utc(2026, 9, 1);
      expect(SeasonRollover.isDue(now: DateTime.utc(2026, 8, 31), seasonEndsAt: ends), isFalse);
    });

    test('true at or after the season end time', () {
      final ends = DateTime.utc(2026, 9, 1);
      expect(SeasonRollover.isDue(now: ends, seasonEndsAt: ends), isTrue);
      expect(SeasonRollover.isDue(now: DateTime.utc(2026, 9, 2), seasonEndsAt: ends), isTrue);
    });
  });

  test('nextSeasonEnd adds 28 days to the start', () {
    final start = DateTime.utc(2026, 8, 13);
    expect(SeasonRollover.nextSeasonEnd(seasonStartsAt: start), DateTime.utc(2026, 9, 10));
  });

  group('rank', () {
    test('orders standings highest rating first', () {
      final ranked = SeasonRollover.rank(const [
        SeasonStanding(playerId: 'a', seasonRating: 1200),
        SeasonStanding(playerId: 'b', seasonRating: 1500),
        SeasonStanding(playerId: 'c', seasonRating: 1300),
      ]);
      expect(ranked.map((r) => r.playerId).toList(), ['b', 'c', 'a']);
      expect(ranked.map((r) => r.rank).toList(), [1, 2, 3]);
    });

    test('breaks ties by original input order', () {
      final ranked = SeasonRollover.rank(const [
        SeasonStanding(playerId: 'first', seasonRating: 1000),
        SeasonStanding(playerId: 'second', seasonRating: 1000),
      ]);
      expect(ranked.map((r) => r.playerId).toList(), ['first', 'second']);
    });

    test('preserves each standing\'s final rating', () {
      final ranked = SeasonRollover.rank(const [
        SeasonStanding(playerId: 'a', seasonRating: 1750),
      ]);
      expect(ranked.single.finalRating, 1750);
    });

    test('empty input yields empty output', () {
      expect(SeasonRollover.rank(const []), isEmpty);
    });
  });
}
