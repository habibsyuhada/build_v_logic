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

/// One client telemetry event (§2.6: "Telemetry client (event funnel):
/// install → tutorial step N → first battle → D1/D7 return. Kirim
/// batched ke endpoint sendiri"). Ingested via `TelemetryEndpoint.ingest`,
/// batched client-side by `TelemetryClient` before sending.
abstract class TelemetryEvent implements _i1.SerializableModel {
  TelemetryEvent._({
    this.id,
    this.playerId,
    this.player,
    required this.eventType,
    String? propertiesJson,
    required this.occurredAt,
    DateTime? receivedAt,
  }) : propertiesJson = propertiesJson ?? '{}',
       receivedAt = receivedAt ?? DateTime.now();

  factory TelemetryEvent({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    required String eventType,
    String? propertiesJson,
    required DateTime occurredAt,
    DateTime? receivedAt,
  }) = _TelemetryEventImpl;

  factory TelemetryEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TelemetryEvent(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: jsonSerialization['playerId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['playerId']),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      eventType: jsonSerialization['eventType'] as String,
      propertiesJson: jsonSerialization['propertiesJson'] as String?,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      receivedAt: jsonSerialization['receivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['receivedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue? playerId;

  /// Nullable: some funnel events (e.g. first app open) happen before a
  /// Player row exists yet.
  _i2.Player? player;

  String eventType;

  String propertiesJson;

  DateTime occurredAt;

  DateTime receivedAt;

  /// Returns a shallow copy of this [TelemetryEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TelemetryEvent copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? eventType,
    String? propertiesJson,
    DateTime? occurredAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelemetryEvent',
      if (id != null) 'id': id?.toJson(),
      if (playerId != null) 'playerId': playerId?.toJson(),
      if (player != null) 'player': player?.toJson(),
      'eventType': eventType,
      'propertiesJson': propertiesJson,
      'occurredAt': occurredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TelemetryEventImpl extends TelemetryEvent {
  _TelemetryEventImpl({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    required String eventType,
    String? propertiesJson,
    required DateTime occurredAt,
    DateTime? receivedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         eventType: eventType,
         propertiesJson: propertiesJson,
         occurredAt: occurredAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [TelemetryEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TelemetryEvent copyWith({
    Object? id = _Undefined,
    Object? playerId = _Undefined,
    Object? player = _Undefined,
    String? eventType,
    String? propertiesJson,
    DateTime? occurredAt,
    DateTime? receivedAt,
  }) {
    return TelemetryEvent(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId is _i1.UuidValue? ? playerId : this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      eventType: eventType ?? this.eventType,
      propertiesJson: propertiesJson ?? this.propertiesJson,
      occurredAt: occurredAt ?? this.occurredAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}
