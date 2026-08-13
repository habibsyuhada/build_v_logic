// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAccessibilitySection => 'Accessibility';

  @override
  String get settingsColorblindTitle => 'Colorblind-safe palette';

  @override
  String get settingsColorblindSubtitle =>
      'Swaps magenta/cyan accents for blue/orange';

  @override
  String get settingsLargeTextTitle => 'Large text';

  @override
  String get settingsReduceMotionTitle => 'Reduce motion';

  @override
  String get settingsReduceMotionSubtitle =>
      'Turns off screen-shake and the CRT scanline effect';

  @override
  String get settingsScanlineTitle => 'CRT scanline effect';

  @override
  String get settingsScanlineSubtitleDisabled =>
      'Disabled while reduce motion is on';

  @override
  String get settingsScanlineSubtitleDefault =>
      'Off by default — a cosmetic overlay';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsLanguageSystem => 'Follow system';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageIndonesian => 'Indonesian';
}
