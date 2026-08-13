import 'dart:convert';

import '../../campaign/models/campaign_progress.dart';

abstract class CampaignStorage {
  Future<CampaignProgress> load();
  Future<void> save(CampaignProgress progress);
}

class InMemoryCampaignStorage implements CampaignStorage {
  CampaignProgress _progress = const CampaignProgress();

  @override
  Future<CampaignProgress> load() async => _progress;

  @override
  Future<void> save(CampaignProgress progress) async => _progress = progress;
}

class JsonBlobCampaignStorage implements CampaignStorage {
  final Future<String?> Function() read;
  final Future<void> Function(String value) write;

  JsonBlobCampaignStorage({required this.read, required this.write});

  @override
  Future<CampaignProgress> load() async {
    final raw = await read();
    if (raw == null || raw.isEmpty) return const CampaignProgress();
    return CampaignProgress.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> save(CampaignProgress progress) async {
    await write(jsonEncode(progress.toJson()));
  }
}
