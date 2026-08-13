enum SkuType {
  keysPack,
  battlePassSeason;

  static SkuType parse(String raw) {
    switch (raw) {
      case 'keys_pack':
        return SkuType.keysPack;
      case 'battle_pass_season':
        return SkuType.battlePassSeason;
      default:
        throw FormatException('Unknown sku type: $raw');
    }
  }

  String get wireName {
    switch (this) {
      case SkuType.keysPack:
        return 'keys_pack';
      case SkuType.battlePassSeason:
        return 'battle_pass_season';
    }
  }
}

/// One purchasable product (§1.6: "IAP: paket keys 5 tier + battle pass").
/// Content-as-data like everything else in `content/` — the store's
/// product catalog, never hardcoded, so a price/keys-amount tweak doesn't
/// need a client release.
class SkuDef {
  final String id;
  final SkuType type;
  final int priceUsdCents;

  /// Populated for [SkuType.keysPack]: how many premium `keys` this grants.
  final int? keysAmount;

  const SkuDef({
    required this.id,
    required this.type,
    required this.priceUsdCents,
    this.keysAmount,
  });

  factory SkuDef.fromJson(Map<String, dynamic> json) => SkuDef(
        id: json['id'] as String,
        type: SkuType.parse(json['type'] as String),
        priceUsdCents: json['price_usd_cents'] as int,
        keysAmount: json['keys_amount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.wireName,
        'price_usd_cents': priceUsdCents,
        if (keysAmount != null) 'keys_amount': keysAmount,
      };
}
