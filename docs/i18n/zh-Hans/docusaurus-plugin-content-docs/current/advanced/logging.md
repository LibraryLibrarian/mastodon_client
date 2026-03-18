---
sidebar_position: 1
---

# 日志

mastodon_client 默认将 HTTP 请求和响应日志输出到 stdout。你可以禁用或重定向这些输出。

## 禁用日志

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);
```

## 使用 FunctionLogger 自定义日志

`FunctionLogger` 将简单的回调函数适配为 `Logger` 接口：

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // level is one of: 'debug', 'info', 'warn', 'error'
    myLogger.log(level, message);
  }),
);
```

## 实现自定义 Logger

如需完全控制，可实现 `Logger` 接口：

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
    // Handle error with optional stack trace
  }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: MyLogger(),
);
```

## 默认行为

默认的 `StdoutLogger` 内部使用 `logger` 包。在调试构建中，所有日志级别（debug 及以上）都会输出。在发布构建中，只输出警告及以上级别的日志。

日志格式：

```
[mastodon_client] [LEVEL] 2025-01-01 12:00:00.000000 message
```
