import 'dart:convert';

import 'package:content_schema/content_schema.dart';

/// Server-side validation of a submitted defense (§1.4, §2.5): well-formed
/// topology (reuses `content_schema.validateNetwork` — same anti-turtle
/// reachability check the content pipeline runs on curated networks), and
/// each node's defense-logic capped at 6 blocks (§1.4: "Defense-logic per
/// node maksimal 6 blok").
class DefenseSubmissionValidator {
  static const int maxDefenseBlocksPerNode = 6;

  static ValidationResult validate({
    required String networkDefJson,
    required Map<String, BlockDef> blockCatalog,
    required Set<String> unlockedBlockIds,
  }) {
    late final Map<String, dynamic> json;
    try {
      json = jsonDecode(networkDefJson) as Map<String, dynamic>;
    } on FormatException catch (e) {
      return ValidationResult.error('malformed defense JSON: ${e.message}');
    }

    late final NetworkDef network;
    try {
      network = NetworkDef.fromJson(json);
    } catch (e) {
      return ValidationResult.error('malformed network definition: $e');
    }

    var result = validateNetwork(network);

    for (final node in network.nodes) {
      final defenseLogicJson = node.defenseLogic;
      if (defenseLogicJson == null) continue;

      late final DagDef dag;
      try {
        dag = DagDef.fromJson(defenseLogicJson);
      } catch (e) {
        result = result.merge(ValidationResult.error('node ${node.id}: malformed defense_logic: $e'));
        continue;
      }

      if (dag.nodes.length > maxDefenseBlocksPerNode) {
        result = result.merge(ValidationResult.error(
            'node ${node.id}: defense_logic has ${dag.nodes.length} blocks, '
            'max $maxDefenseBlocksPerNode'));
      }

      result = result.merge(validateDag(
        dag,
        blockCatalog: blockCatalog,
        unlockedBlockIds: unlockedBlockIds,
      ));
    }

    return result;
  }
}
