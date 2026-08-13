import 'package:shared_preferences/shared_preferences.dart';

import 'campaign_storage.dart';

const String _campaignKey = 'payload.campaign_progress.v1';

Future<CampaignStorage> createSharedPrefsCampaignStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return JsonBlobCampaignStorage(
    read: () async => prefs.getString(_campaignKey),
    write: (value) => prefs.setString(_campaignKey, value),
  );
}
