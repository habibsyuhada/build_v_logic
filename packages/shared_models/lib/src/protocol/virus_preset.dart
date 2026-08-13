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

/// A saved virus build (§2.4 `virus_presets`). Capped at
/// [maxVirusPresetsPerPlayer] per player, enforced in
/// `PresetEndpoint` (app-side mirror: `app/lib/features/core/storage/preset_storage.dart`'s
/// `maxVirusPresets`, kept equal on purpose).
abstract class VirusPreset implements _i1.SerializableModel {
  VirusPreset._({
    this.id,
    required this.playerId,
    this.player,
    required this.name,
    required this.defJson,
    required this.sizeKb,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory VirusPreset({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String name,
    required String defJson,
    required int sizeKb,
    DateTime? updatedAt,
  }) = _VirusPresetImpl;

  factory VirusPreset.fromJson(Map<String, dynamic> jsonSerialization) {
    return VirusPreset(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      name: jsonSerialization['name'] as String,
      defJson: jsonSerialization['defJson'] as String,
      sizeKb: jsonSerialization['sizeKb'] as int,
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

  String name;

  /// The DAG program, as JSON matching `content_schema.DagDef.toJson()`.
  String defJson;

  int sizeKb;

  DateTime updatedAt;

  /// Returns a shallow copy of this [VirusPreset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VirusPreset copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? name,
    String? defJson,
    int? sizeKb,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VirusPreset',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'name': name,
      'defJson': defJson,
      'sizeKb': sizeKb,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VirusPresetImpl extends VirusPreset {
  _VirusPresetImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String name,
    required String defJson,
    required int sizeKb,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         name: name,
         defJson: defJson,
         sizeKb: sizeKb,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [VirusPreset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VirusPreset copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? name,
    String? defJson,
    int? sizeKb,
    DateTime? updatedAt,
  }) {
    return VirusPreset(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      name: name ?? this.name,
      defJson: defJson ?? this.defJson,
      sizeKb: sizeKb ?? this.sizeKb,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
