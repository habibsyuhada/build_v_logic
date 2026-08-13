import 'package:content_schema/content_schema.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/content/content_repository.dart';

/// Loads the *real* bundled content/ snapshot (not a hand-built fixture)
/// to catch drift between content/ and app/assets/content/, and to prove
/// the 60-mission campaign is actually well-formed end to end.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('real ContentRepository loads all 49 blocks, 60 missions, 60 networks', () async {
    final content = await ContentRepository.load(rootBundle);
    expect(content.blocks.length, 49);
    expect(content.missions.length, 60);
    expect(content.networksByMissionId.length, 60);
  });

  test('every real mission network passes validateNetwork', () async {
    final content = await ContentRepository.load(rootBundle);
    for (final mission in content.missions) {
      final network = content.networksByMissionId[mission.id]!;
      final result = validateNetwork(network);
      expect(result.isValid, isTrue, reason: '${mission.id}: ${result.errors.join('; ')}');
    }
  });

  test('every unlocked block across all missions is a real, known block id', () async {
    final content = await ContentRepository.load(rootBundle);
    final knownIds = content.blocksById.keys.toSet();
    for (final mission in content.missions) {
      for (final blockId in mission.unlocksBlocks) {
        expect(knownIds.contains(blockId), isTrue, reason: '${mission.id} unlocks unknown $blockId');
      }
    }
  });

  test('the starter kit alone can complete the loop (copy_data is a starter)', () async {
    final content = await ContentRepository.load(rootBundle);
    final starterIds = content.starterBlocks.map((b) => b.id).toSet();
    expect(starterIds, contains('copy_data'));
    expect(starterIds, contains('move_random'));
  });

  test('mission chapter/index pairs are exactly ch1_m1..ch6_m10 with no gaps or dupes', () async {
    final content = await ContentRepository.load(rootBundle);
    final ids = content.missions.map((m) => m.id).toSet();
    for (var ch = 1; ch <= 6; ch++) {
      for (var m = 1; m <= 10; m++) {
        expect(ids.contains('ch${ch}_m$m'), isTrue, reason: 'missing ch${ch}_m$m');
      }
    }
    expect(content.missions.length, 60);
  });
}
