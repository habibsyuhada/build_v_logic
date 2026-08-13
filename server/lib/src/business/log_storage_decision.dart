import 'dart:convert';

/// Where a resolved battle's log should live (§2.4: "`log_ref` menunjuk
/// object storage (S3-compatible) untuk log >32 KB"). Pure sizing
/// decision — the actual object-storage upload is an infrastructure
/// concern (needs live S3-compatible credentials this environment
/// doesn't have) and is not implemented here; this class is the seam
/// where that upload call would go once such credentials exist.
class LogStorageDecision {
  static const int inlineThresholdBytes = 32 * 1024;

  final bool storeInline;
  final int byteSize;

  const LogStorageDecision({required this.storeInline, required this.byteSize});

  static LogStorageDecision decide(String battleLogJson) {
    final bytes = utf8.encode(battleLogJson).length;
    return LogStorageDecision(storeInline: bytes <= inlineThresholdBytes, byteSize: bytes);
  }
}
