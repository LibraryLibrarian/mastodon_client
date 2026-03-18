---
sidebar_position: 14
---

# 관리자(Admin)

관리자 API는 서버 관리 기능을 제공합니다. 모든 엔드포인트는 높은 수준의 OAuth 스코프(일반적으로 `admin:read:*` 또는 `admin:write:*`)가 필요합니다. 서버 측 권한을 보유한 계정에서만 이 API를 사용하세요.

## 계정

`client.adminAccounts`는 관리자용 전체 계정 관리 기능을 제공합니다.

### 계정 목록 조회

두 가지 버전의 목록 조회 엔드포인트를 사용할 수 있습니다.

**v1** — 불리언 필터 플래그:

```dart
final page = await client.adminAccounts.fetch(
  pending: true,   // 승인 대기 중인 계정만
  limit: 100,
);
for (final account in page.items) {
  print('${account.account?.acct} — ${account.email}');
}
```

사용 가능한 필터: `local`, `remote`, `active`, `pending`, `disabled`, `silenced`, `suspended`, `sensitized`, `staff`. 검색 파라미터: `username`, `displayName`, `email`, `ip`, `byDomain`. 페이지네이션: `maxId`, `sinceId`, `minId`. 기본 limit 100, 최대 200.

**v2** — 구조화된 필터 파라미터 (새 코드에서 권장):

```dart
final page = await client.adminAccounts.fetchV2(
  origin: 'local',
  status: 'pending',
  limit: 50,
);
```

`origin`은 `local` 또는 `remote`입니다. `status`는 `active`, `pending`, `disabled`, `silenced`, `suspended` 중 하나입니다. `permissions`에 `staff`를 전달하면 스태프 계정으로 제한합니다. `roleIds`는 할당된 역할 ID로 필터링하고, `invitedBy`는 초대자 계정 ID로 필터링합니다.

### 단일 계정 조회

```dart
final account = await client.adminAccounts.fetchById('12345');
print(account.ip);
print(account.confirmed);
```

### 대기 중인 계정 승인 및 거절

```dart
await client.adminAccounts.approve('12345');
await client.adminAccounts.reject('12345');
```

### 제재 조치 실행

```dart
await client.adminAccounts.performAction(
  '12345',
  MastodonAdminAccountActionRequest(
    type: 'suspend',
    reportId: '999',
    text: 'Violated community guidelines.',
    sendEmailNotification: true,
  ),
);
```

관련된 미해결 신고는 자동으로 해결됩니다. "사용자 관리" 및 "신고 관리" 권한이 필요합니다.

### 기타 제재 메서드

```dart
await client.adminAccounts.enable('12345');       // 비활성화된 계정 재활성화
await client.adminAccounts.unsilence('12345');    // 침묵 해제
await client.adminAccounts.unsuspend('12345');    // 정지 해제
await client.adminAccounts.unsensitive('12345'); // 민감 플래그 제거
```

### 계정 데이터 삭제

```dart
await client.adminAccounts.delete('12345');
```

정지된 계정의 데이터를 영구적으로 삭제합니다. "사용자 데이터 삭제" 권한이 필요합니다.

## 신고

`client.adminReports`는 사용자가 제출한 신고를 관리합니다.

### 신고 목록 조회

```dart
final page = await client.adminReports.fetch(
  resolved: false,  // 미해결 신고만
  limit: 100,
);
```

`accountId`(신고자) 또는 `targetAccountId`(신고 대상)로 필터링할 수 있습니다. `resolved: true`로 해결된 신고만 표시합니다. 페이지네이션은 `maxId`, `sinceId`, `minId`를 사용합니다.

### 신고 조회 및 업데이트

```dart
final report = await client.adminReports.fetchById('42');

final updated = await client.adminReports.update(
  '42',
  MastodonAdminReportUpdateRequest(assignedAccountId: 'moderator-id'),
);
```

### 담당자 지정 및 해결

```dart
await client.adminReports.assignToSelf('42');
await client.adminReports.unassign('42');
await client.adminReports.resolve('42');
await client.adminReports.reopen('42'); // 해결된 신고 재열기
```

## 도메인 관리

### 도메인 허용 목록

허용 목록 모드로 운영되는 서버에서 `client.adminDomainAllows`는 연합을 허용할 원격 도메인을 제어합니다.

```dart
// 허용된 도메인 목록 조회
final page = await client.adminDomainAllows.fetch();

// 도메인 허용
final entry = await client.adminDomainAllows.create(domain: 'example.social');

// 허용된 도메인 제거
await client.adminDomainAllows.delete(entry.id);
```

### 도메인 차단 목록

`client.adminDomainBlocks`는 원격 도메인에 대한 연합 차단을 관리합니다.

```dart
// 차단된 도메인 목록 조회
final page = await client.adminDomainBlocks.fetch();

// 도메인 차단
final block = await client.adminDomainBlocks.create(
  MastodonAdminDomainBlockRequest(
    domain: 'spam.example',
    severity: 'suspend',
    rejectMedia: true,
    rejectReports: true,
    privateComment: 'Known spam instance',
    publicComment: 'Suspended for spam.',
  ),
);

// 차단 업데이트
await client.adminDomainBlocks.update(block.id, updatedRequest);

// 차단 삭제
await client.adminDomainBlocks.delete(block.id);
```

## IP 차단

