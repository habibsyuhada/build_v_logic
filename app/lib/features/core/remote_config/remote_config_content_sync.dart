import 'remote_content_bundle.dart';
import 'remote_content_cache.dart';

enum SyncOutcome { upToDate, updated, fetchFailed }

class SyncResult {
  final SyncOutcome outcome;
  final RemoteContentBundle? bundle;

  const SyncResult(this.outcome, this.bundle);
}

/// Drives a remote-config content refresh (§2.1, §5): check the server's
/// current version, skip the (larger) full fetch if the local cache is
/// already current, and never throw — a fetch failure just means "keep
/// using whatever's cached (or the bundled asset snapshot)". This is the
/// exact "push a balance tweak without an app release" mechanism, minus
/// the live transport (see [RemoteContentFetcher]'s doc comment).
class RemoteConfigContentSync {
  final RemoteContentFetcher fetcher;
  final RemoteContentCache cache;

  RemoteConfigContentSync({required this.fetcher, required this.cache});

  Future<SyncResult> sync() async {
    try {
      final remoteVersion = await fetcher.fetchVersion();
      final cached = await cache.load();
      if (cached != null && cached.version == remoteVersion) {
        return SyncResult(SyncOutcome.upToDate, cached);
      }

      final bundle = await fetcher.fetchBundle();
      await cache.save(bundle);
      return SyncResult(SyncOutcome.updated, bundle);
    } catch (_) {
      final cached = await cache.load();
      return SyncResult(SyncOutcome.fetchFailed, cached);
    }
  }
}
