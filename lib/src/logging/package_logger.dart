import 'package:logger/logger.dart' as pkg;

import '../client/constants.dart';

/// Provides the shared logger for the mastodon_client library.
///
/// In debug builds, detailed logs at the debug/trace level are output. In
/// release builds, only warnings and above are emitted, suppressing
/// verbose logs.
final pkg.Logger clientLog = pkg.Logger(
  level: kReleaseMode ? pkg.Level.warning : pkg.Level.debug,
  printer: _CustomLogPrinter(),
);

/// Custom log printer.
///
/// Output format:
/// `[mastodon_client] [LEVEL] YYYY-MM-DD HH:MM:SS.ffffff message`
class _CustomLogPrinter extends pkg.LogPrinter {
  static final Map<pkg.Level, String> _levelLabels = {
    pkg.Level.trace: 'TRACE',
    pkg.Level.debug: 'DEBUG',
    pkg.Level.info: 'INFO',
    pkg.Level.warning: 'WARNING',
    pkg.Level.error: 'ERROR',
    pkg.Level.fatal: 'FATAL',
  };

  @override
  List<String> log(pkg.LogEvent event) {
    final level = _levelLabels[event.level] ?? 'UNKNOWN';
    final time = DateTime.now().toString();
    final message = event.message;

    return ['[mastodon_client] [$level] $time $message'];
  }
}
