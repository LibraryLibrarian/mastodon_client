---
sidebar_position: 4
---

# 에러 처리

이 라이브러리는 Mastodon API 에러를 `MastodonException`을 루트로 하는 sealed 클래스 계층 구조로 매핑합니다.

## 예외 계층 구조

```
MastodonException (sealed)
├── MastodonApiException              // 일반 HTTP 응답 에러
│   ├── MastodonUnauthorizedException // 401 - 인증 에러
│   ├── MastodonForbiddenException    // 403 - 권한 에러
│   ├── MastodonNotFoundException     // 404 - 리소스 없음
│   ├── MastodonRateLimitException    // 429 - 요청 제한 초과
│   │   └── retryAfter                //   재시도 권장 대기 시간
│   ├── MastodonValidationException   // 422 - 유효성 검사 에러
│   │   ├── serverMessage             //   서버의 상세 메시지
│   │   └── MastodonAlreadyVotedException // 이미 투표함
│   └── MastodonServerException       // 5xx - 서버 에러
├── MastodonNetworkException          // 네트워크 연결 에러
├── MastodonAuthException (sealed)    // OAuth 인증 흐름 에러
│   ├── MastodonAuthCancelledException    // 사용자가 취소
│   ├── MastodonAuthStateMismatchException // CSRF 감지
│   └── MastodonAuthTokenException        // 토큰 획득 실패
└── MastodonMediaProcessingTimeoutException // 미디어 처리 타임아웃
```

## 기본 catch 패턴

### 모든 에러 잡기

```dart
try {
  final status = await client.statuses.fetch(id);
} on MastodonException catch (e) {
  print('Error: $e');
}
```

### HTTP 상태 코드별 처리

```dart
try {
  final account = await client.accounts.fetchById(accountId);
} on MastodonNotFoundException {
  print('계정을 찾을 수 없습니다');
} on MastodonUnauthorizedException {
  print('토큰이 유효하지 않습니다. 다시 인증해 주세요');
} on MastodonRateLimitException catch (e) {
  print('요청 제한 초과. ${e.retryAfter} 후 재시도하세요');
} on MastodonApiException catch (e) {
  print('API 에러 (${e.statusCode}): ${e.message}');
} on MastodonNetworkException {
  print('네트워크 연결을 확인해 주세요');
}
```

### 유효성 검사 에러 상세 정보 가져오기

```dart
try {
  await client.statuses.create(request);
} on MastodonValidationException catch (e) {
  print('유효성 검사 에러: ${e.serverMessage}');
}
```

## 특수 예외

### MastodonAlreadyVotedException

이미 투표한 설문에 다시 투표하려 할 때 발생합니다.

```dart
try {
  await client.polls.vote(pollId, [0]);
} on MastodonAlreadyVotedException {
  print('이미 이 설문에 투표했습니다');
}
```

### MastodonMediaProcessingTimeoutException

업로드 후 비동기 미디어 처리가 타임아웃되면 발생합니다.

```dart
try {
  final attachment = await client.media.upload(bytes, 'photo.jpg');
} on MastodonMediaProcessingTimeoutException catch (e) {
  print('미디어 ${e.mediaId} 처리가 타임아웃되었습니다');
  // 나중에 client.media.fetchById(e.mediaId)로 상태를 확인하세요
}
```

## 요청 제한 처리

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
    final wait = e.retryAfter ?? const Duration(seconds: 60);
    await Future<void>.delayed(wait);
    return action();
  }
}

// 사용 예시
final timeline = await withRetry(
  () => client.timelines.fetchHome(limit: 20),
);
```
