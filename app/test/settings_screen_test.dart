import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/accessibility/accessibility_controller.dart';
import 'package:payload_app/features/core/accessibility/accessibility_settings.dart';
import 'package:payload_app/features/core/accessibility/accessibility_storage.dart';
import 'package:payload_app/features/settings/settings_screen.dart';
import 'package:payload_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

Widget _wrap(AccessibilityController controller) {
  return ChangeNotifierProvider<AccessibilityController>.value(
    value: controller,
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SettingsScreen(),
    ),
  );
}

void main() {
  testWidgets('toggling colorblind-safe palette persists through the controller',
      (WidgetTester tester) async {
    final controller = AccessibilityController(storage: InMemoryAccessibilityStorage());
    await controller.load();
    await tester.pumpWidget(_wrap(controller));

    expect(controller.settings.colorblindSafePalette, isFalse);
    await tester.tap(find.text('Colorblind-safe palette'));
    await tester.pumpAndSettle();

    expect(controller.settings.colorblindSafePalette, isTrue);
  });

  testWidgets('turning on reduce motion disables the scanline toggle',
      (WidgetTester tester) async {
    final controller = AccessibilityController(storage: InMemoryAccessibilityStorage());
    await controller.load();
    await tester.pumpWidget(_wrap(controller));

    await tester.tap(find.text('Reduce motion'));
    await tester.pumpAndSettle();

    final scanlineTile = tester.widget<SwitchListTile>(
      find.ancestor(of: find.text('CRT scanline effect'), matching: find.byType(SwitchListTile)),
    );
    expect(scanlineTile.onChanged, isNull);
  });

  testWidgets('large text toggle switches the font scale', (WidgetTester tester) async {
    final controller = AccessibilityController(storage: InMemoryAccessibilityStorage());
    await controller.load();
    await tester.pumpWidget(_wrap(controller));

    expect(controller.settings.fontScale, FontScale.normal);
    await tester.tap(find.text('Large text'));
    await tester.pumpAndSettle();

    expect(controller.settings.fontScale, FontScale.large);
  });
}
