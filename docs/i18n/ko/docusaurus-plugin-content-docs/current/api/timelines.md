---
sidebar_position: 4
---

# 타임라인

`client.timelines` API는 다양한 소스에서 포스트 스트림을 가져옵니다. 모든 메서드는 `MastodonPage<MastodonStatus>`를 반환하며 커서 기반 페이지네이션을 지원합니다.

## 홈 타임라인

홈 타임라인에는 팔로우하는 계정의 포스트가 표시됩니다.

```dart
final page = await client.timelines.fetchHome(limit: 20);

for (final status in page.items) {
  print('${status.account.acct}: ${status.content}');
}
```

## 공개 타임라인

### 로컬 타임라인

같은 인스턴스 계정의 포스트입니다.

```dart
final page = await client.timelines.fetchLocal(limit: 20);
```

`onlyMedia: true`를 전달하면 미디어 첨부가 있는 포스트로 제한합니다.

```dart
final page = await client.timelines.fetchLocal(onlyMedia: true);
```

### 연합 타임라인

인스턴스가 네트워크 전반에서 수신한 모든 공개 포스트입니다.

```dart
final page = await client.timelines.fetchFederated(limit: 20);
```

선택적 파라미터:

- `onlyMedia` — 미디어 첨부가 있는 포스트만 포함
- `remoteOnly` — 로컬 계정의 포스트 제외

```dart
final page = await client.timelines.fetchFederated(
  remoteOnly: true,
  onlyMedia: true,
);
```

## 해시태그 타임라인

지정한 해시태그가 포함된 포스트입니다. `#` 접두사 없이 태그를 전달합니다.

```dart
final page = await client.timelines.fetchHashtag('mastodon', limit: 20);
```

추가 태그 필터로 결과를 넓히거나 좁힐 수 있습니다:

- `any` — 이 추가 태그 중 하나라도 포함된 포스트도 포함
- `all` — 이 추가 태그를 모두 포함하는 포스트만
- `none` — 이 태그 중 하나라도 포함된 포스트 제외

```dart
final page = await client.timelines.fetchHashtag(
  'dart',
  any: ['flutter'],
  none: ['spam'],
);
```

범위는 `localOnly` 또는 `remoteOnly`로 제한할 수 있습니다.

## 리스트 타임라인

특정 리스트에 속한 계정의 포스트입니다. 리스트 ID가 필요합니다.

```dart
final page = await client.timelines.fetchList('42', limit: 20);
```

## 링크 타임라인

특정 URL과 관련된 포스트입니다 (서버 지원 필요).

```dart
final page = await client.timelines.fetchLink(
  'https://example.com/article',
  limit: 20,
);
```

## 페이지네이션

모든 타임라인 메서드는 더 오래된 페이지와 더 최근 페이지로 이동할 수 있는 커서를 담은 `MastodonPage<MastodonStatus>`를 반환합니다.

### 다음 페이지 가져오기 (더 오래된 포스트)

```dart
var page = await client.timelines.fetchHome(limit: 20);

while (page.nextMaxId != null) {
  page = await client.timelines.fetchHome(
    limit: 20,
    maxId: page.nextMaxId,
  );
  for (final status in page.items) {
    print(status.content);
  }
}
```

### 새 포스트 폴링

`sinceId`를 사용하면 마지막으로 알려진 ID보다 최근 포스트를 확인합니다.

```dart
String? latestId = page.items.firstOrNull?.id;

final newPage = await client.timelines.fetchHome(
  sinceId: latestId,
);
```

### `minId`를 사용한 순차 페이지네이션

`minId`는 지정한 ID 바로 다음부터 누락 없이 결과를 반환합니다. 순차적 탐색에 유용합니다.

```dart
final nextPage = await client.timelines.fetchHome(
  minId: page.prevMinId,
);
```

커서 파라미터에 대한 전체 설명은 [페이지네이션](../pagination.md) 가이드를 참고하세요.

## 비권장: 다이렉트 메시지 타임라인

`fetchDirect()`는 Mastodon 3.0.0에서 제거되었습니다. 대신 대화(Conversations) API를 사용하세요.
