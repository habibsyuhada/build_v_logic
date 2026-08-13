import 'dart:convert';
import 'dart:io';

import 'package:content_schema/content_schema.dart';

/// Validates the JSON content tree against content_schema's validators.
///
/// Usage: dart run tools/content_lint/bin/content_lint.dart [content_dir]
/// Defaults to ./content relative to the current working directory.
/// Exit code 0 = valid (warnings allowed), 1 = validation errors found,
/// 2 = content tree missing/unreadable.
Future<void> main(List<String> args) async {
  final contentDir = Directory(args.isNotEmpty ? args[0] : 'content');
  if (!contentDir.existsSync()) {
    stderr.writeln('content_lint: no such directory ${contentDir.path}');
    exitCode = 2;
    return;
  }

  var hadErrors = false;
  var hadWarnings = false;

  void report(String label, ValidationResult result) {
    for (final e in result.errors) {
      stderr.writeln('ERROR [$label] $e');
      hadErrors = true;
    }
    for (final w in result.warnings) {
      stdout.writeln('WARN  [$label] $w');
      hadWarnings = true;
    }
  }

  final blocksFile = File('${contentDir.path}/blocks.json');
  Map<String, BlockDef> blockCatalog = {};
  if (blocksFile.existsSync()) {
    final raw = jsonDecode(await blocksFile.readAsString()) as List;
    final blocks = raw
        .map((e) => BlockDef.fromJson(e as Map<String, dynamic>))
        .toList();
    blockCatalog = {for (final b in blocks) b.id: b};
    report('blocks.json', validateBlockSet(blocks));
  } else {
    stderr.writeln('ERROR [blocks.json] file not found at ${blocksFile.path}');
    hadErrors = true;
  }

  final balanceFile = File('${contentDir.path}/balance.json');
  if (balanceFile.existsSync()) {
    final raw =
        jsonDecode(await balanceFile.readAsString()) as Map<String, dynamic>;
    report('balance.json', validateBalanceConfig(BalanceConfig.fromJson(raw)));
  } else {
    stdout.writeln('WARN  [balance.json] file not found, skipping');
    hadWarnings = true;
  }

  final networksDir = Directory('${contentDir.path}/networks');
  if (networksDir.existsSync()) {
    for (final entity in networksDir.listSync()) {
      if (entity is! File || !entity.path.endsWith('.json')) continue;
      final raw = jsonDecode(await entity.readAsString()) as Map<String, dynamic>;
      report(entity.path, validateNetwork(NetworkDef.fromJson(raw)));
    }
  }

  final missionsDir = Directory('${contentDir.path}/missions');
  final missions = <MissionDef>[];
  if (missionsDir.existsSync()) {
    for (final entity in missionsDir.listSync()) {
      if (entity is! File || !entity.path.endsWith('.json')) continue;
      final raw = jsonDecode(await entity.readAsString()) as Map<String, dynamic>;
      missions.add(MissionDef.fromJson(raw));
    }
    report('missions/', validateMissionSet(missions));
  }

  final shopFile = File('${contentDir.path}/shop.json');
  if (shopFile.existsSync()) {
    final raw = jsonDecode(await shopFile.readAsString()) as List;
    final skus = raw.map((e) => SkuDef.fromJson(e as Map<String, dynamic>)).toList();
    report('shop.json', validateSkuSet(skus));
  } else {
    stdout.writeln('WARN  [shop.json] file not found, skipping');
    hadWarnings = true;
  }

  if (blockCatalog.isNotEmpty) {
    final missionsGlob = Directory('${contentDir.path}/virus_examples');
    if (missionsGlob.existsSync()) {
      for (final entity in missionsGlob.listSync()) {
        if (entity is! File || !entity.path.endsWith('.json')) continue;
        final raw =
            jsonDecode(await entity.readAsString()) as Map<String, dynamic>;
        final virus = VirusDef.fromJson(raw);
        report(entity.path, validateDag(virus.program, blockCatalog: blockCatalog));
      }
    }
  }

  if (hadErrors) {
    stderr.writeln('content_lint: FAILED');
    exitCode = 1;
  } else {
    stdout.writeln(
        'content_lint: OK${hadWarnings ? ' (with warnings)' : ''}');
    exitCode = 0;
  }
}
