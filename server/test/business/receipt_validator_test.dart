import 'package:payload_server/src/business/receipt_validator.dart';
import 'package:test/test.dart';

void main() {
  group('ReceiptVerification', () {
    test('valid constant reports isValid true with no reason', () {
      expect(ReceiptVerification.valid.isValid, isTrue);
      expect(ReceiptVerification.valid.failureReason, isNull);
    });

    test('invalid factory reports isValid false with the given reason', () {
      final result = ReceiptVerification.invalid('expired');
      expect(result.isValid, isFalse);
      expect(result.failureReason, 'expired');
    });
  });

  group('AlwaysRejectReceiptValidator', () {
    test('never approves a purchase, regardless of input', () async {
      const validator = AlwaysRejectReceiptValidator();
      final result = await validator.verify(sku: 'keys_pack_small', storeReceipt: 'anything');
      expect(result.isValid, isFalse);
      expect(result.failureReason, isNotEmpty);
    });
  });
}
