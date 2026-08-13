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
import 'blueprint_moderation_state.dart' as _i2;
import 'player.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// A published virus design (§1.5.4, §2.4 `blueprints`). Other players
/// see its *results* (replays against their own defense) but must
/// reverse-engineer it (§1.5.4: replay 3x per block to "read" it) before
/// they can copy it — see `BlueprintReveal`.
abstract class Blueprint implements _i1.SerializableModel {
  Blueprint._({
    this.id,
    required this.playerId,
    this.player,
    required this.title,
    required this.virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) : likes = likes ?? 0,
       plays = plays ?? 0,
       publishedAt = publishedAt ?? DateTime.now(),
       moderationState =
           moderationState ?? _i2.BlueprintModerationState.pending;

  factory Blueprint({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String title,
    required String virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) = _BlueprintImpl;

  factory Blueprint.fromJson(Map<String, dynamic> jsonSerialization) {
    return Blueprint(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Player>(jsonSerialization['player']),
      title: jsonSerialization['title'] as String,
      virusDefJson: jsonSerialization['virusDefJson'] as String,
      likes: jsonSerialization['likes'] as int?,
      plays: jsonSerialization['plays'] as int?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      moderationState: jsonSerialization['moderationState'] == null
          ? null
          : _i2.BlueprintModerationState.fromJson(
              (jsonSerialization['moderationState'] as String),
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i3.Player? player;

  String title;

  /// The virus program, as JSON (content_schema.VirusDef). Other players
  /// never see this directly until fully reverse-engineered.
  String virusDefJson;

  int likes;

  int plays;

  DateTime publishedAt;

  _i2.BlueprintModerationState moderationState;

  /// Returns a shallow copy of this [Blueprint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Blueprint copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i3.Player? player,
    String? title,
    String? virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Blueprint',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'title': title,
      'virusDefJson': virusDefJson,
      'likes': likes,
      'plays': plays,
      'publishedAt': publishedAt.toJson(),
      'moderationState': moderationState.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlueprintImpl extends Blueprint {
  _BlueprintImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String title,
    required String virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         title: title,
         virusDefJson: virusDefJson,
         likes: likes,
         plays: plays,
         publishedAt: publishedAt,
         moderationState: moderationState,
       );

  /// Returns a shallow copy of this [Blueprint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Blueprint copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? title,
    String? virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) {
    return Blueprint(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i3.Player? ? player : this.player?.copyWith(),
      title: title ?? this.title,
      virusDefJson: virusDefJson ?? this.virusDefJson,
      likes: likes ?? this.likes,
      plays: plays ?? this.plays,
      publishedAt: publishedAt ?? this.publishedAt,
      moderationState: moderationState ?? this.moderationState,
    );
  }
}
