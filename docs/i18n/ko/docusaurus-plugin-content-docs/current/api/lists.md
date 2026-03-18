---
sidebar_position: 7
---

# 리스트

`client.lists` API를 사용하면 리스트를 생성하고 관리하며, 계정을 추가하거나 제거하고, 리스트 타임라인을 읽을 수 있습니다.

## 리스트 조회

### 전체 리스트

```dart
final lists = await client.lists.fetch();
for (final list in lists) {
  print('${list.id}: ${list.title}');
}
```

인증된 사용자가 소유한 모든 리스트를 담은 `List<MastodonList>`를 반환합니다.

### 단일 리스트

```dart
final list = await client.lists.fetchById('42');
print(list.title);
print(list.repliesPolicy); // "followed" | "list" | "none"
print(list.exclusive);     // 리스트 멤버가 홈 타임라인에서 제외되면 true
```

## 리스트 생성

```dart
final list = await client.lists.create(
  title: 'Developer friends',
  repliesPolicy: 'list',   // 리스트 멤버 간의 답글 표시
  exclusive: false,
);
print(list.id);
```

`repliesPolicy` 값:
- `followed` — 팔로우하는 사용자에게 보낸 답글 표시
- `list` — 다른 리스트 멤버에게 보낸 답글 표시
- `none` — 모든 답글 숨김

`exclusive`가 `true`이면 리스트 멤버의 포스트가 홈 타임라인에서 제외됩니다.

## 리스트 업데이트

```dart
final updated = await client.lists.update(
  '42',
  title: 'Close friends',
  repliesPolicy: 'followed',
  exclusive: true,
);
```

## 리스트 삭제

```dart
await client.lists.delete('42');
```

## 계정 관리

### 리스트의 계정 목록 조회

```dart
final page = await client.lists.fetchAccounts(
  '42',
  limit: 40,
);

for (final account in page.items) {
  print(account.acct);
}
```

`MastodonPage<MastodonAccount>`를 반환합니다. 페이지네이션에는 `nextMaxId`와 `prevMinId`를 사용합니다:

```dart
MastodonPage<MastodonAccount>? page = await client.lists.fetchAccounts('42');

while (page != null && page.nextMaxId != null) {
  page = await client.lists.fetchAccounts(
    '42',
    maxId: page.nextMaxId,
  );
  for (final account in page.items) {
    print(account.acct);
  }
}
```

페이지네이션 파라미터:

| 파라미터 | 설명 |
|----------|------|
| `limit`   | 최대 결과 수 (기본값: 40, 최대: 80; `0`이면 전체) |
| `maxId`   | 이 ID보다 오래된 결과 반환 |
| `sinceId` | 이 ID보다 최근 결과 반환 |
| `minId`   | 이 ID 바로 다음부터 결과 반환 (순차 페이지네이션) |

### 계정 추가

추가할 계정은 인증된 사용자가 팔로우하고 있어야 합니다.

```dart
await client.lists.addAccounts(
  '42',
  accountIds: ['100', '101', '102'],
);
```

### 계정 제거

```dart
await client.lists.removeAccounts(
  '42',
  accountIds: ['101'],
);
```

## MastodonList 모델

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | `String` | 내부 리스트 ID |
| `title` | `String` | 리스트 제목 |
| `repliesPolicy` | `String` | 답글 표시 정책 (`followed` / `list` / `none`) |
| `exclusive` | `bool` | 리스트 멤버가 홈 타임라인에서 제외되는지 여부 |
