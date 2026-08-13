import 'package:flutter/foundation.dart';

import 'accessibility_settings.dart';
import 'accessibility_storage.dart';

class AccessibilityController extends ChangeNotifier {
  final AccessibilityStorage storage;

  AccessibilitySettings _settings = const AccessibilitySettings();
  bool _loaded = false;

  AccessibilityController({required this.storage});

  AccessibilitySettings get settings => _settings;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _settings = await storage.load();
    _loaded = true;
    notifyListeners();
  }

  Future<void> _update(AccessibilitySettings Function(AccessibilitySettings) transform) async {
    _settings = transform(_settings);
    notifyListeners();
    await storage.save(_settings);
  }

  Future<void> setColorblindSafePalette(bool value) =>
      _update((s) => s.copyWith(colorblindSafePalette: value));

  Future<void> setReduceMotion(bool value) => _update((s) => s.copyWith(reduceMotion: value));

  Future<void> setFontScale(FontScale value) => _update((s) => s.copyWith(fontScale: value));

  Future<void> setScanlineEnabled(bool value) => _update((s) => s.copyWith(scanlineEnabled: value));

  /// Pass null to follow the device locale.
  Future<void> setLocaleCode(String? value) => _update((s) => s.copyWith(localeCode: () => value));
}
