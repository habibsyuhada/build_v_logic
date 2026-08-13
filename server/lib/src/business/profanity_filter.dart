/// First-pass profanity check for blueprint titles (§2.5: "Blueprint text
/// (judul) melalui filter profanity + laporan pemain + moderation_state").
///
/// This is a plain banned-substring matcher — a real deployment would call
/// a moderation API (e.g. a managed content-safety service), which needs
/// live credentials this environment doesn't have. The `ProfanityFilter`
/// interface is the seam: swap [SimpleWordlistProfanityFilter] for a real
/// API-backed implementation without touching call sites.
abstract class ProfanityFilter {
  bool isClean(String text);
}

class SimpleWordlistProfanityFilter implements ProfanityFilter {
  final Set<String> _bannedWords;

  const SimpleWordlistProfanityFilter(this._bannedWords);

  static const SimpleWordlistProfanityFilter defaultFilter = SimpleWordlistProfanityFilter({
    // Deliberately tiny placeholder list — a real deployment replaces this
    // with a moderation API, not a longer hardcoded wordlist.
    'fuck',
    'shit',
    'bitch',
    'asshole',
  });

  @override
  bool isClean(String text) {
    final lower = text.toLowerCase();
    for (final word in _bannedWords) {
      if (lower.contains(word)) return false;
    }
    return true;
  }
}
