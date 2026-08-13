import 'error_reporter.dart';

/// Tracks whether the current app session has seen a fatal error — the
/// client-side half of the "crash-free sessions >99.5%" AC (§5 Phase 6).
/// The percentage itself needs a live analytics backend aggregating
/// across real users (not verifiable in this environment, see
/// docs/ACCEPTANCE.md); this is the per-session signal that backend would
/// aggregate, and it's independently testable without one.
class CrashFreeSessionTracker implements ErrorReporter {
  final ErrorReporter _delegate;
  int _fatalCount = 0;

  CrashFreeSessionTracker(this._delegate);

  bool get isCrashFree => _fatalCount == 0;
  int get fatalErrorCount => _fatalCount;

  @override
  void report(Object error, StackTrace stackTrace, {bool fatal = false}) {
    if (fatal) _fatalCount++;
    _delegate.report(error, stackTrace, fatal: fatal);
  }
}
