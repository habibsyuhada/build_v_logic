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
import 'blueprint.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// One player's reverse-engineer progress on one blueprint (§1.5.4:
/// "reverse-engineer: replay virus tersebut 3x untuk 'membaca' 1 blok").
/// `blocksRevealed` grows by one every [replaysPerBlock] replays watched;
/// once it reaches the blueprint's full block count, the player may copy
/// the design (checked in business logic, not stored here).
abstract class BlueprintReveal implements _i1.SerializableModel {
  BlueprintReveal._({
    this.id,
    required this.playerId,
    this.player,
    required this.blueprintId,
    this.blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) : replaysWatched = replaysWatched ?? 0,
       blocksRevealed = blocksRevealed ?? 0,
       updatedAt = updatedAt ?? DateTime.now();

  factory BlueprintReveal({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue blueprintId,
    _i3.Blueprint? blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) = _BlueprintRevealImpl;

  factory BlueprintReveal.fromJson(Map<String, dynamic> jsonSerialization) {
    return BlueprintReveal(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      blueprintId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['blueprintId'],
      ),
      blueprint: jsonSerialization['blueprint'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Blueprint>(
              jsonSerialization['blueprint'],
            ),
      replaysWatched: jsonSerialization['replaysWatched'] as int?,
      blocksRevealed: jsonSerialization['blocksRevealed'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  _i1.UuidValue blueprintId;

  _i3.Blueprint? blueprint;

  int replaysWatched;

  int blocksRevealed;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BlueprintReveal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlueprintReveal copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    _i1.UuidValue? blueprintId,
    _i3.Blueprint? blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlueprintReveal',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'blueprintId': blueprintId.toJson(),
      if (blueprint != null) 'blueprint': blueprint?.toJson(),
      'replaysWatched': replaysWatched,
      'blocksRevealed': blocksRevealed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlueprintRevealImpl extends BlueprintReveal {
  _BlueprintRevealImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue blueprintId,
    _i3.Blueprint? blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         blueprintId: blueprintId,
         blueprint: blueprint,
         replaysWatched: replaysWatched,
         blocksRevealed: blocksRevealed,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BlueprintReveal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlueprintReveal copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    _i1.UuidValue? blueprintId,
    Object? blueprint = _Undefined,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) {
    return BlueprintReveal(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      blueprintId: blueprintId ?? this.blueprintId,
      blueprint: blueprint is _i3.Blueprint?
          ? blueprint
          : this.blueprint?.copyWith(),
      replaysWatched: replaysWatched ?? this.replaysWatched,
      blocksRevealed: blocksRevealed ?? this.blocksRevealed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
