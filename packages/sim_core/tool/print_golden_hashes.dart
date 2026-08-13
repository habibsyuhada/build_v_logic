import 'dart:convert';
import 'dart:io';

import 'package:content_schema/content_schema.dart';
import 'package:crypto/crypto.dart';
import 'package:sim_core/sim_core.dart';
import 'package:sim_core/src/golden/golden_scenarios.dart';

/// Runs every golden scenario (§4.2) and prints `<name> <sha256>` lines.
/// CI runs this on each OS in the test matrix and diffs the output between
/// platforms (see .github/workflows/ci.yml) — any mismatch means sim_core
/// is not actually deterministic cross-platform, a release blocker.
///
/// Reads content/blocks.json + content/balance.json relative to the repo
/// root, so run it from there:
/// `dart run packages/sim_core/tool/print_golden_hashes.dart`.
void main() {
  final blockCatalog = (jsonDecode(File('content/blocks.json').readAsStringSync()) as List)
      .map((e) => BlockDef.fromJson(e as Map<String, dynamic>))
      .toList();
  final balance = BalanceConfig.fromJson(
      jsonDecode(File('content/balance.json').readAsStringSync()) as Map<String, dynamic>);

  for (final scenario in buildGoldenScenarios()) {
    final log = resolveBattle(
      network: scenario.network,
      virusDef: scenario.virusDef,
      balance: balance,
      blockCatalog: blockCatalog,
      seed: scenario.seed,
    );
    final hash = sha256.convert(utf8.encode(jsonEncode(log.toJson()))).toString();
    // ignore: avoid_print
    print('${scenario.name} $hash');
  }
}
