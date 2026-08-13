import 'package:payload_server/src/business/daily_contract_generator.dart';
import 'package:test/test.dart';

void main() {
  group('dateKey', () {
    test('formats as YYYY-MM-DD in UTC', () {
      expect(DailyContractGenerator.dateKey(DateTime.utc(2026, 8, 13)), '2026-08-13');
    });

    test('pads single-digit month/day', () {
      expect(DailyContractGenerator.dateKey(DateTime.utc(2026, 1, 5)), '2026-01-05');
    });

    test('converts a non-UTC time to its UTC date', () {
      final local = DateTime.utc(2026, 8, 13, 23, 30).toLocal();
      expect(DailyContractGenerator.dateKey(local), '2026-08-13');
    });
  });

  group('seedFor', () {
    test('is deterministic for the same key', () {
      expect(DailyContractGenerator.seedFor('2026-08-13'), DailyContractGenerator.seedFor('2026-08-13'));
    });

    test('differs across different keys', () {
      expect(DailyContractGenerator.seedFor('2026-08-13'), isNot(DailyContractGenerator.seedFor('2026-08-14')));
    });

    test('is always non-negative', () {
      for (final key in ['2026-01-01', '2026-12-31', '2000-02-29']) {
        expect(DailyContractGenerator.seedFor(key), greaterThanOrEqualTo(0));
      }
    });
  });

  group('buildNetwork', () {
    test('is deterministic for the same date key', () {
      final a = DailyContractGenerator.buildNetwork('2026-08-13');
      final b = DailyContractGenerator.buildNetwork('2026-08-13');
      expect(a.toJson(), b.toJson());
    });

    test('ids the network by its date key', () {
      final network = DailyContractGenerator.buildNetwork('2026-08-13');
      expect(network.id, 'daily_2026-08-13');
    });

    test('has exactly one entry node and one data node', () {
      final network = DailyContractGenerator.buildNetwork('2026-08-13');
      expect(network.nodes.where((n) => n.type.name == 'entry'), hasLength(1));
      expect(network.nodes.where((n) => n.type.name == 'data'), hasLength(1));
    });

    test('gate firewall level is within 1..4', () {
      for (final key in ['2026-01-01', '2026-03-17', '2026-08-13', '2026-12-31']) {
        final network = DailyContractGenerator.buildNetwork(key);
        final gate = network.nodes.firstWhere((n) => n.id == 'gate');
        expect(gate.firewall.level, inInclusiveRange(1, 4));
      }
    });

    test('data value is within 20..49', () {
      for (final key in ['2026-01-01', '2026-03-17', '2026-08-13', '2026-12-31']) {
        final network = DailyContractGenerator.buildNetwork(key);
        final data = network.nodes.firstWhere((n) => n.id == 'data');
        expect(data.data.value, inInclusiveRange(20, 49));
      }
    });

    test('every edge target exists as a node id', () {
      final network = DailyContractGenerator.buildNetwork('2026-08-13');
      final ids = network.nodes.map((n) => n.id).toSet();
      for (final node in network.nodes) {
        for (final edge in node.edges) {
          expect(ids.contains(edge), isTrue, reason: 'edge $edge from ${node.id} dangles');
        }
      }
    });
  });
}
