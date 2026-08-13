import 'package:payload_server/src/business/profanity_filter.dart';
import 'package:test/test.dart';

void main() {
  test('an ordinary title passes', () {
    expect(SimpleWordlistProfanityFilter.defaultFilter.isClean('Ghost in the Wire'), isTrue);
  });

  test('a banned word fails, case-insensitively', () {
    expect(SimpleWordlistProfanityFilter.defaultFilter.isClean('you FUCK'), isFalse);
  });

  test('a custom wordlist can be supplied', () {
    const filter = SimpleWordlistProfanityFilter({'banana'});
    expect(filter.isClean('banana split'), isFalse);
    expect(filter.isClean('apple pie'), isTrue);
  });
}
