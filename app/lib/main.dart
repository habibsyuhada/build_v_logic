import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'app.dart';
import 'features/campaign/campaign_controller.dart';
import 'features/core/accessibility/accessibility_controller.dart';
import 'features/core/content/content_repository.dart';
import 'features/core/diagnostics/crash_free_session_tracker.dart';
import 'features/core/diagnostics/error_reporter.dart';
import 'features/core/storage/preset_storage.dart';
import 'features/core/storage/shared_prefs_accessibility_storage.dart';
import 'features/core/storage/shared_prefs_campaign_storage.dart';
import 'features/core/storage/shared_prefs_preset_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final errorReporter = CrashFreeSessionTracker(const ConsoleErrorReporter());
  FlutterError.onError = (details) {
    errorReporter.report(details.exception, details.stack ?? StackTrace.empty, fatal: true);
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    errorReporter.report(error, stack, fatal: true);
    return true;
  };

  final content = await ContentRepository.load(rootBundle);

  final presetStorage = await createSharedPrefsPresetStorage();
  final presets = PresetRepository(presetStorage);

  final campaignStorage = await createSharedPrefsCampaignStorage();
  final campaign = CampaignController(content: content, storage: campaignStorage);
  await campaign.load();

  final accessibilityStorage = await createSharedPrefsAccessibilityStorage();
  final accessibility = AccessibilityController(storage: accessibilityStorage);
  await accessibility.load();

  runApp(PayloadApp(
    content: content,
    campaign: campaign,
    presets: presets,
    accessibility: accessibility,
  ));
}
