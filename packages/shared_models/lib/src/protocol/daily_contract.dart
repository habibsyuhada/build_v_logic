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

/// One day's system-generated puzzle network (§1.5.5, §2.4
/// `daily_contracts`), deterministically seeded from its date so every
/// player faces the exact same network.
abstract class DailyContract implements _i1.SerializableModel {
  DailyContract._({
    this.id,
    required this.contractDate,
    required this.networkJson,
    required this.seed,
  });

  factory DailyContract({
    _i1.UuidValue? id,
    required String contractDate,
    required String networkJson,
    required int seed,
  }) = _DailyContractImpl;

  factory DailyContract.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyContract(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      contractDate: jsonSerialization['contractDate'] as String,
      networkJson: jsonSerialization['networkJson'] as String,
      seed: jsonSerialization['seed'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  /// The contract's date, as `YYYY-MM-DD` (UTC) — also the seed source.
  String contractDate;

  /// The generated network, as JSON (content_schema.NetworkDef).
  String networkJson;

  int seed;

  /// Returns a shallow copy of this [DailyContract]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DailyContract copyWith({
    _i1.UuidValue? id,
    String? contractDate,
    String? networkJson,
    int? seed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyContract',
      if (id != null) 'id': id?.toJson(),
      'contractDate': contractDate,
      'networkJson': networkJson,
      'seed': seed,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DailyContractImpl extends DailyContract {
  _DailyContractImpl({
    _i1.UuidValue? id,
    required String contractDate,
    required String networkJson,
    required int seed,
  }) : super._(
         id: id,
         contractDate: contractDate,
         networkJson: networkJson,
         seed: seed,
       );

  /// Returns a shallow copy of this [DailyContract]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DailyContract copyWith({
    Object? id = _Undefined,
    String? contractDate,
    String? networkJson,
    int? seed,
  }) {
    return DailyContract(
      id: id is _i1.UuidValue? ? id : this.id,
      contractDate: contractDate ?? this.contractDate,
      networkJson: networkJson ?? this.networkJson,
      seed: seed ?? this.seed,
    );
  }
}
