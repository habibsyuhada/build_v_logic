/// §1.8 accessibility toggles: colorblind-safe palette, large font, and
/// reduce-motion (screen-shake/scanline off) — plus the CRT scanline
/// effect itself, which §1.8 already specs as off-by-default/opt-in.
/// Stored as a single opaque JSON blob, both locally (so it applies before
/// login) and mirrored to `Player.settingsJson` server-side (§1.8, see
/// `PlayerEndpoint.updateSettings`).
enum FontScale {
  normal,
  large;

  static FontScale parse(String raw) => raw == 'large' ? FontScale.large : FontScale.normal;

  double get textScaleFactor => this == FontScale.large ? 1.3 : 1.0;
}

class AccessibilitySettings {
  final bool colorblindSafePalette;
  final bool reduceMotion;
  final FontScale fontScale;
  final bool scanlineEnabled;

  /// BCP-47 language code (`en`/`id`), or null to follow the device
  /// locale (§1.8/§5: "lokalisasi EN+ID"). Kept in this same settings blob
  /// rather than a second persisted system — one opaque JSON blob mirrors
  /// what `Player.settingsJson` already stores server-side.
  final String? localeCode;

  const AccessibilitySettings({
    this.colorblindSafePalette = false,
    this.reduceMotion = false,
    this.fontScale = FontScale.normal,
    this.scanlineEnabled = false,
    this.localeCode,
  });

  AccessibilitySettings copyWith({
    bool? colorblindSafePalette,
    bool? reduceMotion,
    FontScale? fontScale,
    bool? scanlineEnabled,
    String? Function()? localeCode,
  }) {
    return AccessibilitySettings(
      colorblindSafePalette: colorblindSafePalette ?? this.colorblindSafePalette,
      reduceMotion: reduceMotion ?? this.reduceMotion,
      fontScale: fontScale ?? this.fontScale,
      scanlineEnabled: scanlineEnabled ?? this.scanlineEnabled,
      localeCode: localeCode != null ? localeCode() : this.localeCode,
    );
  }

  factory AccessibilitySettings.fromJson(Map<String, dynamic> json) {
    return AccessibilitySettings(
      colorblindSafePalette: json['colorblind_safe_palette'] as bool? ?? false,
      reduceMotion: json['reduce_motion'] as bool? ?? false,
      fontScale: FontScale.parse(json['font_scale'] as String? ?? 'normal'),
      scanlineEnabled: json['scanline_enabled'] as bool? ?? false,
      localeCode: json['locale_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'colorblind_safe_palette': colorblindSafePalette,
        'reduce_motion': reduceMotion,
        'font_scale': fontScale == FontScale.large ? 'large' : 'normal',
        'scanline_enabled': scanlineEnabled,
        if (localeCode != null) 'locale_code': localeCode,
      };
}
