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
import 'daily_contract.dart' as _i3;
import 'package:shared_models/src/protocol/protocol.dart' as _i4;

/// A player's best score on a given [DailyContract] (§2.4
/// `contract_scores`), for the daily global leaderboard.
abstract class ContractScore implements _i1.SerializableModel {
  ContractScore._({
    this.id,
    required this.playerId,
    this.player,
    required this.contractId,
    this.contract,
    required this.score,
    DateTime? achievedAt,
  }) : achievedAt = achievedAt ?? DateTime.now();

  factory ContractScore({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue contractId,
    _i3.DailyContract? contract,
    required int score,
    DateTime? achievedAt,
  }) = _ContractScoreImpl;

  factory ContractScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContractScore(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      contractId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['contractId'],
      ),
      contract: jsonSerialization['contract'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.DailyContract>(
              jsonSerialization['contract'],
            ),
      score: jsonSerialization['score'] as int,
      achievedAt: jsonSerialization['achievedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  _i1.UuidValue contractId;

  _i3.DailyContract? contract;

  int score;

  DateTime achievedAt;

  /// Returns a shallow copy of this [ContractScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ContractScore copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    _i1.UuidValue? contractId,
    _i3.DailyContract? contract,
    int? score,
    DateTime? achievedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContractScore',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'contractId': contractId.toJson(),
      if (contract != null) 'contract': contract?.toJson(),
      'score': score,
      'achievedAt': achievedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContractScoreImpl extends ContractScore {
  _ContractScoreImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue contractId,
    _i3.DailyContract? contract,
    required int score,
    DateTime? achievedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         contractId: contractId,
         contract: contract,
         score: score,
         achievedAt: achievedAt,
       );

  /// Returns a shallow copy of this [ContractScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ContractScore copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    _i1.UuidValue? contractId,
    Object? contract = _Undefined,
    int? score,
    DateTime? achievedAt,
  }) {
    return ContractScore(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      contractId: contractId ?? this.contractId,
      contract: contract is _i3.DailyContract?
          ? contract
          : this.contract?.copyWith(),
      score: score ?? this.score,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }
}
