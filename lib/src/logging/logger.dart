import 'package_logger.dart';

/// ライブラリ内部で使用するロガーインターフェース
///
/// デフォルトでは [StdoutLogger] が使用される。
/// 独自のログ出力先に差し替えたい場合は、このインターフェースを実装して
/// `MastodonClient` のコンストラクタに渡す。
abstract class Logger {
  /// デバッグレベルのメッセージを出力する
  void debug(String message);

  /// 情報レベルのメッセージを出力する
  void info(String message);

  /// 警告レベルのメッセージを出力する
  void warn(String message);

  /// エラーレベルのメッセージを出力する
  ///
  /// [error] と [stackTrace] を指定すると、エラーの詳細情報も出力される。
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

/// 標準出力にログを出力する [Logger] のデフォルト実装
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
