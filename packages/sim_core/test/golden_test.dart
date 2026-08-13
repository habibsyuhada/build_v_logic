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
  '01_smart_drone_open_gate': '62aef44850a5bc77bb4e830a5d829cc50ffb30292c681af76c430fe5cf579916',
  '02_smart_drone_firewalled_gate': 'ba6451a21aa0f9f242a61741525bed115c0a1b911efc7e339e776af2afe5f9fc',
  '03_move_random_energy_death': '6c9faf0c31939e1f82ee342c3602bad9d00333964735d06e3f58937cd3529a1b',
  '04_wait_forever_tick_cap': '80d4107d809fb935f909f28e52e6a5c930d98b46b89767f9d588877dfdb86309',
  '05_infinite_sensor_loop_stalls': '9874d80107672e835fa3d605e55cae6597998bb0b8157f997318c870167ab9fe',
  '06_self_destruct_immediately': '83fa024da2773b18f8b79be4efb8782c5815ec564db934b525177e1ce80e7e57',
  '07_replicate_forever_bounded': '9d955e10e41c4053f793a5e649942fa30c6606cd7f38e74b49140c4a991ca12e',
  '08_random_split_move_or_wait': '474f943a2d96c4bd9bebe6f226e78ce06844f9d28488d040666b6d2dbf663931',
  '09_defense_quarantine_catches_intruder':
      '22d0caac9584a90a214cde0130cca73d707ac68cd36a8bd24ce5b59405864cba',
  '10_defense_evaded_via_disguise': '886611a7dd7112d1e360f8c0604924d96da44338e50fdef3ba7a3f32e5b5a580',
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
