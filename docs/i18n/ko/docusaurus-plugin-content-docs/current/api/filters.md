---
sidebar_position: 6
---

# 필터

`client.filters` API는 서버 측 콘텐츠 필터를 관리합니다 (Mastodon 4.0 이상). 필터는 지정한 키워드나 개별 포스트 ID와 일치하는 포스트를 숨기거나 경고를 표시합니다.

## 필터 조회

### 전체 필터 목록

```dart
final filters = await client.filters.fetch();

for (final filter in filters) {
  print('${filter.title}: ${filter.filterAction}');
}
```

### 단일 필터

```dart
final filter = await client.filters.fetchById('1');
print(filter.title);
```

## 필터 생성

`title`과 `context`는 필수입니다. `context`는 필터가 적용될 하나 이상의 위치를 나타내는 목록입니다:

| 값 | 필터가 적용되는 위치 |
|---|---|
| `home` | 홈 및 리스트 타임라인 |
| `notifications` | 알림 타임라인 |
| `public` | 공개 타임라인 |
| `thread` | 대화 스레드 내 |
| `account` | 프로필 보기 시 |

```dart
final filter = await client.filters.create(
  title: 'Hide spoilers',
  context: ['home', 'public'],
  filterAction: 'warn',
  expiresIn: 86400, // 1일; 만료 없음은 생략
);
```

`filterAction`은 `'warn'`(경고 표시), `'hide'`(포스트 완전 제거), `'blur'`를 허용합니다. 생략하면 서버 기본값이 적용됩니다.

### 키워드와 함께 생성

`keywordsAttributes`를 전달하면 생성 시 키워드를 함께 추가할 수 있습니다.

```dart
final filter = await client.filters.create(
  title: 'Election noise',
  context: ['home', 'notifications', 'public'],
  filterAction: 'warn',
  keywordsAttributes: [
    MastodonFilterKeywordParam(keyword: 'election', wholeWord: true),
    MastodonFilterKeywordParam(keyword: 'vote'),
  ],
);
```

## 필터 업데이트

모든 파라미터는 선택 사항이며 제공한 필드만 업데이트됩니다.

```dart
final updated = await client.filters.update(
  '1',
  title: 'Updated title',
  filterAction: 'hide',
);
```

## 필터 삭제

```dart
await client.filters.delete('1');
```

## 필터 키워드

키워드는 필터가 매칭하는 문구입니다. 각 키워드는 하나의 필터에 속합니다.

### 키워드 목록 조회

```dart
final keywords = await client.filters.fetchKeywords('1');

for (final kw in keywords) {
  print('${kw.keyword} (whole word: ${kw.wholeWord})');
}
```

### 키워드 추가

```dart
final keyword = await client.filters.createKeyword(
  '1', // 필터 ID
  keyword: 'spoiler',
  wholeWord: true,
);
```

### 단일 키워드 조회

```dart
final keyword = await client.filters.fetchKeywordById('42');
```

### 키워드 업데이트

```dart
final updated = await client.filters.updateKeyword(
  '42',
  keyword: 'spoilers',
  wholeWord: false,
);
```

### 키워드 삭제

```dart
await client.filters.deleteKeyword('42');
```

### 필터 업데이트 시 키워드 일괄 업데이트

`update()`에 `keywordsAttributes`를 전달하면 한 번의 요청으로 여러 키워드를 추가, 수정, 삭제할 수 있습니다. 삭제하려면 항목에 `destroy: true`를 설정하세요.

```dart
await client.filters.update(
  '1',
  keywordsAttributes: [
    MastodonFilterKeywordUpdateParam(keyword: 'newword'),           // 추가
    MastodonFilterKeywordUpdateParam(id: '10', keyword: 'changed'), // 수정
    MastodonFilterKeywordUpdateParam(id: '11', keyword: '', destroy: true), // 삭제
  ],
);
```

## 필터 포스트

키워드 매칭 외에도 특정 포스트를 필터에 추가하여 항상 숨길 수 있습니다.

### 필터된 포스트 목록 조회

```dart
final statuses = await client.filters.fetchStatuses('1');
```

### 필터에 포스트 추가

```dart
final filterStatus = await client.filters.createStatus(
  '1', // 필터 ID
  statusId: '109876543210',
);
```

### 단일 필터 포스트 항목 조회

```dart
final filterStatus = await client.filters.fetchStatusById('99');
```

### 필터에서 포스트 제거

```dart
await client.filters.deleteStatus('99');
```

## 비권장: v1 필터

v1 필터 API는 Mastodon 4.0.0에서 비권장 처리되었습니다. 이전 인스턴스와의 호환성을 위해서만 제공됩니다.

| v1 메서드 | v2 동등 메서드 |
|---|---|
| `fetchV1()` | `fetch()` |
| `fetchByIdV1(id)` | `fetchById(id)` |
| `createV1(phrase:, context:)` | `create(title:, context:)` |
| `updateV1(id, phrase:, context:)` | `update(id)` |
| `deleteV1(id)` | `delete(id)` |

v2와의 주요 차이점:

- v1은 키워드 목록 대신 단일 `phrase` 문자열을 사용합니다.
- `irreversible: true`를 설정하면 클라이언트 측 경고 없이 홈 및 알림에서 일치하는 포스트를 영구적으로 제거합니다.
- `deleteV1()`은 상위 필터가 아닌 `FilterKeyword` 레코드만 삭제합니다.
- v1 필터는 클라이언트 측에서만 동작하며 서버에서는 강제 적용되지 않습니다.
