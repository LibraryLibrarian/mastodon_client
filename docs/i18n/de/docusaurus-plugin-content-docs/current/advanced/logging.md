---
sidebar_position: 1
---

# Logging

mastodon_client gibt HTTP-Anfragen und -Antworten standardmäßig auf stdout aus. Diese Ausgabe kann deaktiviert oder umgeleitet werden.

## Logs deaktivieren

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);
```

## Benutzerdefinierter Logger mit FunctionLogger

`FunctionLogger` passt einen einfachen Callback an das `Logger`-Interface an:

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

## Eigenen Logger implementieren

Für vollständige Kontrolle das `Logger`-Interface implementieren:

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

## Standardverhalten

Der Standard-`StdoutLogger` verwendet intern das `logger`-Paket. In Debug-Builds werden alle Log-Ebenen (debug und höher) ausgegeben. In Release-Builds werden nur Warnungen und höher ausgegeben.

Log-Format:

```
[mastodon_client] [LEVEL] 2025-01-01 12:00:00.000000 message
```
