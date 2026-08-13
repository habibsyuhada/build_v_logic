import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'app.dart';
import 'features/core/content/content_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final content = await ContentRepository.load(rootBundle);
  runApp(PayloadApp(content: content));
}
