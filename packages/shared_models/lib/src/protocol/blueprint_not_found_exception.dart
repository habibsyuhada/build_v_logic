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

/// Thrown when a blueprint id doesn't exist or isn't approved yet.
abstract class BlueprintNotFoundException
    implements _i1.SerializableException, _i1.SerializableModel {
  BlueprintNotFoundException._();

  factory BlueprintNotFoundException() = _BlueprintNotFoundExceptionImpl;

  factory BlueprintNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BlueprintNotFoundException();
  }

  /// Returns a shallow copy of this [BlueprintNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlueprintNotFoundException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {'__className__': 'BlueprintNotFoundException'};
  }

  @override
  String toString() {
    return 'BlueprintNotFoundException';
  }
}

class _BlueprintNotFoundExceptionImpl extends BlueprintNotFoundException {
  _BlueprintNotFoundExceptionImpl() : super._();

  /// Returns a shallow copy of this [BlueprintNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlueprintNotFoundException copyWith() {
    return BlueprintNotFoundException();
  }
}
