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

/// Thrown when a submitted virus fails validation (§2.5) — malformed
/// JSON, over budget, or a locked block. The server never trusts the
/// client's own unlock bookkeeping (§2.5).
abstract class AttackValidationException
    implements _i1.SerializableException, _i1.SerializableModel {
  AttackValidationException._({required this.errors});

  factory AttackValidationException({required List<String> errors}) =
      _AttackValidationExceptionImpl;

  factory AttackValidationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AttackValidationException(
      errors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
    );
  }

  List<String> errors;

  /// Returns a shallow copy of this [AttackValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AttackValidationException copyWith({List<String>? errors});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttackValidationException',
      'errors': errors.toJson(),
    };
  }

  @override
  String toString() {
    return 'AttackValidationException(errors: $errors)';
  }
}

class _AttackValidationExceptionImpl extends AttackValidationException {
  _AttackValidationExceptionImpl({required List<String> errors})
    : super._(errors: errors);

  /// Returns a shallow copy of this [AttackValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AttackValidationException copyWith({List<String>? errors}) {
    return AttackValidationException(
      errors: errors ?? this.errors.map((e0) => e0).toList(),
    );
  }
}
