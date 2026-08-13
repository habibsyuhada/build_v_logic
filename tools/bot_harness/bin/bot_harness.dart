import 'dart:convert';
import 'dart:io';

import 'package:bot_harness/archetypes.dart';
import 'package:bot_harness/topologies.dart';
import 'package:content_schema/content_schema.dart';
import 'package:sim_core/sim_core.dart';

/// Bot-vs-bot balance regression harness (§4.3): 3 archetypes x 12
/// topologies x N seeds (default 1000) -> win-rate & average-score report.
/// Target: no archetype's global win-rate should sit above 60% or below
/// 40%. Run this after any `content/blocks.json` change.
///
/// Usage: dart run tools/bot_harness/bin/bot_harness.dart [--seeds=1000]
Future<void> main(List<String> args) async {
  var seedsPerPair = 1000;
  for (final arg in args) {
    if (arg.startsWith('--seeds=')) {
      seedsPerPair = int.parse(arg.substring('--seeds='.length));
    }
  }

  final blockCatalog = (jsonDecode(File('content/blocks.json').readAsStringSync()) as List)
      .map((e) => BlockDef.fromJson(e as Map<String, dynamic>))
      .toList();
  final balance = BalanceConfig.fromJson(
      jsonDecode(File('content/balance.json').readAsStringSync()) as Map<String, dynamic>);
  final topologies = buildTopologies();

  stdout.writeln(
      'bot_harness: ${allArchetypes.length} archetypes x ${topologies.length} topologies x $seedsPerPair seeds');

  final globalWins = <String, int>{};
  final globalRuns = <String, int>{};
  final globalScoreSum = <String, int>{};

  for (final archetype in allArchetypes) {
    globalWins[archetype.name] = 0;
    globalRuns[archetype.name] = 0;
    globalScoreSum[archetype.name] = 0;

    stdout.writeln('\n== ${archetype.name} ==');
    for (final topology in topologies) {
      var wins = 0;
      var scoreSum = 0;
      for (var s = 0; s < seedsPerPair; s++) {
        final seed = _seedFor(archetype.name, topology.id, s);
        final log = resolveBattle(
          network: topology,
          virusDef: VirusDef(program: archetype.program),
          balance: balance,
          blockCatalog: blockCatalog,
          seed: seed,
        );
        final won = log.result.dataExfiltrated > 0;
        if (won) wins++;
        scoreSum += log.result.score;
      }
      globalWins[archetype.name] = globalWins[archetype.name]! + wins;
      globalRuns[archetype.name] = globalRuns[archetype.name]! + seedsPerPair;
      globalScoreSum[archetype.name] = globalScoreSum[archetype.name]! + scoreSum;

      final winRate = wins * 100 / seedsPerPair;
      final avgScore = scoreSum / seedsPerPair;
      stdout.writeln(
          '  ${topology.id}: win-rate ${winRate.toStringAsFixed(1)}%  avg-score ${avgScore.toStringAsFixed(1)}');
    }
  }

  stdout.writeln('\n== Global summary ==');
  var anyOutOfBand = false;
  for (final archetype in allArchetypes) {
    final runs = globalRuns[archetype.name]!;
    final winRate = globalWins[archetype.name]! * 100 / runs;
    final avgScore = globalScoreSum[archetype.name]! / runs;
    final outOfBand = winRate > 60 || winRate < 40;
    if (outOfBand) anyOutOfBand = true;
    stdout.writeln(
        '${archetype.name}: global win-rate ${winRate.toStringAsFixed(1)}%  avg-score ${avgScore.toStringAsFixed(1)}'
        '${outOfBand ? '  <-- OUT OF 40-60% BAND (§4.3)' : ''}');
  }

  if (anyOutOfBand) {
    stdout.writeln('\nbot_harness: FAILED balance target (§4.3) — see archetypes above.');
    exitCode = 1;
  } else {
    stdout.writeln('\nbot_harness: OK — all archetypes within the 40-60% win-rate band.');
    exitCode = 0;
  }
}

/// Deterministic per-(archetype,topology,index) seed derivation so the
/// whole report is itself reproducible.
int _seedFor(String archetypeName, String topologyId, int index) {
  var hash = 17;
  for (final code in archetypeName.codeUnits) {
    hash = (hash * 31 + code) & 0x7fffffff;
  }
  for (final code in topologyId.codeUnits) {
    hash = (hash * 31 + code) & 0x7fffffff;
  }
  hash = (hash * 31 + index) & 0x7fffffff;
  return hash;
}
