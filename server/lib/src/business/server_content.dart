import 'dart:convert';
import 'dart:io';

import 'package:content_schema/content_schema.dart';

/// Loads the server's own copy of `content/blocks.json` +
/// `content/balance.json` (§2.6 "content as data") — the canonical
/// catalog every battle is validated and resolved against.
///
/// Kept as a small lazily-initialized singleton rather than threaded
/// through every endpoint constructor: it's read-only, process-wide
/// config, exactly like `Serverpod`'s own `pod.config`. A future
/// remote-config sync (§2.6) would refresh this in place without changing
/// any call site.
class ServerContent {
  final List<BlockDef> blocks;
  final Map<String, BlockDef> blocksById;
  final BalanceConfig balance;
  final List<SkuDef> skus;
  final Map<String, SkuDef> skusById;

  ServerContent._({required this.blocks, required this.balance, required this.skus})
      : blocksById = {for (final b in blocks) b.id: b},
        skusById = {for (final s in skus) s.id: s};

  static ServerContent? _instance;

  static ServerContent get instance {
    final existing = _instance;
    if (existing != null) return existing;
    return _instance = _load();
  }

  /// Test-only hook to inject a fixture catalog instead of reading files.
  static void setForTesting(ServerContent content) => _instance = content;

  static ServerContent _load({String contentDir = 'content'}) {
    final blocksRaw = jsonDecode(File('$contentDir/blocks.json').readAsStringSync()) as List;
    final blocks =
        blocksRaw.map((e) => BlockDef.fromJson(e as Map<String, dynamic>)).toList();

    final balanceRaw =
        jsonDecode(File('$contentDir/balance.json').readAsStringSync()) as Map<String, dynamic>;
    final balance = BalanceConfig.fromJson(balanceRaw);

    final skusRaw = jsonDecode(File('$contentDir/shop.json').readAsStringSync()) as List;
    final skus = skusRaw.map((e) => SkuDef.fromJson(e as Map<String, dynamic>)).toList();

    return ServerContent._(blocks: blocks, balance: balance, skus: skus);
  }

  factory ServerContent.forTesting({
    required List<BlockDef> blocks,
    required BalanceConfig balance,
    List<SkuDef> skus = const [],
  }) =>
      ServerContent._(blocks: blocks, balance: balance, skus: skus);
}
