---
sidebar_position: 2
---

# 포스트(Statuses)

`client.statuses` API는 포스트 생성, 조회, 상호작용 작업을 제공합니다.

## 포스트 조회

### 단일 포스트

```dart
final status = await client.statuses.fetch('12345');
print(status.content);
```

### 여러 포스트

```dart
final statuses = await client.statuses.fetchMultiple(['1', '2', '3']);
```

존재하지 않거나 접근할 수 없는 ID는 결과에서 자동으로 제외됩니다.

### 스레드 컨텍스트

```dart
final context = await client.statuses.fetchContext('12345');
print('${context.ancestors.length} ancestors');
print('${context.descendants.length} descendants');
```

### 편집 기록

```dart
final history = await client.statuses.fetchHistory('12345');
for (final edit in history) {
  print(edit.content);
}
```

### 소스 (편집용)

```dart
final source = await client.statuses.fetchSource('12345');
print(source.text);        // 일반 텍스트 내용
print(source.spoilerText); // CW 텍스트
```

## 포스트 작성

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Hello, Mastodon!',
    visibility: MastodonVisibility.public,
  ),
);

// result는 MastodonStatusCreated 또는 MastodonStatusScheduled
if (result case MastodonStatusCreated(:final status)) {
  print('Posted: ${status.url}');
}
```

### 미디어 첨부

```dart
final attachment = await client.media.upload(imageBytes, 'photo.jpg',
  description: 'A beautiful sunset',
);

final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Check this out!',
    mediaIds: [attachment.id],
  ),
);
```

### 설문 첨부

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'What do you prefer?',
    poll: MastodonPollCreateRequest(
      options: ['Option A', 'Option B', 'Option C'],
      expiresIn: 86400, // 24시간
      multiple: false,
    ),
  ),
);
```

### 예약 포스트

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'This will be posted later',
    scheduledAt: '2025-12-31T00:00:00.000Z',
  ),
);

if (result case MastodonStatusScheduled(:final scheduledStatus)) {
  print('Scheduled for: ${scheduledStatus.scheduledAt}');
}
```

### 멱등성

```dart
final result = await client.statuses.create(
  request,
  idempotencyKey: 'unique-key-123',
);
```

동일한 키로 반복 요청을 보내면 동일한 결과를 반환합니다.

## 포스트 편집

```dart
final updated = await client.statuses.edit(
  '12345',
  MastodonStatusEditRequest(
    status: 'Updated content',
  ),
);
```

## 포스트 삭제

```dart
final deleted = await client.statuses.delete('12345');
// 재작성을 위한 소스 정보가 포함된 스냅샷 반환
print(deleted.text);
```

## 상호작용

### 부스트 / 부스트 취소

```dart
final boosted = await client.statuses.boost('12345');
// 래퍼 포스트를 반환; 원본은 boosted.reblog에 있음

final unboosted = await client.statuses.unboost('12345');
// 원본 포스트를 직접 반환
```

### 좋아요 / 좋아요 취소

```dart
await client.statuses.favourite('12345');
await client.statuses.unfavourite('12345');
```

### 북마크 / 북마크 취소

```dart
await client.statuses.bookmark('12345');
await client.statuses.unbookmark('12345');
```

### 대화 뮤트 / 뮤트 해제

```dart
await client.statuses.mute('12345');   // 스레드 알림 중단
await client.statuses.unmute('12345');
```

### 고정 / 고정 해제

```dart
await client.statuses.pin('12345');
await client.statuses.unpin('12345');
```

## 부스트한 / 좋아요한 사람

```dart
final boosters = await client.statuses.fetchRebloggedBy('12345', limit: 40);
final favouriters = await client.statuses.fetchFavouritedBy('12345', limit: 40);
```

두 메서드 모두 페이지네이션을 지원하는 `MastodonPage<MastodonAccount>`를 반환합니다.

## 번역

```dart
final translation = await client.statuses.translate('12345', lang: 'en');
print(translation.content);
```

공개 또는 비열거(unlisted) 포스트만 번역할 수 있습니다.
