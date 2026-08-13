import 'dart:convert';

import 'package:payload_server/src/business/log_storage_decision.dart';
import 'package:test/test.dart';

void main() {
  test('a small log is stored inline', () {
    final decision = LogStorageDecision.decide(jsonEncode({'events': []}));
    expect(decision.storeInline, isTrue);
  });

  test('a log over 32KB is not stored inline', () {
    final bigPayload = jsonEncode({'blob': 'x' * (33 * 1024)});
    final decision = LogStorageDecision.decide(bigPayload);
    expect(decision.storeInline, isFalse);
    expect(decision.byteSize, greaterThan(LogStorageDecision.inlineThresholdBytes));
  });

  test('exactly at the threshold is still inline', () {
    // Account for the JSON wrapper overhead by measuring back from a
    // string of the exact target byte length.
    final payload = 'x' * LogStorageDecision.inlineThresholdBytes;
    final decision = LogStorageDecision.decide(payload);
    expect(decision.byteSize, LogStorageDecision.inlineThresholdBytes);
    expect(decision.storeInline, isTrue);
  });
}
