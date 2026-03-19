---
sidebar_position: 3
---

# 알림

`client.notifications` API는 알림 조회, 삭제, 정책 관리 기능을 제공합니다.

## 알림 조회

### 목록 조회

```dart
final page = await client.notifications.fetch(limit: 20);

for (final n in page.items) {
  print('${n.type}: ${n.account?.displayName}');
}
```

### 타입별 필터링

```dart
// 멘션과 좋아요만
final page = await client.notifications.fetch(
  types: ['mention', 'favourite'],
);

// 팔로우를 제외한 모든 알림
final page = await client.notifications.fetch(
  excludeTypes: ['follow'],
);
```

### 단일 알림 조회

```dart
final notification = await client.notifications.fetchById('12345');
```

### 읽지 않은 알림 수 (Mastodon 4.3+)

```dart
final count = await client.notifications.fetchUnreadCount();
print(count.count);
```

## 알림 삭제

### 단일 삭제

```dart
await client.notifications.dismiss('12345');
```

### 전체 삭제

```dart
await client.notifications.clear();
```

## 알림 정책 (Mastodon 4.3+)

### 현재 정책 조회

```dart
final policy = await client.notifications.fetchPolicy();
print(policy.forNotFollowing); // accept, filter, drop
```

### 정책 업데이트

```dart
await client.notifications.updatePolicy(policy);
```

## 알림 요청 (Mastodon 4.3+)

정책 조건에 맞는 계정의 필터링된 알림은 요청으로 수집됩니다.

### 요청 목록 조회

```dart
final page = await client.notifications.fetchRequests(limit: 20);
```

### 수락 / 거절

```dart
// 단건
await client.notifications.acceptRequest('12345');
await client.notifications.dismissRequest('12345');

// 일괄
await client.notifications.acceptRequests(['1', '2', '3']);
await client.notifications.dismissRequests(['4', '5']);
```

### 병합 상태 확인

```dart
final merged = await client.notifications.checkRequestsMerged();
if (merged) {
  // 수락된 요청이 알림 목록에 병합됨
}
```

## 그룹화된 알림 (v2)

그룹화된 알림 API를 사용하려면 `client.groupedNotifications`를 사용합니다:

```dart
final result = await client.groupedNotifications.fetch(limit: 20);
for (final group in result.notificationGroups) {
  print('${group.type}: ${group.notificationsCount} notifications');
}
```
