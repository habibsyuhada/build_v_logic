import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/campaign/campaign_controller.dart';
import 'features/core/content/content_repository.dart';
import 'features/core/routing/app_router.dart';
import 'features/core/storage/preset_storage.dart';
import 'features/core/theme/payload_theme.dart';

class PayloadApp extends StatelessWidget {
  final ContentRepository content;
  final CampaignController campaign;
  final PresetRepository presets;

  const PayloadApp({
    super.key,
    required this.content,
    required this.campaign,
    required this.presets,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContentRepository>.value(value: content),
        ChangeNotifierProvider<CampaignController>.value(value: campaign),
        Provider<PresetRepository>.value(value: presets),
      ],
      child: Builder(builder: (context) {
        final router = buildAppRouter(content);
        return MaterialApp.router(
          title: 'PAYLOAD',
          debugShowCheckedModeBanner: false,
          theme: buildPayloadTheme(),
          routerConfig: router,
        );
      }),
    );
  }
}
