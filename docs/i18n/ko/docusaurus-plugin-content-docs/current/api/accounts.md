---
sidebar_position: 1
---

# 계정

`client.accounts` API는 계정 정보 조회 및 관리 작업을 제공합니다.

## 계정 조회

### ID로 조회

```dart
final account = await client.accounts.fetchById('12345');
print(account.displayName);
print(account.followersCount);
```

### 사용자명(acct)으로 조회

```dart
final account = await client.accounts.lookup('user@mastodon.social');
```

서버가 lookup 엔드포인트를 지원하지 않는 경우, 라이브러리가 자동으로 검색 기반 조회로 폴백합니다.

### 현재 사용자

```dart
final me = await client.accounts.verifyCredentials();
print(me.source); // 인증된 사용자에게만 제공되는 추가 필드
```

### 여러 계정 조회

```dart
final accounts = await client.accounts.fetchMultiple(['1', '2', '3']);
```

### 검색

```dart
final results = await client.accounts.search(
  'keyword',
  limit: 10,
  resolve: true, // WebFinger를 통해 원격 계정 조회
);
```

## 소셜 그래프

### 팔로워 및 팔로잉

두 메서드 모두 페이지네이션을 지원하는 `MastodonPage<MastodonAccount>`를 반환합니다.

```dart
final followers = await client.accounts.fetchFollowers('12345', limit: 40);
final following = await client.accounts.fetchFollowing('12345', limit: 40);
```

비공개 계정의 경우 에러를 던지지 않고 빈 페이지를 반환합니다.

### 관계 정보

```dart
final rels = await client.accounts.fetchRelationships(['12345', '67890']);
for (final rel in rels) {
  print('${rel.id}: following=${rel.following}, followedBy=${rel.followedBy}');
}
```

### 공통 팔로워

```dart
final familiar = await client.accounts.fetchFamiliarFollowers(['12345']);
```

## 팔로우 / 언팔로우

```dart
// 옵션과 함께 팔로우
final rel = await client.accounts.follow(
  '12345',
  reblogs: true,        // 홈 타임라인에 부스트 표시
  notify: true,         // 새 포스트 시 알림 받기
  languages: ['en'],    // 해당 언어 포스트만 표시
);

// 언팔로우
await client.accounts.unfollow('12345');
```

## 차단 / 뮤트

```dart
// 차단
await client.accounts.block('12345');
await client.accounts.unblock('12345');

// 기간 지정 뮤트
await client.accounts.mute('12345', duration: 3600); // 1시간
await client.accounts.unmute('12345');
```

## 프로필 관련 작업

### 프로필 수정

```dart
final updated = await client.accounts.updateCredentials(
  MastodonCredentialAccountUpdateRequest(
    displayName: 'New Name',
    note: 'Updated bio',
  ),
);
```

### 추천(endorse) / 추천 해제

```dart
await client.accounts.endorse('12345');   // 프로필에 피처
await client.accounts.unendorse('12345'); // 프로필에서 제거
```

### 비공개 메모

```dart
await client.accounts.setNote('12345', comment: 'Met at conference');
```

## 계정 포스트 목록

```dart
final page = await client.accounts.fetchStatuses(
  '12345',
  limit: 20,
  excludeReplies: true,
  excludeReblogs: true,
);
```

사용 가능한 필터: `excludeReplies`, `excludeReblogs`, `onlyMedia`, `pinned`, `tagged`.
