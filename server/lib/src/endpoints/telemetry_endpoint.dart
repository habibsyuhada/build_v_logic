import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';

/// Client telemetry ingestion (§2.6: "event funnel: install -> tutorial
/// step N -> first battle -> D1/D7 return. Kirim batched ke endpoint
/// sendiri"). Events are only ingested and stored here; a real dashboard
/// (Grafana/Amplitude/etc.) reading this table for funnel visualization
/// is outside this environment's scope — see docs/DECISIONS.md.
class TelemetryEndpoint extends Endpoint {
  /// Ingests a batch of client-side events. `player` may be unauthenticated
  /// (some funnel events, like first app open, happen before login).
  Future<int> ingest(Session session, {required List<TelemetryEvent> events}) async {
    if (events.isEmpty) return 0;

    UuidValue? playerId;
    final authInfo = session.authenticated;
    if (authInfo != null) {
      final player = await Player.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authInfo.authUserId),
      );
      playerId = player?.id;
    }

    final now = DateTime.now();
    final rows = [
      for (final e in events)
        TelemetryEvent(
          playerId: playerId,
          eventType: e.eventType,
          propertiesJson: e.propertiesJson,
          occurredAt: e.occurredAt,
          receivedAt: now,
        ),
    ];
    await TelemetryEvent.db.insert(session, rows);
    return rows.length;
  }
}
