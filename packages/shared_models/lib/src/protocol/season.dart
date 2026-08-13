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

/// A 4-week PvP season (§1.5.2, §2.4 `seasons`).
abstract class Season implements _i1.SerializableModel {
  Season._({
    this.id,
    required this.startsAt,
    required this.endsAt,
  });

  factory Season({
    _i1.UuidValue? id,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _SeasonImpl;

  factory Season.fromJson(Map<String, dynamic> jsonSerialization) {
    return Season(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  DateTime startsAt;

  DateTime endsAt;

  /// Returns a shallow copy of this [Season]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Season copyWith({
    _i1.UuidValue? id,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Season',
      if (id != null) 'id': id?.toJson(),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonImpl extends Season {
  _SeasonImpl({
    _i1.UuidValue? id,
    required DateTime startsAt,
    required DateTime endsAt,
  }) : super._(
         id: id,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [Season]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Season copyWith({
    Object? id = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return Season(
      id: id is _i1.UuidValue? ? id : this.id,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}
