import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../business/content_version.dart';
import '../business/server_content.dart';

/// Remote config delivery (§2.1 "content as data ... bisa dipush via
/// remote config tanpa app update", §5 Phase 6 "remote config"). A client
/// polls [currentVersion] against its cached version and only calls
/// [fetchBundle] when they differ — a balance/content push then reaches
/// players without an app store release.
class ContentEndpoint extends Endpoint {
  Future<String> currentVersion(Session session) async {
    final content = ServerContent.instance;
    return ContentVersion.hashFor(
      blocksJson: jsonEncode(content.blocks.map((b) => b.toJson()).toList()),
      balanceJson: jsonEncode(content.balance.toJson()),
      shopJson: jsonEncode(content.skus.map((s) => s.toJson()).toList()),
    );
  }

  /// The full content bundle plus its version, as a single JSON blob —
  /// same "content_schema types aren't Serverpod models" reasoning as
  /// `ShopEndpoint.listSkus`.
  Future<String> fetchBundle(Session session) async {
    final content = ServerContent.instance;
    final blocksJson = jsonEncode(content.blocks.map((b) => b.toJson()).toList());
    final balanceJson = jsonEncode(content.balance.toJson());
    final shopJson = jsonEncode(content.skus.map((s) => s.toJson()).toList());
    return jsonEncode({
      'version': ContentVersion.hashFor(
        blocksJson: blocksJson,
        balanceJson: balanceJson,
        shopJson: shopJson,
      ),
      'blocks': jsonDecode(blocksJson),
      'balance': jsonDecode(balanceJson),
      'shop': jsonDecode(shopJson),
    });
  }
}
