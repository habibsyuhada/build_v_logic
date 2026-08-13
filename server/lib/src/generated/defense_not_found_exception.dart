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

/// Thrown when an attack targets a defense id that doesn't exist, or
/// isn't currently the target player's active version.
abstract class DefenseNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  DefenseNotFoundException._();

  factory DefenseNotFoundException() = _DefenseNotFoundExceptionImpl;

  factory DefenseNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DefenseNotFoundException();
  }

  /// Returns a shallow copy of this [DefenseNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DefenseNotFoundException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {'__className__': 'DefenseNotFoundException'};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'__className__': 'DefenseNotFoundException'};
  }

  @override
  String toString() {
    return 'DefenseNotFoundException';
  }
}

class _DefenseNotFoundExceptionImpl extends DefenseNotFoundException {
  _DefenseNotFoundExceptionImpl() : super._();

  /// Returns a shallow copy of this [DefenseNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DefenseNotFoundException copyWith() {
    return DefenseNotFoundException();
  }
}
