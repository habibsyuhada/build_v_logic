import 'package:sim_core/sim_core.dart';
import 'package:test/test.dart';

void main() {
  group('Xoshiro128', () {
    test('same seed produces the same sequence', () {
      final a = Xoshiro128(42);
      final b = Xoshiro128(42);
      final seqA = List.generate(50, (_) => a.nextRaw());
      final seqB = List.generate(50, (_) => b.nextRaw());
      expect(seqA, equals(seqB));
    });

    test('different seeds produce different sequences', () {
      final a = Xoshiro128(1);
      final b = Xoshiro128(2);
      final seqA = List.generate(20, (_) => a.nextRaw());
      final seqB = List.generate(20, (_) => b.nextRaw());
      expect(seqA, isNot(equals(seqB)));
    });

    test('nextInt stays within bound', () {
      final rng = Xoshiro128(7);
      for (var i = 0; i < 1000; i++) {
        final v = rng.nextInt(10);
        expect(v, greaterThanOrEqualTo(0));
        expect(v, lessThan(10));
      }
    });

    test('chancePercent(0) is always false, chancePercent(100) is always true', () {
      final rng = Xoshiro128(99);
      for (var i = 0; i < 200; i++) {
        expect(rng.chancePercent(0), isFalse);
      }
      for (var i = 0; i < 200; i++) {
        expect(rng.chancePercent(100), isTrue);
      }
    });

    test('raw values are always non-negative 32-bit', () {
      final rng = Xoshiro128(1234);
      for (var i = 0; i < 500; i++) {
        final v = rng.nextRaw();
        expect(v, greaterThanOrEqualTo(0));
        expect(v, lessThanOrEqualTo(0xFFFFFFFF));
      }
    });
  });
}
