import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'features/campaign/campaign_controller.dart';
import 'features/core/accessibility/accessibility_controller.dart';
import 'features/core/content/content_repository.dart';
import 'features/core/routing/app_router.dart';
import 'features/core/storage/preset_storage.dart';
import 'features/core/theme/payload_theme.dart';
import 'features/core/theme/scanline_overlay.dart';
import 'l10n/app_localizations.dart';

class PayloadApp extends StatelessWidget {
  final ContentRepository content;
  final CampaignController campaign;
  final PresetRepository presets;
  final AccessibilityController accessibility;

  const PayloadApp({
    super.key,
    required this.content,
    required this.campaign,
    required this.presets,
    required this.accessibility,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContentRepository>.value(value: content),
        ChangeNotifierProvider<CampaignController>.value(value: campaign),
        Provider<PresetRepository>.value(value: presets),
        ChangeNotifierProvider<AccessibilityController>.value(value: accessibility),
      ],
      child: Builder(builder: (context) {
        final router = buildAppRouter(content);
        return ListenableBuilder(
          listenable: accessibility,
          builder: (context, _) {
            final settings = accessibility.settings;
            return MaterialApp.router(
              title: 'PAYLOAD',
              debugShowCheckedModeBanner: false,
              theme: buildPayloadTheme(colorblindSafe: settings.colorblindSafePalette),
              locale: settings.localeCode != null ? Locale(settings.localeCode!) : null,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) {
                final mediaQuery = MediaQuery.of(context);
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: TextScaler.linear(settings.fontScale.textScaleFactor),
                    disableAnimations: settings.reduceMotion || mediaQuery.disableAnimations,
                  ),
                  child: ScanlineOverlay(
                    enabled: settings.scanlineEnabled && !settings.reduceMotion,
                    child: child ?? const SizedBox.shrink(),
                  ),
                );
              },
              routerConfig: router,
            );
          },
        );
      }),
    );
  }
}
