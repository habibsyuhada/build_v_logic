import 'package:payload_server/src/business/sim_version.dart';
import 'package:test/test.dart';

void main() {
  test('the current version is compatible with itself', () {
    expect(SimVersionGate.isCompatible(currentSimVersion), isTrue);
  });

  test('any other version is rejected', () {
    expect(SimVersionGate.isCompatible(currentSimVersion - 1), isFalse);
    expect(SimVersionGate.isCompatible(currentSimVersion + 1), isFalse);
  });
}
