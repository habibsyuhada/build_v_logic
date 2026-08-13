import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../business/receipt_validator.dart';
import '../business/season_rollover.dart';
import '../business/server_content.dart';
import '../generated/protocol.dart';

/// Shop catalog + IAP purchase verification (§1.6, §2.4, §2.5).
///
/// [receiptValidator] defaults to [AlwaysRejectReceiptValidator] — this
/// environment has no live Google Play / App Store service-account
/// credentials to verify a real receipt against, and a validator that
/// silently approved everything would be a dangerous default to ship. A
/// real deployment swaps this for store-specific implementations; every
/// purchase submitted here is durably recorded either way (state
/// `verified` or `failed`), so nothing about the entitlement-granting path
/// downstream of verification needs to change when that swap happens.
class ShopEndpoint extends Endpoint {
  static ReceiptValidator receiptValidator = const AlwaysRejectReceiptValidator();

  Future<Player> _requirePlayer(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw NotAuthenticatedException();
    final player = await Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    if (player == null) throw NotAuthenticatedException();
    return player;
  }

  /// The product catalog (`content/shop.json`), as a JSON array —
  /// `content_schema.SkuDef` isn't a Serverpod-generated model, so it's
  /// serialized the same way virus/network defs are elsewhere in this
  /// API.
  Future<String> listSkus(Session session) async {
    final content = ServerContent.instance;
    return jsonEncode(content.skus.map((s) => s.toJson()).toList());
  }

  /// Submits a purchase for server-side verification. Always persists a
  /// [Purchase] row recording the outcome; only grants the entitlement
  /// (keys or battle pass premium) if verification succeeds.
  Future<Purchase> purchase(
    Session session, {
    required String sku,
    required String storeReceipt,
  }) async {
    final player = await _requirePlayer(session);
    final content = ServerContent.instance;
    final skuDef = content.skusById[sku];
    if (skuDef == null) throw SkuNotFoundException();

    final verification = await receiptValidator.verify(sku: sku, storeReceipt: storeReceipt);

    final purchase = await Purchase.db.insertRow(
      session,
      Purchase(
        playerId: player.id!,
        sku: sku,
        storeReceipt: storeReceipt,
        state: verification.isValid ? PurchaseState.verified : PurchaseState.failed,
        createdAt: DateTime.now(),
      ),
    );

    if (verification.isValid && skuDef.type.wireName == 'keys_pack') {
      await Player.db.updateRow(
        session,
        player.copyWith(keys: player.keys + (skuDef.keysAmount ?? 0)),
      );
    } else if (verification.isValid && skuDef.type.wireName == 'battle_pass_season') {
      await _grantPremiumTrack(session, player);
    }

    return purchase;
  }

  Future<void> _grantPremiumTrack(Session session, Player player) async {
    var season = await Season.db.findFirstRow(
      session,
      orderBy: (t) => t.endsAt,
      orderDescending: true,
    );
    if (season == null || SeasonRollover.isDue(now: DateTime.now(), seasonEndsAt: season.endsAt)) {
      final now = DateTime.now();
      season = await Season.db.insertRow(
        session,
        Season(startsAt: now, endsAt: SeasonRollover.nextSeasonEnd(seasonStartsAt: now)),
      );
    }

    final progress = await BattlePassProgress.db.findFirstRow(
      session,
      where: (t) => t.playerId.equals(player.id!) & t.seasonId.equals(season!.id!),
    );
    if (progress == null) {
      await BattlePassProgress.db.insertRow(
        session,
        BattlePassProgress(playerId: player.id!, seasonId: season.id!, hasPremium: true),
      );
    } else {
      await BattlePassProgress.db.updateRow(session, progress.copyWith(hasPremium: true));
    }
  }
}
