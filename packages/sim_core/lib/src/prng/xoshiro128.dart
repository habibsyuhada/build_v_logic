const int _mask32 = 0xFFFFFFFF;

int _rotl32(int x, int k) {
  return ((x << k) | (x >> (32 - k))) & _mask32;
}

/// splitmix32 — used only to expand a single 32-bit seed into the four
/// 32-bit words xoshiro128** needs, avoiding the all-zero state.
class _SplitMix32 {
  int _state;
  _SplitMix32(int seed) : _state = seed & _mask32;

  int next() {
    _state = (_state + 0x9E3779B9) & _mask32;
    var z = _state;
    z = ((z ^ (z >> 15)) * 0x85EBCA6B) & _mask32;
    z = ((z ^ (z >> 13)) * 0xC2B2AE35) & _mask32;
    return (z ^ (z >> 16)) & _mask32;
  }
}

/// Deterministic seeded PRNG (§3.1, §2.3): xoshiro128**, 32-bit state,
/// integer-only arithmetic so results are bit-identical across platforms
/// running the same Dart SDK (no `double`, per §3.1's determinism rules).
///
/// The seed is stored on the battle record (§2.3) so any battle can be
/// replayed byte-for-byte.
class Xoshiro128 {
  final List<int> _s;

  Xoshiro128._(this._s);

  factory Xoshiro128(int seed) {
    final sm = _SplitMix32(seed);
    final s = List<int>.filled(4, 0);
    for (var i = 0; i < 4; i++) {
      s[i] = sm.next();
    }
    return Xoshiro128._(s);
  }

  /// Next raw 32-bit unsigned value.
  int nextRaw() {
    final result = (_rotl32((_s[1] * 5) & _mask32, 7) * 9) & _mask32;
    final t = (_s[1] << 9) & _mask32;

    _s[2] ^= _s[0];
    _s[3] ^= _s[1];
    _s[1] ^= _s[2];
    _s[0] ^= _s[3];
    _s[2] ^= t;
    _s[3] = _rotl32(_s[3], 11);

    return result;
  }

  /// Uniform integer in `[0, bound)`. `bound` must be > 0 and <= 2^32.
  /// Uses Lemire's rejection-free-ish modulo reduction; small modulo bias
  /// is acceptable for gameplay randomness and stays fully deterministic.
  int nextInt(int bound) {
    assert(bound > 0);
    return nextRaw() % bound;
  }

  /// True with probability `percent`/100 (percent clamped to [0, 100]).
  bool chancePercent(int percent) {
    final p = percent.clamp(0, 100);
    return nextInt(100) < p;
  }
}
