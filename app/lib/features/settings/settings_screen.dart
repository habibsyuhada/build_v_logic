import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/accessibility/accessibility_controller.dart';
import '../core/accessibility/accessibility_settings.dart';
import '../../l10n/app_localizations.dart';

/// §1.8 accessibility settings: colorblind-safe palette, large font,
/// reduce-motion, and the (off-by-default) CRT scanline effect, plus the
/// §5 EN/ID language picker. Every toggle here is paired with an
/// explanatory label, not just a color swatch — consistent with §1.8's
/// "semua info warna selalu didampingi ikon" rule applied to the settings
/// UI itself.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AccessibilityController>();
    final settings = controller.settings;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader(l10n.settingsAccessibilitySection),
          SwitchListTile(
            secondary: const Icon(Icons.palette_outlined),
            title: Text(l10n.settingsColorblindTitle),
            subtitle: Text(l10n.settingsColorblindSubtitle),
            value: settings.colorblindSafePalette,
            onChanged: controller.setColorblindSafePalette,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.text_fields),
            title: Text(l10n.settingsLargeTextTitle),
            value: settings.fontScale == FontScale.large,
            onChanged: (value) =>
                controller.setFontScale(value ? FontScale.large : FontScale.normal),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.accessibility_new),
            title: Text(l10n.settingsReduceMotionTitle),
            subtitle: Text(l10n.settingsReduceMotionSubtitle),
            value: settings.reduceMotion,
            onChanged: controller.setReduceMotion,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.tv_outlined),
            title: Text(l10n.settingsScanlineTitle),
            subtitle: Text(settings.reduceMotion
                ? l10n.settingsScanlineSubtitleDisabled
                : l10n.settingsScanlineSubtitleDefault),
            value: settings.scanlineEnabled && !settings.reduceMotion,
            onChanged: settings.reduceMotion ? null : controller.setScanlineEnabled,
          ),
          const SizedBox(height: 16),
          _SectionHeader(l10n.settingsLanguageSection),
          RadioGroup<String?>(
            groupValue: settings.localeCode,
            onChanged: (value) => controller.setLocaleCode(value),
            child: Column(
              children: [
                RadioListTile<String?>(
                  secondary: const Icon(Icons.public),
                  title: Text(l10n.settingsLanguageSystem),
                  value: null,
                ),
                RadioListTile<String?>(
                  secondary: const Icon(Icons.language),
                  title: Text(l10n.settingsLanguageEnglish),
                  value: 'en',
                ),
                RadioListTile<String?>(
                  secondary: const Icon(Icons.language),
                  title: Text(l10n.settingsLanguageIndonesian),
                  value: 'id',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
