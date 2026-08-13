import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/campaign/campaign_controller.dart';
import 'package:payload_app/features/core/content/content_repository.dart';
import 'package:payload_app/features/core/storage/campaign_storage.dart';
import 'package:sim_core/sim_core.dart';

MissionDef _mission(String id, int chapter, int index,
        {List<String> unlocks = const [], int maxNoise = 60, int maxTick = 100}) =>
    MissionDef(
      id: id,
      chapter: chapter,
      indexInChapter: index,
      title: 'title',
      networkId: 'net_$id',
      unlocksBlocks: unlocks,
      starCriteria: MissionStarCriteria(maxNoiseForStar: maxNoise, maxTickForStar: maxTick),
    );

ContentRepository _content() => ContentRepository.forTesting(
      blocks: [
        const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 1),
        const BlockDef(
            id: 'brute_force', family: BlockFamily.action, sizeKb: 6, unlockMission: 'ch1_m1'),
      ],
      balance: BalanceConfig.defaults,
      trainingNetwork: NetworkDef(id: 'train', nodes: [
        const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: []),
        for (var i = 0; i < 7; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
      ]),
      missions: [
        _mission('ch1_m1', 1, 1, unlocks: const ['brute_force']),
        _mission('ch1_m2', 1, 2),
        _mission('ch1_m3', 1, 3),
      ],
    );

BattleResult _result({
  int dataExfiltrated = 0,
  int survivingCopies = 0,
  int deadCopies = 0,
  int peakNoise = 0,
  int ticksUsed = 50,
}) =>
    BattleResult(
      ticksUsed: ticksUsed,
      dataExfiltrated: dataExfiltrated,
      logsDeleted: 0,
      cleanExits: 0,
      survivingCopies: survivingCopies,
      deadCopies: deadCopies,
      tracePenalty: 0,
      score: 0,
      peakNoiseMeter: peakNoise,
    );

void main() {
  late CampaignController controller;
  late ContentRepository content;

  setUp(() {
    content = _content();
    controller = CampaignController(content: content, storage: InMemoryCampaignStorage());
  });

  test('only the first mission is available before anything is completed', () async {
    await controller.load();
    expect(controller.isMissionAvailable('ch1_m1'), isTrue);
    expect(controller.isMissionAvailable('ch1_m2'), isFalse);
    expect(controller.isMissionAvailable('ch1_m3'), isFalse);
  });

  test('completing a mission with 0 stars does not unlock the next one', () async {
    await controller.load();
    // Failing run: no exfil, no survivors, noisy, slow.
    await controller.completeMission(
        content.missions[0], _result(peakNoise: 999, ticksUsed: 999));
    expect(controller.starsFor('ch1_m1'), 0);
    expect(controller.isMissionAvailable('ch1_m2'), isFalse);
  });

  test('a clean, silent, fast run earns all 3 stars and unlocks the block', () async {
    await controller.load();
    final stars = await controller.completeMission(
      content.missions[0],
      _result(dataExfiltrated: 10, survivingCopies: 1, peakNoise: 5, ticksUsed: 10),
    );
    expect(stars, 3);
    expect(controller.starsFor('ch1_m1'), 3);
    expect(controller.isBlockUnlocked('brute_force'), isTrue);
    expect(controller.isMissionAvailable('ch1_m2'), isTrue);
  });

  test('a merely-completed run (loud, slow) earns exactly 1 star', () async {
    await controller.load();
    final stars = await controller.completeMission(
      content.missions[0],
      _result(dataExfiltrated: 10, survivingCopies: 1, peakNoise: 999, ticksUsed: 999),
    );
    expect(stars, 1);
  });

  test('starter blocks are always unlocked regardless of progress', () async {
    final starterContent = ContentRepository.forTesting(
      blocks: [
        const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 1), // no unlock_mission
      ],
      balance: BalanceConfig.defaults,
      trainingNetwork: content.trainingNetwork,
    );
    final c = CampaignController(content: starterContent, storage: InMemoryCampaignStorage());
    await c.load();
    expect(c.isBlockUnlocked('wait'), isTrue);
  });

  test('a better replay of an already-3-starred mission never decreases the stored stars', () async {
    await controller.load();
    await controller.completeMission(
      content.missions[0],
      _result(dataExfiltrated: 10, survivingCopies: 1, peakNoise: 5, ticksUsed: 10),
    );
    expect(controller.starsFor('ch1_m1'), 3);

    await controller.completeMission(content.missions[0], _result()); // a bad run afterwards
    expect(controller.starsFor('ch1_m1'), 3); // stays at the best-ever result
  });

  test('progress persists through the storage layer', () async {
    final storage = InMemoryCampaignStorage();
    final a = CampaignController(content: content, storage: storage);
    await a.load();
    await a.completeMission(
      content.missions[0],
      _result(dataExfiltrated: 10, survivingCopies: 1, peakNoise: 5, ticksUsed: 10),
    );

    final b = CampaignController(content: content, storage: storage);
    await b.load();
    expect(b.starsFor('ch1_m1'), 3);
    expect(b.isBlockUnlocked('brute_force'), isTrue);
  });
}
