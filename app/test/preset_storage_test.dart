import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/storage/preset_storage.dart';
import 'package:payload_app/features/workbench/models/virus_preset.dart';

VirusPreset _preset(String id) => VirusPreset(
      id: id,
      name: 'preset $id',
      program: const DagDef(nodes: [DagNode(id: 'a', blockId: 'wait')], entry: 'a'),
      updatedAt: DateTime.utc(2026, 1, 1),
    );

void main() {
  late PresetRepository repo;

  setUp(() {
    repo = PresetRepository(InMemoryPresetStorage());
  });

  test('upsert adds a new preset', () async {
    await repo.upsert(_preset('a'));
    final all = await repo.list();
    expect(all.map((p) => p.id), ['a']);
  });

  test('upsert with an existing id replaces it in place, not appends', () async {
    await repo.upsert(_preset('a'));
    await repo.upsert(_preset('a').copyWith(name: 'renamed'));
    final all = await repo.list();
    expect(all.length, 1);
    expect(all.single.name, 'renamed');
  });

  test('delete removes a preset by id', () async {
    await repo.upsert(_preset('a'));
    await repo.upsert(_preset('b'));
    await repo.delete('a');
    final all = await repo.list();
    expect(all.map((p) => p.id), ['b']);
  });

  test('enforces the max_virus_presets cap (§2.4: 12 per player)', () async {
    for (var i = 0; i < maxVirusPresets; i++) {
      await repo.upsert(_preset('p$i'));
    }
    expect(repo.upsert(_preset('overflow')), throwsA(isA<PresetLimitExceeded>()));
  });

  test('updating an existing preset is still allowed once at the cap', () async {
    for (var i = 0; i < maxVirusPresets; i++) {
      await repo.upsert(_preset('p$i'));
    }
    await repo.upsert(_preset('p0').copyWith(name: 'updated at cap'));
    final all = await repo.list();
    expect(all.length, maxVirusPresets);
    expect(all.firstWhere((p) => p.id == 'p0').name, 'updated at cap');
  });

  test('JsonBlobPresetStorage round-trips through a JSON string backend', () async {
    String? stored;
    final storage = JsonBlobPresetStorage(
      read: () async => stored,
      write: (v) async => stored = v,
    );
    final blobRepo = PresetRepository(storage);
    await blobRepo.upsert(_preset('a'));

    // Simulate a fresh app start reading from the same backing string.
    final reloaded = PresetRepository(JsonBlobPresetStorage(read: () async => stored, write: (v) async => stored = v));
    final all = await reloaded.list();
    expect(all.single.id, 'a');
    expect(all.single.program.nodes.single.blockId, 'wait');
  });
}
