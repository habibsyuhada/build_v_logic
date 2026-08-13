import 'dart:convert';

import '../../workbench/models/virus_preset.dart';

/// Max saved presets per player (§2.4 `virus_presets` schema comment: "max
/// 12 preset/pemain").
const int maxVirusPresets = 12;

/// Local preset persistence (§2.2 "penyimpanan preset lokal"). Abstracted
/// behind an interface so tests can use [InMemoryPresetStorage] instead of
/// touching platform channels via shared_preferences.
abstract class PresetStorage {
  Future<List<VirusPreset>> loadAll();
  Future<void> saveAll(List<VirusPreset> presets);
}

class PresetLimitExceeded implements Exception {
  final int limit;
  const PresetLimitExceeded(this.limit);
  @override
  String toString() => 'PresetLimitExceeded: max $limit presets';
}

/// Thin domain layer over [PresetStorage] enforcing [maxVirusPresets] and
/// upsert-by-id semantics, independent of the storage backend.
class PresetRepository {
  final PresetStorage storage;
  PresetRepository(this.storage);

  Future<List<VirusPreset>> list() => storage.loadAll();

  Future<void> upsert(VirusPreset preset) async {
    final all = await storage.loadAll();
    final idx = all.indexWhere((p) => p.id == preset.id);
    if (idx >= 0) {
      all[idx] = preset;
    } else {
      if (all.length >= maxVirusPresets) {
        throw const PresetLimitExceeded(maxVirusPresets);
      }
      all.add(preset);
    }
    await storage.saveAll(all);
  }

  Future<void> delete(String id) async {
    final all = await storage.loadAll();
    all.removeWhere((p) => p.id == id);
    await storage.saveAll(all);
  }
}

class InMemoryPresetStorage implements PresetStorage {
  List<VirusPreset> _presets = [];

  @override
  Future<List<VirusPreset>> loadAll() async => List.of(_presets);

  @override
  Future<void> saveAll(List<VirusPreset> presets) async {
    _presets = List.of(presets);
  }
}

/// Encodes/decodes the preset list as a single JSON blob under one
/// SharedPreferences key. Takes the string-keyed get/set functions rather
/// than the `shared_preferences` package directly so this file has no
/// platform-channel dependency of its own (kept in the app's storage
/// adapter instead — see `shared_prefs_preset_storage.dart`).
class JsonBlobPresetStorage implements PresetStorage {
  final Future<String?> Function() read;
  final Future<void> Function(String value) write;

  JsonBlobPresetStorage({required this.read, required this.write});

  @override
  Future<List<VirusPreset>> loadAll() async {
    final raw = await read();
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => VirusPreset.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> saveAll(List<VirusPreset> presets) async {
    await write(jsonEncode(presets.map((p) => p.toJson()).toList()));
  }
}
