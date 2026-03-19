---
sidebar_position: 13
---

# 기타 API

이 페이지에서는 예약 포스트, 트렌드, 프로필 이미지 관리, 앱 등록, 이메일 인증, 비동기 새로고침 상태를 다룹니다.

## 예약 포스트

`client.scheduledStatuses`를 사용하면 나중에 게시하도록 예약된 포스트를 관리할 수 있습니다. 예약 포스트를 생성하려면 `client.statuses.create` 호출 시 `scheduledAt`을 전달하세요.

### 예약 포스트 목록 조회

```dart
final page = await client.scheduledStatuses.fetch(limit: 20);
for (final s in page.items) {
  print('${s.id} scheduled for ${s.scheduledAt}');
}

// 페이지네이션
if (page.nextMaxId != null) {
  final next = await client.scheduledStatuses.fetch(maxId: page.nextMaxId);
}
```

`MastodonPage<MastodonScheduledStatus>`를 반환합니다. 기본 limit은 20이고 최대는 40입니다.

### 단일 예약 포스트 조회

```dart
final s = await client.scheduledStatuses.fetchById('9876');
```

### 일정 변경

새 시간은 현재 시각으로부터 최소 5분 이후여야 하며 ISO 8601 형식으로 제공해야 합니다:

```dart
final updated = await client.scheduledStatuses.update(
  '9876',
  scheduledAt: '2025-12-31T23:59:00.000Z',
);
```

### 예약 취소

```dart
await client.scheduledStatuses.delete('9876');
```

## 트렌드

모든 트렌드 엔드포인트는 공개 접근이며 인증이 필요하지 않습니다. `client.trends`를 사용합니다.

### 트렌딩 태그

```dart
final tags = await client.trends.fetchTags(limit: 10);
for (final tag in tags) {
  print('#${tag.name}');
}
```

지난 한 주 동안 사용량이 증가한 태그를 내부 트렌드 점수 순으로 반환합니다. 기본 limit은 10이고 최대는 20입니다. 페이지네이션에는 `offset`을 사용합니다.

### 트렌딩 포스트

```dart
final statuses = await client.trends.fetchStatuses(limit: 20);
```

평소보다 훨씬 많은 상호작용을 받은 포스트를 반환합니다. 기본 limit은 20이고 최대는 40입니다.

### 트렌딩 링크

```dart
final links = await client.trends.fetchLinks(limit: 10);
for (final link in links) {
  print(link.url);
}
```

네트워크 전반에서 자주 공유되는 링크를 반환합니다. 기본 limit은 10이고 최대는 20입니다.

세 가지 메서드 모두 오프셋 기반 페이지네이션을 위한 `offset` 파라미터를 지원합니다.

## 프로필 이미지 관리

`client.profile`을 사용하면 프로필 아바타 및 헤더 이미지를 삭제할 수 있습니다.

### 아바타 삭제

```dart
final account = await client.profile.deleteAvatar();
```

### 헤더 삭제

```dart
final account = await client.profile.deleteHeader();
```

두 메서드 모두 업데이트된 `MastodonCredentialAccount`를 반환하며, 현재 이미지가 없어도 성공합니다. `write:accounts` OAuth 스코프가 필요합니다.

새 아바타나 헤더를 업로드하려면 `client.accounts.updateCredentials`를 사용하세요.

## 앱 등록

OAuth 애플리케이션 등록 및 토큰 검증에는 `client.apps`를 사용합니다.

### 애플리케이션 등록

```dart
final app = await client.apps.create(
  clientName: 'My Mastodon App',
  redirectUris: ['myapp://oauth/callback'],
  scopes: 'read write push',
  website: 'https://example.com',
);
print(app.clientId);
print(app.clientSecret);
```

`redirectUris`는 필수입니다. OOB 방식에는 `['urn:ietf:wg:oauth:2.0:oob']`를 전달합니다. `scopes`를 생략하면 `read`가 기본값으로 사용됩니다. `MastodonCredentialApplication`을 반환합니다.

### 앱 자격 증명 검증

```dart
final app = await client.apps.verifyCredentials();
print(app.name);
```

`MastodonApplication`을 반환합니다. 토큰이 유효하지 않으면 인증 에러가 발생합니다.

## 이메일 인증

`client.emails`는 새로 가입한 계정의 인증 이메일 재발송을 처리합니다.

### 인증 이메일 재발송

```dart
await client.emails.resendConfirmation();

// 동시에 이메일 주소를 업데이트하는 경우
await client.emails.resendConfirmation(email: 'new@example.com');
```

`email`을 제공하면 인증을 발송하기 전에 미확인 이메일 주소가 업데이트됩니다.

### 인증 상태 확인

```dart
await client.emails.checkConfirmation();
```

두 메서드 모두 미확인 계정을 생성한 클라이언트에서 얻은 토큰이 필요합니다.

## 비동기 새로고침

`client.asyncRefreshes`를 사용하면 백그라운드 새로고침 작업의 진행 상황을 확인할 수 있습니다. 이는 Mastodon 4.4.0에서 추가된 실험적 API입니다.

응답에 `Mastodon-Async-Refresh` 헤더가 포함된 경우, 해당 값은 작업이 완료될 때까지 폴링할 수 있는 ID입니다:

```dart
final refresh = await client.asyncRefreshes.fetch('refresh-id-from-header');
print(refresh.complete); // 완료되면 true
```

`MastodonAsyncRefresh`를 반환합니다. `read` OAuth 스코프가 필요합니다.
