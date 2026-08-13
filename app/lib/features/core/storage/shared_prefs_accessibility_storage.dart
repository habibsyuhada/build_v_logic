import 'package:shared_preferences/shared_preferences.dart';

import '../accessibility/accessibility_storage.dart';

const String _accessibilityKey = 'payload.accessibility_settings.v1';

Future<AccessibilityStorage> createSharedPrefsAccessibilityStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return JsonBlobAccessibilityStorage(
    read: () async => prefs.getString(_accessibilityKey),
    write: (value) => prefs.setString(_accessibilityKey, value),
  );
}
