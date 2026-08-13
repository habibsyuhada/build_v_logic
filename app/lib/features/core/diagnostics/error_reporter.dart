import 'package:flutter/foundation.dart';

/// One captured error/crash, independent of where it was reported to.
class ErrorReport {
  final Object error;
  final StackTrace stackTrace;
  final bool fatal;

  const ErrorReport({required this.error, required this.stackTrace, required this.fatal});
}

/// Crash/error reporting seam (§5 "Sentry/Grafana"). No `SentryErrorReporter`
/// is implemented here — this environment has no live Sentry DSN to send
/// to and verify against — but every uncaught error in the app already
/// flows through this interface (wired in `main.dart`), so adding one
/// later is a single new implementation, not a rewrite of the capture
/// path. Mirrors the `ReceiptValidator`/`AlwaysRejectReceiptValidator`
/// pattern: the seam is real, the live backend isn't.
abstract class ErrorReporter {
  void report(Object error, StackTrace stackTrace, {bool fatal = false});
}

/// Default reporter: logs to the console via `debugPrint`. Safe to ship —
/// never silently swallows an error, never requires network/credentials.
class ConsoleErrorReporter implements ErrorReporter {
  const ConsoleErrorReporter();

  @override
  void report(Object error, StackTrace stackTrace, {bool fatal = false}) {
    debugPrint('${fatal ? '[fatal]' : '[error]'} $error\n$stackTrace');
  }
}

/// Test/inspection double: records every report instead of printing it.
class RecordingErrorReporter implements ErrorReporter {
  final List<ErrorReport> reports = [];

  @override
  void report(Object error, StackTrace stackTrace, {bool fatal = false}) {
    reports.add(ErrorReport(error: error, stackTrace: stackTrace, fatal: fatal));
  }
}
