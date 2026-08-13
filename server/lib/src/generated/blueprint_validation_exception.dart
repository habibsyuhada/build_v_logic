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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:payload_server/src/generated/protocol.dart' as _i2;

/// Thrown when a submitted blueprint's virus design fails validation
/// (§2.5) — malformed JSON, over budget, or a locked block. Same checks
/// as an attack submission (`VirusSubmissionValidator`), since a
/// blueprint is just a saved virus design.
abstract class BlueprintValidationException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  BlueprintValidationException._({required this.errors});

  factory BlueprintValidationException({required List<String> errors}) =
      _BlueprintValidationExceptionImpl;

  factory BlueprintValidationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BlueprintValidationException(
      errors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
    );
  }

  List<String> errors;

  /// Returns a shallow copy of this [BlueprintValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlueprintValidationException copyWith({List<String>? errors});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlueprintValidationException',
      'errors': errors.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BlueprintValidationException',
      'errors': errors.toJson(),
    };
  }

  @override
  String toString() {
    return 'BlueprintValidationException(errors: $errors)';
  }
}

class _BlueprintValidationExceptionImpl extends BlueprintValidationException {
  _BlueprintValidationExceptionImpl({required List<String> errors})
    : super._(errors: errors);

  /// Returns a shallow copy of this [BlueprintValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlueprintValidationException copyWith({List<String>? errors}) {
    return BlueprintValidationException(
      errors: errors ?? this.errors.map((e0) => e0).toList(),
    );
  }
}
