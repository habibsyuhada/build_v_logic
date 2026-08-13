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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i2;
import 'package:shared_models/src/protocol/protocol.dart' as _i3;

/// A PAYLOAD player profile (§2.4), one per `serverpod_auth` `AuthUser`.
/// Sign-in method itself (Google/Apple/email/guest) is handled by
/// `serverpod_auth`; this table only carries game-specific state.
abstract class Player implements _i1.SerializableModel {
  Player._({
    this.id,
    required this.authUserId,
    this.authUser,
    bool? isGuest,
    required this.handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) : isGuest = isGuest ?? true,
       createdAt = createdAt ?? DateTime.now(),
       rating = rating ?? 1000,
       seasonRating = seasonRating ?? 1000,
       credits = credits ?? 0,
       keys = keys ?? 0,
       capacityKb = capacityKb ?? 40,
       settingsJson = settingsJson ?? '';

  factory Player({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    bool? isGuest,
    required String handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) = _PlayerImpl;

  factory Player.fromJson(Map<String, dynamic> jsonSerialization) {
    return Player(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      isGuest: jsonSerialization['isGuest'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isGuest']),
      handle: jsonSerialization['handle'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      rating: jsonSerialization['rating'] as int?,
      seasonRating: jsonSerialization['seasonRating'] as int?,
      credits: jsonSerialization['credits'] as int?,
      keys: jsonSerialization['keys'] as int?,
      capacityKb: jsonSerialization['capacityKb'] as int?,
      settingsJson: jsonSerialization['settingsJson'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue authUserId;

  /// The underlying serverpod_auth identity. One Player per AuthUser.
  _i2.AuthUser? authUser;

  /// Whether this player is a guest account (§2.5: "guest account
  /// (upgradeable)") — a guest's authUser has no linked login method yet.
  bool isGuest;

  /// Display handle, unique.
  String handle;

  DateTime createdAt;

  /// PvP ladder rating (§1.5, §2.4), Elo-like.
  int rating;

  /// Rating within the current season (§1.5); reset at season rollover.
  int seasonRating;

  /// Soft currency (§1.6).
  int credits;

  /// Premium currency (§1.6), cosmetics only.
  int keys;

  /// Current virus capacity, grows via progression (§1.3: 40KB -> 90KB).
  int capacityKb;

  /// Player settings (accessibility, audio, etc.) as opaque JSON (§1.8).
  String settingsJson;

  /// Returns a shallow copy of this [Player]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Player copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    bool? isGuest,
    String? handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Player',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'isGuest': isGuest,
      'handle': handle,
      'createdAt': createdAt.toJson(),
      'rating': rating,
      'seasonRating': seasonRating,
      'credits': credits,
      'keys': keys,
      'capacityKb': capacityKb,
      'settingsJson': settingsJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerImpl extends Player {
  _PlayerImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    bool? isGuest,
    required String handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         isGuest: isGuest,
         handle: handle,
         createdAt: createdAt,
         rating: rating,
         seasonRating: seasonRating,
         credits: credits,
         keys: keys,
         capacityKb: capacityKb,
         settingsJson: settingsJson,
       );

  /// Returns a shallow copy of this [Player]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Player copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    bool? isGuest,
    String? handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) {
    return Player(
      id: id is _i1.UuidValue? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      isGuest: isGuest ?? this.isGuest,
      handle: handle ?? this.handle,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
      seasonRating: seasonRating ?? this.seasonRating,
      credits: credits ?? this.credits,
      keys: keys ?? this.keys,
      capacityKb: capacityKb ?? this.capacityKb,
      settingsJson: settingsJson ?? this.settingsJson,
    );
  }
}
