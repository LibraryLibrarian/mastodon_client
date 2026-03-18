---
sidebar_position: 1
---

# 로깅

mastodon_client는 기본적으로 HTTP 요청과 응답을 stdout에 기록합니다. 이 출력을 비활성화하거나 다른 곳으로 전달할 수 있습니다.

## 로그 비활성화

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);
```

## FunctionLogger로 커스텀 로거 사용

`FunctionLogger`는 간단한 콜백을 `Logger` 인터페이스에 맞게 조정합니다:

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

## 커스텀 Logger 구현

완전한 제어를 원한다면 `Logger` 인터페이스를 직접 구현합니다:

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

## 기본 동작

기본 `StdoutLogger`는 내부적으로 `logger` 패키지를 사용합니다. 디버그 빌드에서는 모든 로그 레벨(debug 이상)이 출력됩니다. 릴리스 빌드에서는 경고 이상만 출력됩니다.

로그 형식:

```
[mastodon_client] [LEVEL] 2025-01-01 12:00:00.000000 message
```
