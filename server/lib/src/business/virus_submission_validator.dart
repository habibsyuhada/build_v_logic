import 'dart:convert';

import 'package:content_schema/content_schema.dart';

/// Server-side validation of a submitted virus (§2.5): well-formed JSON,
/// size within the player's capacity, every block unlocked, no dangling
/// DAG references. Reuses `content_schema.validateDag` — the exact same
/// validator the client's workbench lint runs — so a build that passes
/// client-side lint is guaranteed to pass here too (mod the unlocked-set
/// actually matching, which the server always double-checks itself; the
/// client's set is a UI convenience, never trusted).
class VirusSubmissionValidator {
  static ValidationResult validate({
    required String virusDefJson,
    required Map<String, BlockDef> blockCatalog,
    required Set<String> unlockedBlockIds,
    required int capacityKb,
  }) {
    late final Map<String, dynamic> json;
    try {
      json = jsonDecode(virusDefJson) as Map<String, dynamic>;
    } on FormatException catch (e) {
      return ValidationResult.error('malformed virus JSON: ${e.message}');
    }

    late final VirusDef virusDef;
    try {
      virusDef = VirusDef.fromJson(json);
    } catch (e) {
      return ValidationResult.error('malformed virus definition: $e');
    }

    return validateDag(
      virusDef.program,
      blockCatalog: blockCatalog,
      unlockedBlockIds: unlockedBlockIds,
      capacityKb: capacityKb,
    );
  }
}
