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
  '01_smart_drone_open_gate': 'fc421598fc5f33f87e521f503cf3e6d575b96f63d48078a9e490c14f782cf256',
  '02_smart_drone_firewalled_gate': 'a6834f3a192c74f302a2bdf910f57e1dcaafdbc9a7b6e091c7b85b5c356bdaab',
  '03_move_random_energy_death': 'f3709ce504e4cd9c5a292abc08bc7c7b5871ba829a956bf43f5efa0f5d8cef35',
  '04_wait_forever_tick_cap': '2fcde5a98f15e658204a09ec93a81fd057324a9744cd8d191adb89236c399bd5',
  '05_infinite_sensor_loop_stalls': '23f5f671f9f580215ec024f12e407cb6247cdb015fa604d7e11c66a84bad42e5',
  '06_self_destruct_immediately': '5f32a6fb8653e36fa32d2495f6c36025719a6902530aefa297bdb64c1eeac239',
  '07_replicate_forever_bounded': 'b0601dd5490dada3940a7e330fd850861f3902f2669717329fed4628954aa2b6',
  '08_random_split_move_or_wait': '4e1391f7c5c83a0805187ae7fbdc78487e5ad5806fdd8c01a415cd8469b1f74f',
  '09_defense_quarantine_catches_intruder':
      '9d81c0b4f360c5e203ddcca9801232f8ccac8e4943ab4f4d411a43949fc7bd1b',
  '10_defense_evaded_via_disguise': '161a7319cecc91c6e4f030210dc2ae5bcd32580caaeb73ad95d747489087b6c4',
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
