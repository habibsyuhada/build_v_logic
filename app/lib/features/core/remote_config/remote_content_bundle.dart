import 'package:content_schema/content_schema.dart';

/// A versioned content snapshot fetched from `ContentEndpoint.fetchBundle`
/// (§2.1, §5 "remote config"). Mirrors what `ContentRepository` already
/// loads from the asset bundle, plus the version string used to decide
/// whether a re-fetch is worth doing at all.
class RemoteContentBundle {
  final String version;
  final List<BlockDef> blocks;
  final BalanceConfig balance;

  const RemoteContentBundle({
    required this.version,
    required this.blocks,
    required this.balance,
  });

  factory RemoteContentBundle.fromJson(Map<String, dynamic> json) {
    return RemoteContentBundle(
      version: json['version'] as String,
      blocks: (json['blocks'] as List)
          .map((e) => BlockDef.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: BalanceConfig.fromJson(json['balance'] as Map<String, dynamic>),
    );
  }
}

/// The transport seam: a real implementation calls the generated
/// Serverpod client's `ContentEndpoint`. No such implementation is wired
/// up here — the app has never been connected to a live server in this
/// environment (see docs/DECISIONS.md) — but [RemoteConfigContentSync]
/// below is fully exercised against a fake in tests, so the
/// version-check/cache/fallback logic itself is real and verified ahead
/// of that wiring.
abstract class RemoteContentFetcher {
  Future<String> fetchVersion();
  Future<RemoteContentBundle> fetchBundle();
}
