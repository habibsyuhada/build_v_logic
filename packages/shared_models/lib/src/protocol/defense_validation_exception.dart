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
import 'package:shared_models/src/protocol/protocol.dart' as _i2;

/// Thrown when a submitted defense fails validation (§2.5) — malformed
/// JSON, failed anti-turtle check, over the 6-block defense-logic cap
/// (§1.4), or a locked block.
abstract class DefenseValidationException
    implements _i1.SerializableException, _i1.SerializableModel {
  DefenseValidationException._({required this.errors});

  factory DefenseValidationException({required List<String> errors}) =
      _DefenseValidationExceptionImpl;

  factory DefenseValidationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DefenseValidationException(
      errors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
    );
  }

  List<String> errors;

  /// Returns a shallow copy of this [DefenseValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DefenseValidationException copyWith({List<String>? errors});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DefenseValidationException',
      'errors': errors.toJson(),
    };
  }

  @override
  String toString() {
    return 'DefenseValidationException(errors: $errors)';
  }
}

class _DefenseValidationExceptionImpl extends DefenseValidationException {
  _DefenseValidationExceptionImpl({required List<String> errors})
    : super._(errors: errors);

  /// Returns a shallow copy of this [DefenseValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DefenseValidationException copyWith({List<String>? errors}) {
    return DefenseValidationException(
      errors: errors ?? this.errors.map((e0) => e0).toList(),
    );
  }
}
