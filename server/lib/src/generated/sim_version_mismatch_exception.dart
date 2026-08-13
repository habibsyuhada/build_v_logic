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

/// Thrown when a client submits a PvP attack with an incompatible
/// `sim_core`/content version (§2.7: "paksa update untuk PvP"). PvE never
/// throws this — only PvP submission checks it.
abstract class SimVersionMismatchException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  SimVersionMismatchException._({
    required this.clientSimVersion,
    required this.serverSimVersion,
  });

  factory SimVersionMismatchException({
    required int clientSimVersion,
    required int serverSimVersion,
  }) = _SimVersionMismatchExceptionImpl;

  factory SimVersionMismatchException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SimVersionMismatchException(
      clientSimVersion: jsonSerialization['clientSimVersion'] as int,
      serverSimVersion: jsonSerialization['serverSimVersion'] as int,
    );
  }

  int clientSimVersion;

  int serverSimVersion;

  /// Returns a shallow copy of this [SimVersionMismatchException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SimVersionMismatchException copyWith({
    int? clientSimVersion,
    int? serverSimVersion,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SimVersionMismatchException',
      'clientSimVersion': clientSimVersion,
      'serverSimVersion': serverSimVersion,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SimVersionMismatchException',
      'clientSimVersion': clientSimVersion,
      'serverSimVersion': serverSimVersion,
    };
  }

  @override
  String toString() {
    return 'SimVersionMismatchException(clientSimVersion: $clientSimVersion, serverSimVersion: $serverSimVersion)';
  }
}

class _SimVersionMismatchExceptionImpl extends SimVersionMismatchException {
  _SimVersionMismatchExceptionImpl({
    required int clientSimVersion,
    required int serverSimVersion,
  }) : super._(
         clientSimVersion: clientSimVersion,
         serverSimVersion: serverSimVersion,
       );

  /// Returns a shallow copy of this [SimVersionMismatchException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SimVersionMismatchException copyWith({
    int? clientSimVersion,
    int? serverSimVersion,
  }) {
    return SimVersionMismatchException(
      clientSimVersion: clientSimVersion ?? this.clientSimVersion,
      serverSimVersion: serverSimVersion ?? this.serverSimVersion,
    );
  }
}
