import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/l10n/app_localizations.dart';

void main() {
  test('EN and ID are both declared as supported locales', () {
    final codes = AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
    expect(codes, containsAll(['en', 'id']));
  });

  test('AppLocalizations.delegate resolves both EN and ID', () async {
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    final id = await AppLocalizations.delegate.load(const Locale('id'));

    expect(en.settingsTitle, 'Settings');
    expect(id.settingsTitle, 'Pengaturan');
    expect(en.settingsScanlineTitle, isNotEmpty);
    expect(id.settingsScanlineTitle, isNotEmpty);
  });
}
