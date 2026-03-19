---
sidebar_position: 11
---

# 모더레이션

이 페이지에서는 차단된 계정, 뮤트된 계정, 도메인 차단, 사용자 신고 관리 API를 다룹니다.

모든 목록 조회 메서드는 `MastodonPage<T>`를 반환합니다. 여기에는 결과 아이템과 함께 `Link` 응답 헤더에서 파싱된 `nextMaxId`, `prevMinId` 커서가 포함됩니다. 자세한 내용은 [페이지네이션](../pagination.md) 가이드를 참고하세요.

---

## 차단된 계정

### 차단 목록 조회

```dart
final page = await client.blocks.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// 다음 페이지
if (page.nextMaxId != null) {
  final next = await client.blocks.fetch(maxId: page.nextMaxId);
}
```

파라미터:

| 파라미터 | 기본값 | 최대값 | 설명 |
|----------|--------|--------|------|
| `limit`   | 40     | 80     | 결과 수 |
| `maxId`   | —      | —      | 이 ID보다 오래된 결과 반환 |
| `sinceId` | —      | —      | 이 ID보다 최근 결과 반환 |
| `minId`   | —      | —      | 이 ID 바로 다음부터 가장 오래된 결과 반환 (순차 페이지네이션) |

계정을 차단하거나 차단 해제하려면 `client.accounts.block()` 및 `client.accounts.unblock()`을 사용하세요.

---

## 뮤트된 계정

### 뮤트 목록 조회

```dart
final page = await client.mutes.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// 다음 페이지
if (page.nextMaxId != null) {
  final next = await client.mutes.fetch(maxId: page.nextMaxId);
}
```

파라미터:

| 파라미터 | 기본값 | 최대값 | 설명 |
|----------|--------|--------|------|
| `limit`   | 40     | 80     | 결과 수 |
| `maxId`   | —      | —      | 이 ID보다 오래된 결과 반환 |
| `sinceId` | —      | —      | 이 ID보다 최근 결과 반환 |

계정을 뮤트하거나 뮤트 해제하려면 `client.accounts.mute()` 및 `client.accounts.unmute()`를 사용하세요.

---

## 도메인 차단

사용자 수준의 도메인 차단은 특정 도메인의 모든 포스트와 알림을 숨깁니다. 이는 인스턴스 수준의 도메인 차단(`client.instance.fetchDomainBlocks()`)과 다릅니다.

### 차단된 도메인 목록 조회

```dart
final page = await client.domainBlocks.fetch(limit: 100);
for (final domain in page.items) {
  print(domain);
}
```

파라미터:

| 파라미터 | 기본값 | 최대값 | 설명 |
|----------|--------|--------|------|
| `limit`   | 100    | 200    | 결과 수 |
| `maxId`   | —      | —      | 이 ID보다 오래된 결과 반환 |
| `sinceId` | —      | —      | 이 ID보다 최근 결과 반환 |
| `minId`   | —      | —      | 이 ID 바로 다음부터 가장 오래된 결과 반환 (순차 페이지네이션) |

### 도메인 차단

```dart
await client.domainBlocks.block('spam.example.com');
```

도메인을 차단하면 해당 도메인 계정의 모든 공개 포스트와 알림이 숨겨지고, 해당 도메인의 기존 팔로워가 제거되며, 해당 도메인 계정에 새로 팔로우할 수 없게 됩니다.

### 도메인 차단 해제

```dart
await client.domainBlocks.unblock('spam.example.com');
```

---

## 신고

### 계정 신고

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    comment: 'This account is posting spam.',
    category: 'spam',
  ),
);
print(report.id);
```

### 특정 포스트 신고

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    statusIds: ['111', '222'],
    comment: 'These posts violate the rules.',
    category: 'violation',
    ruleIds: ['1', '3'],
  ),
);
```

### 원격 관리자에게 전달

`forward: true`를 설정하면 신고 대상 계정의 홈 서버 관리자에게 신고 사본이 전달됩니다.

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '67890',
    comment: 'Harassment from a remote account.',
    forward: true,
  ),
);
```

### 요청 필드

| 필드 | 필수 | 설명 |
|------|------|------|
| `accountId`  | 예 | 신고할 계정의 ID |
| `statusIds`  | 아니요 | 증거로 첨부할 포스트 ID |
| `comment`    | 아니요 | 신고 이유 (최대 1000자) |
| `forward`    | 아니요 | 원격 서버 관리자에게 전달 |
| `category`   | 아니요 | `spam`, `legal`, `violation`, `other` |
| `ruleIds`    | 아니요 | 위반한 규칙 ID (`violation` 카테고리에서 사용) |
