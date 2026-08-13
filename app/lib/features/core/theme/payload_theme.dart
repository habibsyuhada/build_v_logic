import 'package:flutter/material.dart';

/// Pixel-art hacker aesthetic (§1.8): dark background, monospace type,
/// neon terminal accents. CRT scanline is a separate opt-in effect layer
/// (§1.8: "opsional, off by default demi baterai & aksesibilitas"), not
/// baked into the base theme.
class PayloadColors {
  static const background = Color(0xFF0A0E0C);
  static const surface = Color(0xFF121814);
  static const surfaceRaised = Color(0xFF1B241E);
  static const terminalGreen = Color(0xFF39FF88);
  static const magenta = Color(0xFFFF2FB0);
  static const cyan = Color(0xFF2FE8FF);
  static const warningAmber = Color(0xFFFFC145);
  static const dangerRed = Color(0xFFFF4D5E);
  static const textPrimary = Color(0xFFE6FBEF);
  static const textMuted = Color(0xFF7FA98F);

  // Colorblind-safe alternates (§1.8): swap magenta/cyan pairing for a
  // blue/orange pairing that stays distinguishable under deuteranopia and
  // protanopia simulation.
  static const cbSafeAccentA = Color(0xFF2F8CFF);
  static const cbSafeAccentB = Color(0xFFFF8C2F);
}

ThemeData buildPayloadTheme({bool colorblindSafe = false}) {
  final accentA = colorblindSafe ? PayloadColors.cbSafeAccentA : PayloadColors.magenta;
  final accentB = colorblindSafe ? PayloadColors.cbSafeAccentB : PayloadColors.cyan;

  final base = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: PayloadColors.background,
    fontFamily: 'RobotoMono',
    colorScheme: ColorScheme.dark(
      primary: PayloadColors.terminalGreen,
      secondary: accentA,
      tertiary: accentB,
      surface: PayloadColors.surface,
      error: PayloadColors.dangerRed,
      onPrimary: Colors.black,
      onSurface: PayloadColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: PayloadColors.surface,
      foregroundColor: PayloadColors.textPrimary,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: PayloadColors.textPrimary, fontFamily: 'monospace'),
      bodySmall: TextStyle(color: PayloadColors.textMuted, fontFamily: 'monospace'),
    ).apply(fontFamily: 'monospace'),
    cardColor: PayloadColors.surfaceRaised,
    dividerColor: PayloadColors.textMuted,
  );

  return base;
}
