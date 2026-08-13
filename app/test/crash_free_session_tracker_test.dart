import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/diagnostics/crash_free_session_tracker.dart';
import 'package:payload_app/features/core/diagnostics/error_reporter.dart';

void main() {
  test('a session with no fatal reports stays crash-free', () {
    final delegate = RecordingErrorReporter();
    final tracker = CrashFreeSessionTracker(delegate);

    tracker.report(Exception('non-fatal'), StackTrace.empty, fatal: false);

    expect(tracker.isCrashFree, isTrue);
    expect(tracker.fatalErrorCount, 0);
    expect(delegate.reports, hasLength(1));
  });

  test('a fatal report flips crash-free to false and counts it', () {
    final delegate = RecordingErrorReporter();
    final tracker = CrashFreeSessionTracker(delegate);

    tracker.report(Exception('boom'), StackTrace.empty, fatal: true);

    expect(tracker.isCrashFree, isFalse);
    expect(tracker.fatalErrorCount, 1);
  });

  test('multiple fatal reports accumulate', () {
    final tracker = CrashFreeSessionTracker(RecordingErrorReporter());

    tracker.report(Exception('a'), StackTrace.empty, fatal: true);
    tracker.report(Exception('b'), StackTrace.empty, fatal: true);
    tracker.report(Exception('c'), StackTrace.empty, fatal: false);

    expect(tracker.fatalErrorCount, 2);
  });

  test('every report is forwarded to the delegate reporter', () {
    final delegate = RecordingErrorReporter();
    final tracker = CrashFreeSessionTracker(delegate);
    final error = Exception('forwarded');

    tracker.report(error, StackTrace.empty, fatal: true);

    expect(delegate.reports.single.error, error);
    expect(delegate.reports.single.fatal, isTrue);
  });
}
