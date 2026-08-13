import 'dart:convert';

import 'accessibility_settings.dart';

abstract class AccessibilityStorage {
  Future<AccessibilitySettings> load();
  Future<void> save(AccessibilitySettings settings);
}

class InMemoryAccessibilityStorage implements AccessibilityStorage {
  AccessibilitySettings _settings = const AccessibilitySettings();

  @override
  Future<AccessibilitySettings> load() async => _settings;

  @override
  Future<void> save(AccessibilitySettings settings) async => _settings = settings;
}

class JsonBlobAccessibilityStorage implements AccessibilityStorage {
  final Future<String?> Function() read;
  final Future<void> Function(String value) write;

  JsonBlobAccessibilityStorage({required this.read, required this.write});

  @override
  Future<AccessibilitySettings> load() async {
    final raw = await read();
    if (raw == null || raw.isEmpty) return const AccessibilitySettings();
    return AccessibilitySettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> save(AccessibilitySettings settings) async {
    await write(jsonEncode(settings.toJson()));
  }
}
