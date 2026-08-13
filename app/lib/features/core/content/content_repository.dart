import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:flutter/services.dart' show AssetBundle;

/// Loads `content/*.json` (§2.2, §2.6 "content as data") from the app's
/// asset bundle. A day-one PvE/offline install ships a baked-in snapshot;
/// Phase 4+ adds a remote-config sync layer on top without changing this
/// interface.
class ContentRepository {
  final List<BlockDef> blocks;
  final Map<String, BlockDef> blocksById;
  final BalanceConfig balance;
  final NetworkDef trainingNetwork;

  ContentRepository._({
    required this.blocks,
    required this.balance,
    required this.trainingNetwork,
  }) : blocksById = {for (final b in blocks) b.id: b};

  static Future<ContentRepository> load(AssetBundle bundle) async {
    final blocksRaw = jsonDecode(await bundle.loadString('assets/content/blocks.json')) as List;
    final blocks =
        blocksRaw.map((e) => BlockDef.fromJson(e as Map<String, dynamic>)).toList();

    final balanceRaw =
        jsonDecode(await bundle.loadString('assets/content/balance.json')) as Map<String, dynamic>;
    final balance = BalanceConfig.fromJson(balanceRaw);

    final networkRaw = jsonDecode(
            await bundle.loadString('assets/content/networks/training_01.json'))
        as Map<String, dynamic>;
    final trainingNetwork = NetworkDef.fromJson(networkRaw);

    return ContentRepository._(blocks: blocks, balance: balance, trainingNetwork: trainingNetwork);
  }

  /// Bypasses asset loading — for tests that don't want a real asset
  /// bundle in the loop.
  factory ContentRepository.forTesting({
    required List<BlockDef> blocks,
    required BalanceConfig balance,
    required NetworkDef trainingNetwork,
  }) =>
      ContentRepository._(blocks: blocks, balance: balance, trainingNetwork: trainingNetwork);

  List<BlockDef> byFamily(BlockFamily family) =>
      blocks.where((b) => b.family == family).toList(growable: false);
}
