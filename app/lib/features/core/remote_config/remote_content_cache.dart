import 'dart:convert';

import 'remote_content_bundle.dart';

abstract class RemoteContentCache {
  Future<RemoteContentBundle?> load();
  Future<void> save(RemoteContentBundle bundle);
}

class InMemoryRemoteContentCache implements RemoteContentCache {
  RemoteContentBundle? _bundle;

  @override
  Future<RemoteContentBundle?> load() async => _bundle;

  @override
  Future<void> save(RemoteContentBundle bundle) async => _bundle = bundle;
}

class JsonBlobRemoteContentCache implements RemoteContentCache {
  final Future<String?> Function() read;
  final Future<void> Function(String value) write;

  JsonBlobRemoteContentCache({required this.read, required this.write});

  @override
  Future<RemoteContentBundle?> load() async {
    final raw = await read();
    if (raw == null || raw.isEmpty) return null;
    return RemoteContentBundle.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> save(RemoteContentBundle bundle) async {
    await write(jsonEncode({
      'version': bundle.version,
      'blocks': bundle.blocks.map((b) => b.toJson()).toList(),
      'balance': bundle.balance.toJson(),
    }));
  }
}
