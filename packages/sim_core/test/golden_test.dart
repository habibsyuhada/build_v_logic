import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sim_core/sim_core.dart';
import 'package:sim_core/src/golden/golden_scenarios.dart';
import 'package:test/test.dart';

import 'support/fixtures.dart';

/// Golden determinism gate (§4.2): 10 fixed scenarios, each pinned to the
/// SHA-256 hash of its full BattleLog JSON. A hash change here means
/// `resolveBattle`'s output changed for that scenario — either an
/// intentional balance/behavior change (update the hash consciously) or a
/// determinism regression (do not update the hash; fix the bug instead).
///
/// `tool/print_golden_hashes.dart` runs the same scenarios and is what CI
/// diffs between ubuntu-latest and macos-latest to catch cross-platform
/// nondeterminism (see .github/workflows/ci.yml).
const Map<String, String> expectedGoldenHashes = {
  '01_smart_drone_open_gate': '1bbbea3d66f1c1232404f7f8e505e213c24678b9d3d24cb7e8b0da76e3639579',
  '02_smart_drone_firewalled_gate': 'ec6b19c95205ae7820009915765ea2e2104d17ee8c682b0796e0ecedf4bca686',
  '03_move_random_energy_death': '3298d357ff3213767a8a78b947ad414642b076bb3b49db810ffa18e066cdc21e',
  '04_wait_forever_tick_cap': '2fcde5a98f15e658204a09ec93a81fd057324a9744cd8d191adb89236c399bd5',
  '05_infinite_sensor_loop_stalls': '23f5f671f9f580215ec024f12e407cb6247cdb015fa604d7e11c66a84bad42e5',
  '06_self_destruct_immediately': '5f32a6fb8653e36fa32d2495f6c36025719a6902530aefa297bdb64c1eeac239',
  '07_replicate_forever_bounded': 'ecb34fefadc574c239de601cb3b5a74d60ada29f1a2231ce4830a284281ab16f',
  '08_random_split_move_or_wait': '2a50b7da8c283849cc1d442f2822017ef2d6f66293412bc0a0c9a982824b66ca',
  '09_defense_quarantine_catches_intruder':
      '8777ad8a869428dc94d2421cb728b7f65943d3e753141fb4168bdea20b38847a',
  '10_defense_evaded_via_disguise': 'c335a486d185e2c5cdf2b94d9313c0629cb484f5e20f32a2658814714d3daebb',
};

void main() {
  final catalog = loadRealBlockCatalog();
  final balance = loadRealBalanceConfig();
  final scenarios = buildGoldenScenarios();

  test('golden scenario set has exactly the 10 scenarios required by §5 Phase 1 AC', () {
    expect(scenarios.length, 10);
    expect(scenarios.map((s) => s.name).toSet().length, 10, reason: 'scenario names must be unique');
  });

  for (final scenario in scenarios) {
    test('golden: ${scenario.name}', () {
      final log = resolveBattle(
        network: scenario.network,
        virusDef: scenario.virusDef,
        balance: balance,
        blockCatalog: catalog,
        seed: scenario.seed,
      );
      final encoded = jsonEncode(log.toJson());
      final hash = sha256.convert(utf8.encode(encoded)).toString();

      final expected = expectedGoldenHashes[scenario.name];
      expect(expected, isNotNull, reason: 'no pinned hash for ${scenario.name}');
      expect(hash, expected,
          reason: 'Golden hash mismatch for ${scenario.name}. If this change is '
              'intentional (balance/behavior update), regenerate with '
              '`dart run packages/sim_core/tool/print_golden_hashes.dart` and update '
              'expectedGoldenHashes. If not, sim_core has a determinism regression.');
    });
  }

  test('resolving the same scenario twice is byte-identical (sanity check under this run)', () {
    for (final scenario in scenarios) {
      final a = resolveBattle(
        network: scenario.network,
        virusDef: scenario.virusDef,
        balance: balance,
        blockCatalog: catalog,
        seed: scenario.seed,
      );
      final b = resolveBattle(
        network: scenario.network,
        virusDef: scenario.virusDef,
        balance: balance,
        blockCatalog: catalog,
        seed: scenario.seed,
      );
      expect(jsonEncode(a.toJson()), jsonEncode(b.toJson()), reason: scenario.name);
    }
  });
}
