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
import 'battle_outcome.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// One resolved PvP battle (§2.3, §2.4 `battles`). Created by the battle
/// worker after `sim_core.resolveBattle` runs; never written to by the
/// client directly — the client only submits an `AttackRequest` and later
/// fetches this row (see `BattleEndpoint`).
abstract class Battle implements _i1.SerializableModel {
  Battle._({
    this.id,
    required this.attackerId,
    this.attacker,
    required this.defenderId,
    this.defender,
    required this.defenseVersion,
    bool? isGhostMatch,
    required this.virusDefJson,
    required this.seed,
    required this.simVersion,
    this.logJson,
    this.logRef,
    required this.score,
    required this.outcome,
    required this.ratingDelta,
    DateTime? createdAt,
  }) : isGhostMatch = isGhostMatch ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Battle({
    _i1.UuidValue? id,
    required _i1.UuidValue attackerId,
    _i2.Player? attacker,
    required _i1.UuidValue defenderId,
    _i2.Player? defender,
    required int defenseVersion,
    bool? isGhostMatch,
    required String virusDefJson,
    required int seed,
    required int simVersion,
    String? logJson,
    String? logRef,
    required int score,
    required _i3.BattleOutcome outcome,
    required int ratingDelta,
    DateTime? createdAt,
  }) = _BattleImpl;

  factory Battle.fromJson(Map<String, dynamic> jsonSerialization) {
    return Battle(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      attackerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['attackerId'],
      ),
      attacker: jsonSerialization['attacker'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(
              jsonSerialization['attacker'],
            ),
      defenderId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['defenderId'],
      ),
      defender: jsonSerialization['defender'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(
              jsonSerialization['defender'],
            ),
      defenseVersion: jsonSerialization['defenseVersion'] as int,
      isGhostMatch: jsonSerialization['isGhostMatch'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isGhostMatch']),
      virusDefJson: jsonSerialization['virusDefJson'] as String,
      seed: jsonSerialization['seed'] as int,
      simVersion: jsonSerialization['simVersion'] as int,
      logJson: jsonSerialization['logJson'] as String?,
      logRef: jsonSerialization['logRef'] as String?,
      score: jsonSerialization['score'] as int,
      outcome: _i3.BattleOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      ratingDelta: jsonSerialization['ratingDelta'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue attackerId;

  _i2.Player? attacker;

  _i1.UuidValue defenderId;

  _i2.Player? defender;

  /// The exact defense version attacked (§2.3: never a mid-edit defense).
  int defenseVersion;

  /// True if the defender was matched via the ghost network (§1.5.3)
  /// rather than a live opponent — still a real snapshot, just presented
  /// anonymized to the attacker.
  bool isGhostMatch;

  /// The submitted virus program, as JSON (content_schema.VirusDef).
  String virusDefJson;

  /// sim_core seed used to resolve this battle (§2.3, §3.1) — the battle
  /// is fully reproducible from (virusDefJson, defense snapshot, seed).
  int seed;

  /// sim_core / content package version this battle was resolved with
  /// (§2.7 versioning). Replays must be read with a compatible version.
  int simVersion;

  /// Inline battle log JSON (BattleLog.toJson()) when small enough.
  /// Mutually exclusive with [logRef] — exactly one is set.
  String? logJson;

  /// Object-storage key for the battle log when it's too large to store
  /// inline (§2.4: ">32 KB"). Mutually exclusive with [logJson].
  String? logRef;

  int score;

  _i3.BattleOutcome outcome;

  /// Elo-like rating delta applied to the attacker (defender gets the
  /// negation). Positive = attacker gained rating.
  int ratingDelta;

  DateTime createdAt;

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Battle copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? attackerId,
    _i2.Player? attacker,
    _i1.UuidValue? defenderId,
    _i2.Player? defender,
    int? defenseVersion,
    bool? isGhostMatch,
    String? virusDefJson,
    int? seed,
    int? simVersion,
    String? logJson,
    String? logRef,
    int? score,
    _i3.BattleOutcome? outcome,
    int? ratingDelta,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Battle',
      if (id != null) 'id': id?.toJson(),
      'attackerId': attackerId.toJson(),
      if (attacker != null) 'attacker': attacker?.toJson(),
      'defenderId': defenderId.toJson(),
      if (defender != null) 'defender': defender?.toJson(),
      'defenseVersion': defenseVersion,
      'isGhostMatch': isGhostMatch,
      'virusDefJson': virusDefJson,
      'seed': seed,
      'simVersion': simVersion,
      if (logJson != null) 'logJson': logJson,
      if (logRef != null) 'logRef': logRef,
      'score': score,
      'outcome': outcome.toJson(),
      'ratingDelta': ratingDelta,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BattleImpl extends Battle {
  _BattleImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue attackerId,
    _i2.Player? attacker,
    required _i1.UuidValue defenderId,
    _i2.Player? defender,
    required int defenseVersion,
    bool? isGhostMatch,
    required String virusDefJson,
    required int seed,
    required int simVersion,
    String? logJson,
    String? logRef,
    required int score,
    required _i3.BattleOutcome outcome,
    required int ratingDelta,
    DateTime? createdAt,
  }) : super._(
         id: id,
         attackerId: attackerId,
         attacker: attacker,
         defenderId: defenderId,
         defender: defender,
         defenseVersion: defenseVersion,
         isGhostMatch: isGhostMatch,
         virusDefJson: virusDefJson,
         seed: seed,
         simVersion: simVersion,
         logJson: logJson,
         logRef: logRef,
         score: score,
         outcome: outcome,
         ratingDelta: ratingDelta,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Battle copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? attackerId,
    Object? attacker = _Undefined,
    _i1.UuidValue? defenderId,
    Object? defender = _Undefined,
    int? defenseVersion,
    bool? isGhostMatch,
    String? virusDefJson,
    int? seed,
    int? simVersion,
    Object? logJson = _Undefined,
    Object? logRef = _Undefined,
    int? score,
    _i3.BattleOutcome? outcome,
    int? ratingDelta,
    DateTime? createdAt,
  }) {
    return Battle(
      id: id is _i1.UuidValue? ? id : this.id,
      attackerId: attackerId ?? this.attackerId,
      attacker: attacker is _i2.Player? ? attacker : this.attacker?.copyWith(),
      defenderId: defenderId ?? this.defenderId,
      defender: defender is _i2.Player? ? defender : this.defender?.copyWith(),
      defenseVersion: defenseVersion ?? this.defenseVersion,
      isGhostMatch: isGhostMatch ?? this.isGhostMatch,
      virusDefJson: virusDefJson ?? this.virusDefJson,
      seed: seed ?? this.seed,
      simVersion: simVersion ?? this.simVersion,
      logJson: logJson is String? ? logJson : this.logJson,
      logRef: logRef is String? ? logRef : this.logRef,
      score: score ?? this.score,
      outcome: outcome ?? this.outcome,
      ratingDelta: ratingDelta ?? this.ratingDelta,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
