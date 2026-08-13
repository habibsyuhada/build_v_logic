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
import 'player.dart' as _i2;
import 'package:shared_models/src/protocol/protocol.dart' as _i3;

/// A block a player has unlocked (§2.4 `unlocks`), via campaign mission
/// completion (see app's CampaignController for the client-side mirror of
/// this table, kept in sync once cloud-sync lands).
abstract class Unlock implements _i1.SerializableModel {
  Unlock._({
    this.id,
    required this.playerId,
    this.player,
    required this.blockId,
    DateTime? unlockedAt,
  }) : unlockedAt = unlockedAt ?? DateTime.now();

  factory Unlock({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String blockId,
    DateTime? unlockedAt,
  }) = _UnlockImpl;

  factory Unlock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Unlock(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      blockId: jsonSerialization['blockId'] as String,
      unlockedAt: jsonSerialization['unlockedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['unlockedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  /// content/blocks.json block id.
  String blockId;

  DateTime unlockedAt;

  /// Returns a shallow copy of this [Unlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Unlock copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? blockId,
    DateTime? unlockedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Unlock',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'blockId': blockId,
      'unlockedAt': unlockedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UnlockImpl extends Unlock {
  _UnlockImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String blockId,
    DateTime? unlockedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         blockId: blockId,
         unlockedAt: unlockedAt,
       );

  /// Returns a shallow copy of this [Unlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Unlock copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? blockId,
    DateTime? unlockedAt,
  }) {
    return Unlock(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      blockId: blockId ?? this.blockId,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}
