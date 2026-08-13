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

/// Thrown when a player tries to copy a blueprint before reverse-
/// engineering all of its blocks (§1.5.4).
abstract class BlueprintNotRevealedException
    implements _i1.SerializableException, _i1.SerializableModel {
  BlueprintNotRevealedException._({
    required this.blocksRevealed,
    required this.blocksTotal,
  });

  factory BlueprintNotRevealedException({
    required int blocksRevealed,
    required int blocksTotal,
  }) = _BlueprintNotRevealedExceptionImpl;

  factory BlueprintNotRevealedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BlueprintNotRevealedException(
      blocksRevealed: jsonSerialization['blocksRevealed'] as int,
      blocksTotal: jsonSerialization['blocksTotal'] as int,
    );
  }

  int blocksRevealed;

  int blocksTotal;

  /// Returns a shallow copy of this [BlueprintNotRevealedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlueprintNotRevealedException copyWith({
    int? blocksRevealed,
    int? blocksTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlueprintNotRevealedException',
      'blocksRevealed': blocksRevealed,
      'blocksTotal': blocksTotal,
    };
  }

  @override
  String toString() {
    return 'BlueprintNotRevealedException(blocksRevealed: $blocksRevealed, blocksTotal: $blocksTotal)';
  }
}

class _BlueprintNotRevealedExceptionImpl extends BlueprintNotRevealedException {
  _BlueprintNotRevealedExceptionImpl({
    required int blocksRevealed,
    required int blocksTotal,
  }) : super._(
         blocksRevealed: blocksRevealed,
         blocksTotal: blocksTotal,
       );

  /// Returns a shallow copy of this [BlueprintNotRevealedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlueprintNotRevealedException copyWith({
    int? blocksRevealed,
    int? blocksTotal,
  }) {
    return BlueprintNotRevealedException(
      blocksRevealed: blocksRevealed ?? this.blocksRevealed,
      blocksTotal: blocksTotal ?? this.blocksTotal,
    );
  }
}
