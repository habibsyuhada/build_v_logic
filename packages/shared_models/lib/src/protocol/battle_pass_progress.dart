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
import 'season.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// A player's battle pass progress for one [Season] (§1.6). Tier is
/// derived from `xp` (see `BattlePassTierCalculator`), not stored
/// directly, so a tier-curve rebalance never needs a data migration.
abstract class BattlePassProgress implements _i1.SerializableModel {
  BattlePassProgress._({
    this.id,
    required this.playerId,
    this.player,
    required this.seasonId,
    this.season,
    int? xp,
    bool? hasPremium,
  }) : xp = xp ?? 0,
       hasPremium = hasPremium ?? false;

  factory BattlePassProgress({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue seasonId,
    _i3.Season? season,
    int? xp,
    bool? hasPremium,
  }) = _BattlePassProgressImpl;

  factory BattlePassProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return BattlePassProgress(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      seasonId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['seasonId'],
      ),
      season: jsonSerialization['season'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Season>(jsonSerialization['season']),
      xp: jsonSerialization['xp'] as int?,
      hasPremium: jsonSerialization['hasPremium'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['hasPremium']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  _i1.UuidValue seasonId;

  _i3.Season? season;

  int xp;

  /// Whether the premium track was purchased for this season — the free
  /// track's rewards are always available regardless (§1.6: "Tidak ada
  /// blok/kapasitas di track premium").
  bool hasPremium;

  /// Returns a shallow copy of this [BattlePassProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BattlePassProgress copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    _i1.UuidValue? seasonId,
    _i3.Season? season,
    int? xp,
    bool? hasPremium,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BattlePassProgress',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'seasonId': seasonId.toJson(),
      if (season != null) 'season': season?.toJson(),
      'xp': xp,
      'hasPremium': hasPremium,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BattlePassProgressImpl extends BattlePassProgress {
  _BattlePassProgressImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue seasonId,
    _i3.Season? season,
    int? xp,
    bool? hasPremium,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         seasonId: seasonId,
         season: season,
         xp: xp,
         hasPremium: hasPremium,
       );

  /// Returns a shallow copy of this [BattlePassProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BattlePassProgress copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    _i1.UuidValue? seasonId,
    Object? season = _Undefined,
    int? xp,
    bool? hasPremium,
  }) {
    return BattlePassProgress(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      seasonId: seasonId ?? this.seasonId,
      season: season is _i3.Season? ? season : this.season?.copyWith(),
      xp: xp ?? this.xp,
      hasPremium: hasPremium ?? this.hasPremium,
    );
  }
}
