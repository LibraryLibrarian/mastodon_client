---
sidebar_position: 1
---

# ロギング

mastodon_client はデフォルトで HTTP リクエスト/レスポンスを標準出力にログ出力します。出力の無効化やリダイレクトが可能です。

## ログの無効化

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);
```

## FunctionLogger によるカスタムロガー

`FunctionLogger` はシンプルなコールバックを `Logger` インターフェースに適合させます。

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // level は 'debug', 'info', 'warn', 'error' のいずれか
    myLogger.log(level, message);
  }),
);
```

## Logger インターフェースの実装

完全な制御が必要な場合は `Logger` インターフェースを実装します。

```dart
class MyLogger implements Logger {
  @override
  void debug(String message) { /* ... */ }

  @override
  void info(String message) { /* ... */ }

  @override
  void warn(String message) { /* ... */ }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    // エラーとオプションのスタックトレースを処理
  }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: MyLogger(),
);
```

## デフォルトの動作

デフォルトの `StdoutLogger` は内部で `logger` パッケージを使用しています。デバッグビルドではすべてのログレベル（debug 以上）が出力されます。リリースビルドでは warning 以上のみが出力されます。

ログ形式:

```
[mastodon_client] [LEVEL] 2025-01-01 12:00:00.000000 message
```
