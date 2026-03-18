---
sidebar_position: 3
---

# 通知

`client.notifications` API は通知の取得・削除・ポリシー管理を提供します。

## 通知の取得

### 一覧

```dart
final page = await client.notifications.fetch(limit: 20);

for (final n in page.items) {
  print('${n.type}: ${n.account?.displayName}');
}
```

### タイプでフィルタリング

```dart
// メンションとお気に入りのみ
final page = await client.notifications.fetch(
  types: ['mention', 'favourite'],
);

// フォロー以外すべて
final page = await client.notifications.fetch(
  excludeTypes: ['follow'],
);
```

### 単一の通知

```dart
final notification = await client.notifications.fetchById('12345');
```

### 未読数（Mastodon 4.3+）

```dart
final count = await client.notifications.fetchUnreadCount();
print(count.count);
```

## 通知の削除

### 個別削除

```dart
await client.notifications.dismiss('12345');
```

### 全件クリア

```dart
await client.notifications.clear();
```

## 通知ポリシー（Mastodon 4.3+）

### 現在のポリシーを取得

```dart
final policy = await client.notifications.fetchPolicy();
print(policy.forNotFollowing); // accept, filter, drop
```

### ポリシーの更新

```dart
await client.notifications.updatePolicy(policy);
```

## 通知リクエスト（Mastodon 4.3+）

ポリシーに一致するアカウントからのフィルタリングされた通知はリクエストとして収集されます。

### リクエスト一覧

```dart
final page = await client.notifications.fetchRequests(limit: 20);
```

### 承認 / 却下

```dart
// 個別
await client.notifications.acceptRequest('12345');
await client.notifications.dismissRequest('12345');

// 一括
await client.notifications.acceptRequests(['1', '2', '3']);
await client.notifications.dismissRequests(['4', '5']);
```

### マージ状態の確認

```dart
final merged = await client.notifications.checkRequestsMerged();
if (merged) {
  // 承認されたリクエストが通知一覧にマージされた
}
```

## グループ化された通知（v2）

グループ化された通知 API には `client.groupedNotifications` を使用します。

```dart
final result = await client.groupedNotifications.fetch(limit: 20);
for (final group in result.notificationGroups) {
  print('${group.type}: ${group.notificationsCount} 件の通知');
}
```
