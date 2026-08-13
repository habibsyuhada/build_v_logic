import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'app.dart';
import 'features/campaign/campaign_controller.dart';
import 'features/core/content/content_repository.dart';
import 'features/core/storage/preset_storage.dart';
import 'features/core/storage/shared_prefs_campaign_storage.dart';
import 'features/core/storage/shared_prefs_preset_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final content = await ContentRepository.load(rootBundle);

  final presetStorage = await createSharedPrefsPresetStorage();
  final presets = PresetRepository(presetStorage);

  final campaignStorage = await createSharedPrefsCampaignStorage();
  final campaign = CampaignController(content: content, storage: campaignStorage);
  await campaign.load();

  runApp(PayloadApp(content: content, campaign: campaign, presets: presets));
}
