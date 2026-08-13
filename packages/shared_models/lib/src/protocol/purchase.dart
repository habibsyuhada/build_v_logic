/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'purchase_state.dart' as _i2;
import 'player.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// One IAP purchase (§2.4 `purchases`, §2.5: "verifikasi receipt
/// server-side"). The receipt is always re-verified against the store's
/// own API server-side — never trusted from the client's stated
/// price/SKU. See `ReceiptValidator` for the (store-credential-gated)
/// verification seam.
abstract class Purchase implements _i1.SerializableModel {
  Purchase._({
    this.id,
    required this.playerId,
    this.player,
    required this.sku,
    required this.storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) : state = state ?? _i2.PurchaseState.pending,
       createdAt = createdAt ?? DateTime.now();

  factory Purchase({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String sku,
    required String storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) = _PurchaseImpl;

  factory Purchase.fromJson(Map<String, dynamic> jsonSerialization) {
    return Purchase(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Player>(jsonSerialization['player']),
      sku: jsonSerialization['sku'] as String,
      storeReceipt: jsonSerialization['storeReceipt'] as String,
      state: jsonSerialization['state'] == null
          ? null
          : _i2.PurchaseState.fromJson((jsonSerialization['state'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i3.Player? player;

  /// content/shop.json SkuDef id.
  String sku;

  String storeReceipt;

  _i2.PurchaseState state;

  DateTime createdAt;

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Purchase copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i3.Player? player,
    String? sku,
    String? storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Purchase',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'sku': sku,
      'storeReceipt': storeReceipt,
      'state': state.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseImpl extends Purchase {
  _PurchaseImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String sku,
    required String storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         sku: sku,
         storeReceipt: storeReceipt,
         state: state,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Purchase copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? sku,
    String? storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) {
    return Purchase(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i3.Player? ? player : this.player?.copyWith(),
      sku: sku ?? this.sku,
      storeReceipt: storeReceipt ?? this.storeReceipt,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
