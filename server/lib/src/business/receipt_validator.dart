/// Result of verifying a store receipt.
class ReceiptVerification {
  final bool isValid;
  final String? failureReason;
  const ReceiptVerification({required this.isValid, this.failureReason});

  static const ReceiptVerification valid = ReceiptVerification(isValid: true);
  factory ReceiptVerification.invalid(String reason) =>
      ReceiptVerification(isValid: false, failureReason: reason);
}

/// Server-side IAP receipt verification (§2.5: "verifikasi receipt
/// server-side (Google Play Developer API / App Store Server API)").
///
/// This is the seam: a real deployment implements one class per store,
/// each calling out to the respective store's server API with live
/// service-account/shared-secret credentials this environment doesn't
/// have. [AlwaysRejectReceiptValidator] is the only implementation
/// provided here — it's intentionally *not* a stub that pretends to
/// succeed, since a validator that always approves purchases would be a
/// dangerous default to accidentally ship.
abstract class ReceiptValidator {
  Future<ReceiptVerification> verify({required String sku, required String storeReceipt});
}

class AlwaysRejectReceiptValidator implements ReceiptValidator {
  const AlwaysRejectReceiptValidator();

  @override
  Future<ReceiptVerification> verify({required String sku, required String storeReceipt}) async {
    return ReceiptVerification.invalid(
        'no live store API credentials configured in this environment');
  }
}
