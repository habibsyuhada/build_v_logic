import 'package:shared_preferences/shared_preferences.dart';

import 'preset_storage.dart';

const String _presetsKey = 'payload.virus_presets.v1';

/// Real on-device backend for [JsonBlobPresetStorage], wired at app
/// startup. Kept in its own file so `preset_storage.dart` stays free of a
/// platform-channel dependency (easier to unit test).
Future<PresetStorage> createSharedPrefsPresetStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return JsonBlobPresetStorage(
    read: () async => prefs.getString(_presetsKey),
    write: (value) => prefs.setString(_presetsKey, value),
  );
}
