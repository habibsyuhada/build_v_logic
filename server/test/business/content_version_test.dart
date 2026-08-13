import 'package:payload_server/src/business/content_version.dart';
import 'package:test/test.dart';

void main() {
  test('is deterministic for the same inputs', () {
    final a = ContentVersion.hashFor(blocksJson: '[1]', balanceJson: '{}', shopJson: '[]');
    final b = ContentVersion.hashFor(blocksJson: '[1]', balanceJson: '{}', shopJson: '[]');
    expect(a, b);
  });

  test('changes when any one input changes', () {
    final base = ContentVersion.hashFor(blocksJson: '[1]', balanceJson: '{}', shopJson: '[]');
    final blocksChanged =
        ContentVersion.hashFor(blocksJson: '[2]', balanceJson: '{}', shopJson: '[]');
    final balanceChanged =
        ContentVersion.hashFor(blocksJson: '[1]', balanceJson: '{"x":1}', shopJson: '[]');
    final shopChanged =
        ContentVersion.hashFor(blocksJson: '[1]', balanceJson: '{}', shopJson: '[1]');

    expect(blocksChanged, isNot(base));
    expect(balanceChanged, isNot(base));
    expect(shopChanged, isNot(base));
  });

  test('is a 64-char hex SHA-256 digest', () {
    final hash = ContentVersion.hashFor(blocksJson: '[]', balanceJson: '{}', shopJson: '[]');
    expect(hash, matches(RegExp(r'^[0-9a-f]{64}$')));
  });
}
