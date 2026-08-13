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
import 'season.dart' as _i2;
import 'player.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// A player's final standing in a completed [Season] (§2.4
/// `season_results`), snapshotted at rollover before `seasonRating`
/// resets.
abstract class SeasonResult implements _i1.SerializableModel {
  SeasonResult._({
    this.id,
    required this.seasonId,
    this.season,
    required this.playerId,
    this.player,
    required this.finalRating,
    required this.rank,
  });

  factory SeasonResult({
    _i1.UuidValue? id,
    required _i1.UuidValue seasonId,
    _i2.Season? season,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required int finalRating,
    required int rank,
  }) = _SeasonResultImpl;

  factory SeasonResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeasonResult(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      seasonId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['seasonId'],
      ),
      season: jsonSerialization['season'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Season>(jsonSerialization['season']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Player>(jsonSerialization['player']),
      finalRating: jsonSerialization['finalRating'] as int,
      rank: jsonSerialization['rank'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue seasonId;

  _i2.Season? season;

  _i1.UuidValue playerId;

  _i3.Player? player;

  int finalRating;

  int rank;

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SeasonResult copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? seasonId,
    _i2.Season? season,
    _i1.UuidValue? playerId,
    _i3.Player? player,
    int? finalRating,
    int? rank,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id?.toJson(),
      'seasonId': seasonId.toJson(),
      if (season != null) 'season': season?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'finalRating': finalRating,
      'rank': rank,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonResultImpl extends SeasonResult {
  _SeasonResultImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue seasonId,
    _i2.Season? season,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required int finalRating,
    required int rank,
  }) : super._(
         id: id,
         seasonId: seasonId,
         season: season,
         playerId: playerId,
         player: player,
         finalRating: finalRating,
         rank: rank,
       );

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SeasonResult copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? seasonId,
    Object? season = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    int? finalRating,
    int? rank,
  }) {
    return SeasonResult(
      id: id is _i1.UuidValue? ? id : this.id,
      seasonId: seasonId ?? this.seasonId,
      season: season is _i2.Season? ? season : this.season?.copyWith(),
      playerId: playerId ?? this.playerId,
      player: player is _i3.Player? ? player : this.player?.copyWith(),
      finalRating: finalRating ?? this.finalRating,
      rank: rank ?? this.rank,
    );
  }
}
