import 'package:payload_server/src/business/server_content.dart';
import 'package:test/test.dart';

/// Exercises the actual file-loading path (server/content/blocks.json +
/// balance.json), not just hand-built fixture catalogs like the other
/// business tests use — catches drift between the server's bundled copy
/// and the real content_schema shapes.
void main() {
  test('loads the real server/content/blocks.json and balance.json', () {
    final content = ServerContent.instance;
    expect(content.blocks, isNotEmpty);
    expect(content.blocksById.length, content.blocks.length);
    expect(content.balance.maxTicksPerBattle, 600);
  });

  test('every block referenced in blocks.json is retrievable by id', () {
    final content = ServerContent.instance;
    for (final block in content.blocks) {
      expect(content.blocksById[block.id], same(block));
    }
  });

  test('loads the real server/content/shop.json', () {
    final content = ServerContent.instance;
    expect(content.skus, isNotEmpty);
    expect(content.skusById.length, content.skus.length);
  });
}
