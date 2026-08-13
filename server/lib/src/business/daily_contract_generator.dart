import 'package:content_schema/content_schema.dart';

/// Generates the daily contract network (§1.5.5): one system-generated
/// puzzle network per day, seeded from the date so every player sees the
/// exact same layout. Pure function — same date in, same network out.
class DailyContractGenerator {
  /// Formats `YYYY-MM-DD` (UTC) — the canonical date key used for both the
  /// `DailyContract.contractDate` column and the seed derivation.
  static String dateKey(DateTime date) {
    final utc = date.toUtc();
    final y = utc.year.toString().padLeft(4, '0');
    final m = utc.month.toString().padLeft(2, '0');
    final d = utc.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// A stable, small non-negative seed derived from the date string —
  /// deliberately not `DateTime.hashCode` (unspecified/platform-dependent
  /// in Dart), so this is reproducible across SDK versions and platforms.
  static int seedFor(String dateKey) {
    var hash = 17;
    for (final code in dateKey.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    return hash;
  }

  /// Builds the network for [dateKey]. Difficulty is intentionally fixed
  /// (not scaled by anything time-based) — every contract is meant to be
  /// the same challenge for every player on that day.
  static NetworkDef buildNetwork(String dateKey) {
    final seed = seedFor(dateKey);
    final firewallLevel = 1 + (seed % 4); // 1..4
    final dataValue = 20 + (seed % 30); // 20..49

    final nodes = <NetworkNodeDef>[
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['r1']),
      const NetworkNodeDef(id: 'r1', type: NodeType.relay, edges: ['r2']),
      const NetworkNodeDef(id: 'r2', type: NodeType.relay, edges: ['r3']),
      const NetworkNodeDef(id: 'r3', type: NodeType.relay, edges: ['gate']),
      NetworkNodeDef(
        id: 'gate',
        type: NodeType.relay,
        edges: const ['data'],
        firewall: FirewallDef(level: firewallLevel),
      ),
      NetworkNodeDef(
        id: 'data',
        type: NodeType.data,
        edges: const ['entry'],
        data: DataDef(value: dataValue, verified: true),
      ),
      const NetworkNodeDef(id: 'spare1', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'spare2', type: NodeType.relay, edges: []),
    ];

    return NetworkDef(id: 'daily_$dateKey', nodes: nodes);
  }
}
