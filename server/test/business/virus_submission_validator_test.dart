import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:payload_server/src/business/virus_submission_validator.dart';
import 'package:test/test.dart';

final _catalog = {
  'wait': const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 2),
  'move_random': const BlockDef(id: 'move_random', family: BlockFamily.action, sizeKb: 2),
};

String _virusJson(DagDef program) => jsonEncode(VirusDef(program: program).toJson());

void main() {
  const validProgram = DagDef(nodes: [DagNode(id: 'a', blockId: 'wait')], entry: 'a');

  test('rejects malformed JSON', () {
    final result = VirusSubmissionValidator.validate(
      virusDefJson: '{not valid json',
      blockCatalog: _catalog,
      unlockedBlockIds: {'wait'},
      capacityKb: 40,
    );
    expect(result.isValid, isFalse);
    expect(result.errors.single, contains('malformed virus JSON'));
  });

  test('rejects a well-formed but structurally wrong virus definition', () {
    final result = VirusSubmissionValidator.validate(
      virusDefJson: jsonEncode({'not_a_program_field': true}),
      blockCatalog: _catalog,
      unlockedBlockIds: {'wait'},
      capacityKb: 40,
    );
    expect(result.isValid, isFalse);
  });

  test('accepts a valid virus using only unlocked blocks within capacity', () {
    final result = VirusSubmissionValidator.validate(
      virusDefJson: _virusJson(validProgram),
      blockCatalog: _catalog,
      unlockedBlockIds: {'wait'},
      capacityKb: 40,
    );
    expect(result.isValid, isTrue, reason: result.errors.join('; '));
  });

  test('rejects a virus using a locked block (never trusts the client-reported unlock set)', () {
    const program = DagDef(nodes: [DagNode(id: 'a', blockId: 'move_random')], entry: 'a');
    final result = VirusSubmissionValidator.validate(
      virusDefJson: _virusJson(program),
      blockCatalog: _catalog,
      unlockedBlockIds: {'wait'}, // move_random NOT included
      capacityKb: 40,
    );
    expect(result.isValid, isFalse);
    expect(result.errors.any((e) => e.contains('locked block')), isTrue);
  });

  test('rejects a virus over the player\'s capacity', () {
    final result = VirusSubmissionValidator.validate(
      virusDefJson: _virusJson(validProgram),
      blockCatalog: _catalog,
      unlockedBlockIds: {'wait'},
      capacityKb: 1, // wait costs 2KB
    );
    expect(result.isValid, isFalse);
    expect(result.errors.any((e) => e.contains('exceeds capacity')), isTrue);
  });
}
