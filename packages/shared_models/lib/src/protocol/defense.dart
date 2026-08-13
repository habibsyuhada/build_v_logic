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

/// A player's saved defense: topology + per-node defense-logic (§2.4
/// `defenses`). PvP attacks always target the most recent snapshot with
/// `isActive == true` — never a defense mid-edit (§2.3: "defender tidak
/// bisa di-grief saat sedang mengedit").
abstract class Defense implements _i1.SerializableModel {
  Defense._({
    this.id,
    required this.playerId,
    this.player,
    required this.defJson,
    int? version,
    bool? isActive,
    this.validatedAt,
  }) : version = version ?? 1,
       isActive = isActive ?? false;

  factory Defense({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String defJson,
    int? version,
    bool? isActive,
    DateTime? validatedAt,
  }) = _DefenseImpl;

  factory Defense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Defense(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      defJson: jsonSerialization['defJson'] as String,
      version: jsonSerialization['version'] as int?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  /// The network topology + per-node defense DAGs, as JSON matching
  /// `content_schema.NetworkDef.toJson()` (defense_logic embedded per node).
  String defJson;

  int version;

  bool isActive;

  /// Set once `content_schema.validateNetwork` + per-node `validateDag`
  /// have both passed server-side.
  DateTime? validatedAt;

  /// Returns a shallow copy of this [Defense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Defense copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? defJson,
    int? version,
    bool? isActive,
    DateTime? validatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Defense',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'defJson': defJson,
      'version': version,
      'isActive': isActive,
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DefenseImpl extends Defense {
  _DefenseImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String defJson,
    int? version,
    bool? isActive,
    DateTime? validatedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         defJson: defJson,
         version: version,
         isActive: isActive,
         validatedAt: validatedAt,
       );

  /// Returns a shallow copy of this [Defense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Defense copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? defJson,
    int? version,
    bool? isActive,
    Object? validatedAt = _Undefined,
  }) {
    return Defense(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      defJson: defJson ?? this.defJson,
      version: version ?? this.version,
      isActive: isActive ?? this.isActive,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
    );
  }
}
