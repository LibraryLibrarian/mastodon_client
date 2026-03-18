---
sidebar_position: 5
---

# 검색

`client.search` API는 단일 요청으로 계정, 포스트, 해시태그를 검색합니다.

## 기본 검색

```dart
final result = await client.search.search('mastodon');

print('Accounts: ${result.accounts.length}');
print('Statuses: ${result.statuses.length}');
print('Hashtags: ${result.hashtags.length}');
```

결과는 세 가지 목록을 가진 `MastodonSearchResult`입니다:

- `accounts` — `List<MastodonAccount>`
- `statuses` — `List<MastodonStatus>`
- `hashtags` — `List<MastodonTag>`

## 타입별 필터링

`type`을 전달하면 결과를 하나의 카테고리로 제한합니다. 허용 값은 `'accounts'`, `'statuses'`, `'hashtags'`입니다.

```dart
// 계정만
final result = await client.search.search('alice', type: 'accounts');

// 포스트만
final result = await client.search.search('hello world', type: 'statuses');

// 해시태그만
final result = await client.search.search('dart', type: 'hashtags');
```

## 원격 계정 조회

`resolve: true`로 설정하면 로컬 결과가 없을 때 WebFinger를 통해 원격 계정을 조회합니다. 사용자 토큰이 필요합니다.

```dart
final result = await client.search.search(
  'alice@example.social',
  resolve: true,
);
```

## 팔로우하는 계정으로 제한

`following: true`로 설정하면 팔로우하는 계정만 반환합니다. 사용자 토큰이 필요합니다.

```dart
final result = await client.search.search(
  'alice',
  type: 'accounts',
  following: true,
);
```

## 포스트를 특정 계정으로 제한

`accountId`를 사용하면 포스트 결과를 특정 계정의 포스트로 제한합니다.

```dart
final result = await client.search.search(
  'hello',
  type: 'statuses',
  accountId: '109876543210',
);
```

## 미검토 해시태그 제외

`excludeUnreviewed: true`로 설정하면 모더레이터가 검토하지 않은 해시태그를 숨깁니다 (Mastodon 3.0.0에서 추가).

```dart
final result = await client.search.search(
  'dart',
  type: 'hashtags',
  excludeUnreviewed: true,
);
```

## 페이지네이션

검색 API는 `type`이 지정된 경우 오프셋 기반 페이지네이션을, `minId` / `maxId`를 사용한 커서 기반 페이지네이션도 지원합니다.

### 오프셋 기반 페이지네이션

`offset`은 처음부터 결과를 건너뜁니다. `limit` 및 고정된 `type`과 함께 사용합니다. 사용자 토큰이 필요합니다.

```dart
final page1 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 0,
);

final page2 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 20,
);
```

### 커서 기반 페이지네이션

타임라인 엔드포인트와 유사하게 `maxId`와 `minId`를 사용합니다.

```dart
final result = await client.search.search(
  'mastodon',
  type: 'statuses',
  maxId: '109876543210',
);
```

카테고리당 기본 `limit`은 20이며 최대는 40입니다.

## 비권장: v1 검색

`searchV1()`은 Mastodon 3.0.0에서 제거되었습니다. 아직 2.x를 실행 중인 인스턴스와의 호환성을 위해서만 제공됩니다. 모든 새 통합에는 `search()`를 사용하세요.

v2와의 주요 차이점:

- `hashtags`는 `List<MastodonTag>` 대신 `List<String>` (단순 이름)을 반환합니다.
- `following` 및 `excludeUnreviewed` 파라미터를 사용할 수 없습니다.
