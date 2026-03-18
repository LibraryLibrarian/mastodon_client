---
sidebar_position: 3
---

# 페이지네이션

Mastodon API는 커서 기반 페이지네이션을 사용합니다. 이 라이브러리는 `MastodonPage<T>`로 이를 추상화합니다.

## MastodonPage 구조

```dart
class MastodonPage<T> {
  final List<T> items;      // 현재 페이지의 아이템 목록
  final String? nextMaxId;  // 다음 페이지(더 오래된) 커서
  final String? prevMinId;  // 이전 페이지(더 최근) 커서
}
```

## 기본 사용법

### 첫 번째 페이지 가져오기

```dart
final page = await client.notifications.fetch(limit: 20);

for (final notification in page.items) {
  print(notification.type);
}
```

### 다음 페이지 가져오기 (더 오래된 항목)

`nextMaxId`를 `maxId` 파라미터로 전달합니다:

```dart
if (page.nextMaxId != null) {
  final nextPage = await client.notifications.fetch(
    limit: 20,
    maxId: page.nextMaxId,
  );
}
```

### 이전 페이지 가져오기 (더 최근 항목)

`prevMinId`를 `minId` 파라미터로 전달합니다:

```dart
if (page.prevMinId != null) {
  final prevPage = await client.notifications.fetch(
    limit: 20,
    minId: page.prevMinId,
  );
}
```

## 페이지네이션 파라미터

| 파라미터 | 방향 | 설명 |
|----------|------|------|
| `maxId` | 더 오래된 방향 | 이 ID보다 이전 결과 반환 |
| `sinceId` | 더 최근 방향 | 이 ID 이후 결과 반환 (중간 항목 누락 가능) |
| `minId` | 더 최근 방향 | 이 ID 바로 다음부터 결과 반환 (누락 없음) |
| `limit` | — | 최대 결과 수 (생략 시 서버 기본값) |

### `sinceId`와 `minId`의 차이

- `sinceId`: 지정한 ID보다 최근인 결과 중 **가장 최근** `limit`개를 반환 (사이 항목 누락 가능)
- `minId`: 지정한 ID **바로 다음**부터 `limit`개를 반환 (누락 없는 순차 페이지네이션)

실시간 업데이트 확인에는 `sinceId`를, 순차적 페이지 탐색에는 `minId`를 사용하세요.

## 모든 페이지 순회하기

```dart
Future<List<MastodonNotification>> fetchAll() async {
  final all = <MastodonNotification>[];
  String? maxId;

  while (true) {
    final page = await client.notifications.fetch(
      limit: 40,
      maxId: maxId,
    );
    all.addAll(page.items);

    if (page.nextMaxId == null) break;
    maxId = page.nextMaxId;
  }

  return all;
}
```

:::caution
한 번에 대량의 데이터를 가져오면 서버에 부하가 걸립니다. 요청 제한(rate limit)에 유의하세요.
:::

## 페이지네이션을 지원하는 API

페이지네이션된 결과를 반환하는 주요 API:

- `client.notifications.fetch()` — 알림
- `client.accounts.fetchFollowers()` — 팔로워
- `client.accounts.fetchFollowing()` — 팔로잉
- `client.accounts.fetchStatuses()` — 계정 상태(포스트)
- `client.timelines.*` — 타임라인
- `client.favourites.fetch()` — 즐겨찾기
- `client.bookmarks.fetch()` — 북마크
- `client.blocks.fetch()` — 차단한 계정
- `client.mutes.fetch()` — 뮤트한 계정
