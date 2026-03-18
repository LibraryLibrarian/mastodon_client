---
sidebar_position: 1
slug: /
---

# 시작하기

:::warning 베타

이 라이브러리는 현재 **베타** 단계입니다. API 구현은 완료되었으나 테스트 커버리지가 최소한입니다. 테스트 결과에 따라 응답 모델 및 메서드 시그니처가 변경될 수 있습니다.

잘못된 응답 모델이나 예상치 못한 동작을 발견하시면 [GitHub Issues](https://github.com/LibraryLibrarian/mastodon_client/issues)로 보고하시거나 [Pull Request](https://github.com/LibraryLibrarian/mastodon_client/pulls)를 제출해 주세요.

:::

mastodon_client는 순수 Dart로 작성된 Mastodon API 클라이언트 라이브러리입니다.
Flutter, 서버사이드 Dart, CLI 도구 등 Dart가 실행되는 모든 환경에서 사용할 수 있습니다.

## 설치

`pubspec.yaml`에 의존성을 추가합니다:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.1
```

그런 다음 패키지를 가져옵니다:

```bash
dart pub get
```

## 기본 사용법

### 클라이언트 초기화

```dart
import 'package:mastodon_client/mastodon_client.dart';

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_access_token',
);
```

`baseUrl`에는 스킴(예: `https://`)을 포함해야 합니다.
인증이 필요 없는 엔드포인트만 사용하는 경우 `accessToken`은 생략할 수 있습니다.

### 첫 번째 API 호출

서버 정보 가져오기 (인증 불필요):

```dart
final instance = await client.instance.fetch();
print(instance.title);       // 서버 이름
print(instance.description); // 서버 설명
```

인증된 사용자의 계정 가져오기:

```dart
final me = await client.accounts.verifyCredentials();
print(me.displayName); // 표시 이름
print(me.acct);        // 사용자명
```

### API 구조

모든 API는 `MastodonClient`의 프로퍼티로 네임스페이스처럼 노출됩니다:

```dart
client.accounts      // 계정 관련 작업
client.statuses      // 상태(포스트) 관련 작업
client.timelines     // 타임라인 조회
client.notifications // 알림 관련 작업
client.media         // 미디어 업로드
client.search        // 검색
client.oauth         // OAuth 토큰 관련 작업
// ... 그 외 다수
```

### 로그 출력 제어

HTTP 요청/응답 로그는 기본적으로 stdout에 출력됩니다.

```dart
// 로그 비활성화
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);

// 커스텀 로거 사용
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // Your custom log handling
  }),
);
```

자세한 내용은 [로깅](./advanced/logging.md)을 참고하세요.

## 다음 단계

- [인증](./authentication.md) — OAuth를 통한 액세스 토큰 발급
- [페이지네이션](./pagination.md) — 커서 기반 페이지네이션
- [에러 처리](./error-handling.md) — 예외 계층 구조와 catch 패턴
