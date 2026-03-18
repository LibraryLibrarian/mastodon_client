---
sidebar_position: 1
---

# Logging

mastodon_client logs HTTP requests and responses to stdout by default. You can disable or redirect this output.

## Disabling logs

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);
```

## Custom logger with FunctionLogger

`FunctionLogger` adapts a simple callback to the `Logger` interface:

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

## Implementing a custom Logger

For full control, implement the `Logger` interface:

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

## Default behavior

The default `StdoutLogger` uses the `logger` package internally. In debug builds, all log levels (debug and above) are output. In release builds, only warnings and above are emitted.

Log format:

```
[mastodon_client] [LEVEL] 2025-01-01 12:00:00.000000 message
```
