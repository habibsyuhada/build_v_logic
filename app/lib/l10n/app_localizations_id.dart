// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsAccessibilitySection => 'Aksesibilitas';

  @override
  String get settingsColorblindTitle => 'Palet warna aman buta warna';

  @override
  String get settingsColorblindSubtitle =>
      'Mengganti aksen magenta/cyan dengan biru/oranye';

  @override
  String get settingsLargeTextTitle => 'Teks besar';

  @override
  String get settingsReduceMotionTitle => 'Kurangi gerakan';

  @override
  String get settingsReduceMotionSubtitle =>
      'Mematikan efek getar layar dan scanline CRT';

  @override
  String get settingsScanlineTitle => 'Efek scanline CRT';

  @override
  String get settingsScanlineSubtitleDisabled =>
      'Nonaktif selama kurangi gerakan aktif';

  @override
  String get settingsScanlineSubtitleDefault =>
      'Nonaktif secara default — efek kosmetik';

  @override
  String get settingsLanguageSection => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Ikuti sistem';

  @override
  String get settingsLanguageEnglish => 'Inggris';

  @override
  String get settingsLanguageIndonesian => 'Indonesia';
}
