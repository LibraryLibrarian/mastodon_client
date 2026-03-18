---
sidebar_position: 2
---

# 인증

Mastodon은 OAuth 2.0을 사용합니다. 대부분의 API 엔드포인트는 액세스 토큰이 필요합니다.

## 인증 흐름 개요

```
1. 앱 등록      → client_id / client_secret 획득
2. 사용자 인가  → 브라우저에서 인가 화면 열기 → 인가 코드 획득
3. 토큰 발급    → 인가 코드를 액세스 토큰으로 교환
```

## 1단계: 애플리케이션 등록

```dart
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

final clientId = app.clientId!;
final clientSecret = app.clientSecret!;
```

리디렉션 URI로 `urn:ietf:wg:oauth:2.0:oob`를 전달하면 OOB(Out-of-Band) 방식으로 동작하여 인가 코드가 화면에 표시됩니다. 웹 또는 모바일 앱의 경우 콜백 URL을 대신 지정하세요.

## 2단계: 사용자 인가

브라우저에서 인가 URL을 열어 사용자에게 권한을 요청합니다. 이 단계는 플랫폼에 따라 다르며 이 라이브러리에서는 다루지 않습니다.

```dart
// 인가 URL 생성
final authorizeUrl = Uri.parse('${baseUrl}/oauth/authorize').replace(
  queryParameters: {
    'client_id': clientId,
    'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
    'response_type': 'code',
    'scope': 'read write push',
  },
);
// → 이 URL을 브라우저에서 열기
```

사용자가 권한을 허용하면 인가 코드가 반환됩니다.

## 3단계: 액세스 토큰 발급

```dart
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode, // 2단계에서 받은 코드
);

print(token.accessToken); // API 호출에 사용할 토큰
```

발급받은 토큰으로 새 클라이언트를 초기화합니다:

```dart
final authenticatedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## 토큰 폐기

```dart
await client.oauth.revokeToken(
  clientId: clientId,
  clientSecret: clientSecret,
  token: accessToken,
);
```

## 클라이언트 자격 증명

사용자 상호작용 없이 앱 전용 토큰을 발급받으려면:

```dart
final token = await client.oauth.obtainToken(
  grantType: 'client_credentials',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  scope: 'read',
);
```

이 토큰으로는 공개 정보만 접근할 수 있습니다.

## 서버 메타데이터

서버가 지원하는 스코프와 엔드포인트를 미리 조회할 수 있습니다:

```dart
final metadata = await client.oauth.fetchServerMetadata();
print(metadata.scopesSupported);
```

## 스코프

| 스코프 | 설명 |
|--------|------|
| `read` | 모든 읽기 작업 |
| `write` | 모든 쓰기 작업 |
| `push` | Web Push 알림 수신 |
| `follow` | 팔로우 관계 변경 (`read:follows` + `write:follows`의 별칭) |
| `admin:read` | 관리자 읽기 작업 |
| `admin:write` | 관리자 쓰기 작업 |

`read:accounts`, `write:statuses` 와 같은 세분화된 스코프도 사용할 수 있습니다.
자세한 내용은 [Mastodon 공식 문서](https://docs.joinmastodon.org/api/oauth-scopes/)를 참고하세요.
