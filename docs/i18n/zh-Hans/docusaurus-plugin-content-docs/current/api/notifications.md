---
sidebar_position: 3
---

# 通知

`client.notifications` API 管理通知的获取、关闭和策略配置。

## 获取通知

### 列表

```dart
final page = await client.notifications.fetch(limit: 20);

for (final n in page.items) {
  print('${n.type}: ${n.account?.displayName}');
}
```

### 按类型过滤

```dart
// 仅提及和收藏
final page = await client.notifications.fetch(
  types: ['mention', 'favourite'],
);

// 除关注外的所有通知
final page = await client.notifications.fetch(
  excludeTypes: ['follow'],
);
```

### 单条通知

```dart
final notification = await client.notifications.fetchById('12345');
```

### 未读数量（Mastodon 4.3+）

```dart
final count = await client.notifications.fetchUnreadCount();
print(count.count);
```

## 关闭通知

### 关闭单条

```dart
await client.notifications.dismiss('12345');
```

### 清空所有

```dart
await client.notifications.clear();
```

## 通知策略（Mastodon 4.3+）

### 获取当前策略

```dart
final policy = await client.notifications.fetchPolicy();
print(policy.forNotFollowing); // accept, filter, drop
```

### 更新策略

```dart
await client.notifications.updatePolicy(policy);
```

## 通知请求（Mastodon 4.3+）

符合策略的已过滤通知会以请求形式收集。

### 列出请求

```dart
final page = await client.notifications.fetchRequests(limit: 20);
```

### 接受 / 关闭

```dart
// 单条
await client.notifications.acceptRequest('12345');
await client.notifications.dismissRequest('12345');

// 批量
await client.notifications.acceptRequests(['1', '2', '3']);
await client.notifications.dismissRequests(['4', '5']);
```

### 检查合并状态

```dart
final merged = await client.notifications.checkRequestsMerged();
if (merged) {
  // 已接受的请求已合并到通知列表中
}
```

## 分组通知（v2）

如需使用分组通知 API，请使用 `client.groupedNotifications`：

```dart
final result = await client.groupedNotifications.fetch(limit: 20);
for (final group in result.notificationGroups) {
  print('${group.type}: ${group.notificationsCount} notifications');
}
```
