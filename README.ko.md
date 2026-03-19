[English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-Hans.md) | [Deutsch](README.de.md) | [Français](README.fr.md)

# mastodon_client

[Mastodon](https://joinmastodon.org/) API를 위한 순수 Dart 클라이언트 라이브러리. 모든 주요 API 카테고리에 대한 타입 안전 접근을 제공하며, 내장 OAuth 지원, 커서 기반 페이지네이션, 구조화된 오류 처리를 갖추고 있습니다.

> **베타**: API 구현은 완료되었으나 테스트 커버리지가 최소한입니다. 테스트 결과에 따라 응답 모델 및 메서드 시그니처가 변경될 수 있습니다. 자세한 내용은 [CHANGELOG](CHANGELOG.md)를 참조하세요.

## 기능

- Mastodon의 모든 주요 API 카테고리 지원 (계정, 포스트, 타임라인, 알림, 미디어 등)
- OAuth 2.0 토큰 관리 (획득, 취소, PKCE 지원)
- `MastodonPage<T>`를 통한 커서 기반 페이지네이션
- 완전한 오류 처리를 위한 sealed 예외 계층
- 자동 v2/v1 폴백 및 처리 폴링을 지원하는 비동기 미디어 업로드
- 교체 가능한 `Logger` 인터페이스를 통한 설정 가능한 로깅
- 순수 Dart — Flutter 의존성 불필요

## 설치

`pubspec.yaml`에 패키지를 추가하세요:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.1
```

그런 다음 실행하세요:

```
dart pub get
```

## 빠른 시작

```dart
import 'package:mastodon_client/mastodon_client.dart';

void main() async {
  final client = MastodonClient(
    baseUrl: 'https://mastodon.social',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  // Fetch the authenticated user
  final me = await client.accounts.verifyCredentials();
  print(me.displayName);

  // Post a status
  await client.statuses.create(
    MastodonStatusCreateRequest(
      status: 'Hello from mastodon_client!',
      visibility: MastodonVisibility.public,
    ),
  );

  // Paginated home timeline
  final page = await client.timelines.fetchHome(limit: 20);
  for (final status in page.items) {
    print(status.content);
  }
}
```

## API 개요

`MastodonClient`는 다음 속성들을 노출하며, 각각 Mastodon API의 서로 다른 영역을 담당합니다:

| 속성 | 설명 |
|---|---|
| `accounts` | 계정 정보, 검색, 팔로우, 차단, 뮤트, 프로필 업데이트 |
| `statuses` | 포스트 작성, 편집, 삭제, 부스트, 좋아요, 북마크, 핀, 번역 |
| `timelines` | 홈, 로컬, 연합, 해시태그, 목록 타임라인 |
| `notifications` | 알림, 정책, 요청 (v1 + 그룹화 v2) |
| `media` | 업로드 (v2/v1 폴백), 비동기 처리, 업데이트, 삭제 |
| `search` | 계정, 포스트, 해시태그 (오프셋 + 커서 페이지네이션) |
| `filters` | 키워드 및 포스트 항목을 포함한 v2 CRUD (+ 지원 종료된 v1) |
| `lists` | 목록 CRUD 및 계정 관리 |
| `oauth` | 토큰 획득/취소, 서버 메타데이터, 사용자 정보 |
| `apps` | 애플리케이션 등록 및 확인 |
| `instance` | 서버 정보 (v1/v2), 피어, 활동, 규칙, 도메인 차단 |
| `customEmojis` | 커스텀 이모지 목록 |
| `announcements` | 서버 공지 및 반응 |
| `conversations` | 다이렉트 메시지 대화 |
| `polls` | 투표 조회 및 투표 참여 |
| `push` | Web Push 구독 관리 |
| `tags` | 해시태그 정보, 팔로우/언팔로우 |
| `trends` | 트렌딩 태그, 포스트, 링크 |
| `blocks` | 차단된 계정 목록 |
| `mutes` | 뮤트된 계정 목록 |
| `domainBlocks` | 사용자 수준 도메인 차단 관리 |
| `reports` | 신고 생성 |
| `followRequests` | 팔로우 요청 관리 |
| `suggestions` | 팔로우 추천 |
| `favourites` | 좋아요한 포스트 목록 |
| `bookmarks` | 북마크한 포스트 목록 |
| `endorsements` | 추천 계정 목록 |
| `featuredTags` | 주목 태그 관리 |
| `followedTags` | 팔로우한 태그 목록 |
| `directory` | 프로필 디렉터리 |
| `preferences` | 사용자 환경설정 |
| `markers` | 타임라인 읽기 위치 마커 |
| `scheduledStatuses` | 예약 포스트 관리 |
| `health` | 서버 상태 확인 |
| `profile` | 아바타/헤더 이미지 관리 |
| `groupedNotifications` | 그룹화된 알림 (v2) |
| `adminAccounts` | 관리자 계정 관리 |
| `adminReports` | 관리자 신고 관리 |
| `adminDomainBlocks` | 관리자 도메인 차단 관리 |
| `adminDomainAllows` | 관리자 도메인 허용 관리 |
| `adminIpBlocks` | 관리자 IP 차단 관리 |
| `adminCanonicalEmailBlocks` | 관리자 정규 이메일 차단 관리 |
| `adminEmailDomainBlocks` | 관리자 이메일 도메인 차단 관리 |
| `adminTags` | 관리자 태그 관리 |
| `adminTrends` | 관리자 트렌드 관리 |
| `adminMeasures` | 관리자 정량적 측정값 |
| `adminDimensions` | 관리자 범주형 차원 |
| `adminRetention` | 관리자 사용자 유지율 코호트 |

## 인증

Mastodon은 OAuth 2.0을 사용합니다. 애플리케이션을 등록하고, 사용자를 인증 페이지로 리디렉션한 뒤 코드를 토큰으로 교환하세요:

```dart
// 1. Register your app
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

// 2. Direct the user to the authorization URL (platform-dependent)

// 3. Exchange the authorization code for a token
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: app.clientId!,
  clientSecret: app.clientSecret!,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode,
);

// 4. Create a new client with the token
final authedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## 오류 처리

모든 예외는 sealed 클래스 `MastodonException`을 상속하며, 완전한 패턴 매칭이 가능합니다:

```dart
try {
  final user = await client.accounts.fetchById('abc123');
} on MastodonUnauthorizedException {
  // 401 — token invalid or expired
} on MastodonForbiddenException {
  // 403 — operation not permitted
} on MastodonNotFoundException {
  // 404 — resource not found
} on MastodonRateLimitException catch (e) {
  // 429 — rate limited; check e.retryAfter
} on MastodonValidationException {
  // 422 — invalid request body
} on MastodonServerException {
  // 5xx — server-side error
} on MastodonNetworkException {
  // Timeout, connection refused, etc.
}
```

## 로깅

`enableLog`를 통해 내장 stdout 로거를 활성화하거나, 커스텀 `Logger` 구현을 제공하세요:

```dart
class MyLogger implements Logger {
  @override void debug(String message) { /* ... */ }
  @override void info(String message)  { /* ... */ }
  @override void warn(String message)  { /* ... */ }
  @override void error(String message, [Object? error, StackTrace? stackTrace]) { /* ... */ }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  logger: MyLogger(),
);
```

## 문서

- API 레퍼런스: https://librarylibrarian.github.io/mastodon_client/
- pub.dev 페이지: https://pub.dev/packages/mastodon_client
- GitHub: https://github.com/LibraryLibrarian/mastodon_client

## 라이선스

[LICENSE](LICENSE)를 참조하세요.
