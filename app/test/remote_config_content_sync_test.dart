import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/remote_config/remote_config_content_sync.dart';
import 'package:payload_app/features/core/remote_config/remote_content_bundle.dart';
import 'package:payload_app/features/core/remote_config/remote_content_cache.dart';

class _FakeFetcher implements RemoteContentFetcher {
  String version;
  int fetchBundleCalls = 0;
  bool throwOnFetch = false;

  _FakeFetcher(this.version);

  @override
  Future<String> fetchVersion() async {
    if (throwOnFetch) throw Exception('network down');
    return version;
  }

  @override
  Future<RemoteContentBundle> fetchBundle() async {
    fetchBundleCalls++;
    if (throwOnFetch) throw Exception('network down');
    return RemoteContentBundle(
      version: version,
      blocks: const [BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 1)],
      balance: BalanceConfig.defaults,
    );
  }
}

void main() {
  test('an empty cache always triggers a full fetch', () async {
    final fetcher = _FakeFetcher('v1');
    final sync = RemoteConfigContentSync(fetcher: fetcher, cache: InMemoryRemoteContentCache());

    final result = await sync.sync();

    expect(result.outcome, SyncOutcome.updated);
    expect(result.bundle!.version, 'v1');
    expect(fetcher.fetchBundleCalls, 1);
  });

  test('a matching cached version skips the full fetch', () async {
    final fetcher = _FakeFetcher('v1');
    final cache = InMemoryRemoteContentCache();
    await cache.save(RemoteContentBundle(version: 'v1', blocks: const [], balance: BalanceConfig.defaults));

    final result = await RemoteConfigContentSync(fetcher: fetcher, cache: cache).sync();

    expect(result.outcome, SyncOutcome.upToDate);
    expect(fetcher.fetchBundleCalls, 0);
  });

  test('a version bump triggers exactly one full fetch and updates the cache', () async {
    final fetcher = _FakeFetcher('v2');
    final cache = InMemoryRemoteContentCache();
    await cache.save(RemoteContentBundle(version: 'v1', blocks: const [], balance: BalanceConfig.defaults));

    final result = await RemoteConfigContentSync(fetcher: fetcher, cache: cache).sync();

    expect(result.outcome, SyncOutcome.updated);
    expect(fetcher.fetchBundleCalls, 1);
    expect((await cache.load())!.version, 'v2');
  });

  test('a fetch failure falls back to whatever is cached, never throws', () async {
    final fetcher = _FakeFetcher('v1')..throwOnFetch = true;
    final cache = InMemoryRemoteContentCache();
    await cache.save(RemoteContentBundle(version: 'v0', blocks: const [], balance: BalanceConfig.defaults));

    final result = await RemoteConfigContentSync(fetcher: fetcher, cache: cache).sync();

    expect(result.outcome, SyncOutcome.fetchFailed);
    expect(result.bundle!.version, 'v0');
  });

  test('a fetch failure with no cache at all returns null bundle, not a throw', () async {
    final fetcher = _FakeFetcher('v1')..throwOnFetch = true;
    final result =
        await RemoteConfigContentSync(fetcher: fetcher, cache: InMemoryRemoteContentCache()).sync();

    expect(result.outcome, SyncOutcome.fetchFailed);
    expect(result.bundle, isNull);
  });

  test('JsonBlobRemoteContentCache round-trips a bundle through JSON', () async {
    String? stored;
    final cache = JsonBlobRemoteContentCache(
      read: () async => stored,
      write: (value) async => stored = value,
    );

    final bundle = RemoteContentBundle(
      version: 'v7',
      blocks: const [BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 1)],
      balance: BalanceConfig.defaults,
    );
    await cache.save(bundle);
    final reloaded = await cache.load();

    expect(reloaded!.version, 'v7');
    expect(reloaded.blocks.single.id, 'wait');
  });
}
