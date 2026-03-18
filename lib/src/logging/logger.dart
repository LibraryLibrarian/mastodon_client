import 'package_logger.dart';

/// Logger interface used internally by the library.
///
/// [StdoutLogger] is used by default.
/// To redirect log output to a custom destination, implement this interface
/// and pass it to the `MastodonClient` constructor.
abstract class Logger {
  /// Logs a debug-level message.
  void debug(String message);

  /// Logs an info-level message.
  void info(String message);

  /// Logs a warning-level message.
  void warn(String message);

  /// Logs an error-level message.
  ///
  /// When [error] and [stackTrace] are provided, detailed error information is
  /// also output.
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

/// Default [Logger] implementation that outputs logs to stdout.
class StdoutLogger implements Logger {
  const StdoutLogger();

  @override
  void debug(String message) {
    clientLog.d(message);
  }

  @override
  void info(String message) {
    clientLog.i(message);
  }

  @override
  void warn(String message) {
    clientLog.w(message);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (error != null || stackTrace != null) {
      clientLog.e(message, error: error, stackTrace: stackTrace);
    } else {
      clientLog.e(message);
    }
  }
}
