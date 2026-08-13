import 'package:flutter/material.dart';

import 'features/core/content/content_repository.dart';
import 'features/core/routing/app_router.dart';
import 'features/core/theme/payload_theme.dart';

class PayloadApp extends StatelessWidget {
  final ContentRepository content;

  const PayloadApp({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final router = buildAppRouter(content);
    return MaterialApp.router(
      title: 'PAYLOAD',
      debugShowCheckedModeBanner: false,
      theme: buildPayloadTheme(),
      routerConfig: router,
    );
  }
}