`client.adminIpBlocks`는 IP 주소 범위 차단을 관리합니다.

```dart
// IP 차단 목록 조회
final page = await client.adminIpBlocks.fetch();

// IP 차단 생성
final block = await client.adminIpBlocks.create(
  MastodonAdminIpBlockCreateRequest(
    ip: '192.0.2.0/24',
    severity: 'no_access',
    comment: 'Abusive subnet',
  ),
);

// 업데이트
await client.adminIpBlocks.update(
  block.id,
  MastodonAdminIpBlockUpdateRequest(severity: 'sign_up_block'),
);

// 삭제
await client.adminIpBlocks.delete(block.id);
```

## 이메일 차단

### 정규화된 이메일 차단

`client.adminCanonicalEmailBlocks`는 정규화된 이메일 주소를 차단합니다. 차단된 이메일의 변형 주소로 재가입하는 것을 방지합니다.

```dart
// 차단 목록 조회
final page = await client.adminCanonicalEmailBlocks.fetch();

// 이메일이 기존 차단과 일치하는지 테스트
final matches = await client.adminCanonicalEmailBlocks.test(
  email: 'test@example.com',
);

// 이메일 주소로 차단 (정규화 해시는 서버에서 계산)
final block = await client.adminCanonicalEmailBlocks.create(
  email: 'spammer@example.com',
);

// 또는 미리 계산된 해시로 차단
await client.adminCanonicalEmailBlocks.create(
  canonicalEmailHash: 'sha256hashvalue',
);

// 삭제
await client.adminCanonicalEmailBlocks.delete(block.id);
```

### 이메일 도메인 차단

`client.adminEmailDomainBlocks`는 특정 이메일 도메인으로부터의 가입을 차단합니다.

```dart
// 차단된 이메일 도메인 목록 조회
final page = await client.adminEmailDomainBlocks.fetch();

// 도메인 차단
final block = await client.adminEmailDomainBlocks.create(
  domain: 'disposable-mail.example',
);

// 삭제
await client.adminEmailDomainBlocks.delete(block.id);
```

## 관리자 태그

`client.adminTags`는 해시태그에 대한 관리자 제어 기능을 제공합니다.

### 태그 목록 조회 및 단일 조회

```dart
final page = await client.adminTags.fetch(limit: 50);
final tag = await client.adminTags.fetchById('tag-id');
```

### 태그 업데이트

```dart
final updated = await client.adminTags.update(
  'tag-id',
  displayName: 'Dart',
  listable: true,
  trendable: true,
  usable: true,
);
```

모든 필드는 선택 사항이며 제공한 값만 변경됩니다. `listable`은 태그가 공개 목록에 표시되는지, `trendable`은 트렌드 엔드포인트에 표시 가능한지, `usable`은 포스트에서 사용 가능한지를 제어합니다.

## 관리자 트렌드

`client.adminTrends`는 검토되지 않은 트렌딩 콘텐츠에 접근하고 공개적으로 표시되기 전 승인 또는 거절할 수 있습니다.

### 트렌딩 링크

```dart
final links = await client.adminTrends.fetchLinks();
await client.adminTrends.approveLink(id: links.first.id);
await client.adminTrends.rejectLink(id: links.first.id);
```

### 링크 발행자

```dart
final publishers = await client.adminTrends.fetchPublishers();
await client.adminTrends.approvePublisher(id: publishers.first.id);
await client.adminTrends.rejectPublisher(id: publishers.first.id);
```

### 트렌딩 포스트

```dart
final statuses = await client.adminTrends.fetchStatuses();
await client.adminTrends.approveStatus(id: statuses.first.id);
await client.adminTrends.rejectStatus(id: statuses.first.id);
```

### 트렌딩 태그

```dart
final tags = await client.adminTrends.fetchTags();
await client.adminTrends.approveTag(id: tags.first.id);
await client.adminTrends.rejectTag(id: tags.first.id);
```

읽기 엔드포인트는 `admin:read` 스코프가, 쓰기 엔드포인트는 `admin:write` 스코프가 필요합니다.

## 측정, 차원 및 유지율

이 분석 엔드포인트들은 모두 조회할 지표와 날짜 범위를 지정하는 요청 본문과 함께 `POST`를 사용합니다.

### 측정값 (정량 데이터)

```dart
final measures = await client.adminMeasures.fetch(
  MastodonAdminMeasureRequest(
    keys: ['active_users', 'new_users'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
for (final m in measures) {
  print('${m.key}: ${m.total}');
}
```

활성 사용자, 신규 사용자 가입, 상호작용 수 등 시계열 데이터를 반환합니다.

### 차원 (질적 데이터)

```dart
final dimensions = await client.adminDimensions.fetch(
  MastodonAdminDimensionRequest(
    keys: ['languages', 'sources'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
```

언어 분포나 클라이언트 소프트웨어 버전 등 범주별 분류를 반환합니다.

### 유지율 (코호트 데이터)

```dart
final cohorts = await client.adminRetention.fetch(
  MastodonAdminRetentionRequest(
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 3, 31),
    frequency: 'month',
  ),
);
```

가입 기간과 이후 활동별로 그룹화된 사용자 유지율 코호트 데이터를 반환합니다. 세 가지 분석 엔드포인트 모두 `admin:read` OAuth 스코프가 필요합니다.
