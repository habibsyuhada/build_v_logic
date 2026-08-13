import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/accessibility/accessibility_controller.dart';
import 'package:payload_app/features/core/accessibility/accessibility_settings.dart';
import 'package:payload_app/features/core/accessibility/accessibility_storage.dart';

void main() {
  test('AccessibilitySettings round-trips through JSON', () {
    const settings = AccessibilitySettings(
      colorblindSafePalette: true,
      reduceMotion: true,
      fontScale: FontScale.large,
      scanlineEnabled: true,
    );
    final decoded = AccessibilitySettings.fromJson(settings.toJson());

    expect(decoded.colorblindSafePalette, isTrue);
    expect(decoded.reduceMotion, isTrue);
    expect(decoded.fontScale, FontScale.large);
    expect(decoded.scanlineEnabled, isTrue);
  });

  test('missing keys fall back to the safe defaults', () {
    final decoded = AccessibilitySettings.fromJson(const {});
    expect(decoded.colorblindSafePalette, isFalse);
    expect(decoded.reduceMotion, isFalse);
    expect(decoded.fontScale, FontScale.normal);
    expect(decoded.scanlineEnabled, isFalse);
  });

  test('controller persists updates through its storage', () async {
    final storage = InMemoryAccessibilityStorage();
    final controller = AccessibilityController(storage: storage);
    await controller.load();

    await controller.setColorblindSafePalette(true);
    await controller.setFontScale(FontScale.large);

    final reloaded = AccessibilityController(storage: storage);
    await reloaded.load();
    expect(reloaded.settings.colorblindSafePalette, isTrue);
    expect(reloaded.settings.fontScale, FontScale.large);
  });
}
