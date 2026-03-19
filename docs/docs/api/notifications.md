---
sidebar_position: 3
---

# Notifications

The `client.notifications` API manages notification retrieval, dismissal, and policies.

## Fetching notifications

### List

```dart
final page = await client.notifications.fetch(limit: 20);

for (final n in page.items) {
  print('${n.type}: ${n.account?.displayName}');
}
```

### Filtering by type

```dart
// Only mentions and favourites
final page = await client.notifications.fetch(
  types: ['mention', 'favourite'],
);

// Everything except follows
final page = await client.notifications.fetch(
  excludeTypes: ['follow'],
);
```

### Single notification

```dart
final notification = await client.notifications.fetchById('12345');
```

### Unread count (Mastodon 4.3+)

```dart
final count = await client.notifications.fetchUnreadCount();
print(count.count);
```

## Dismissing notifications

### Dismiss one

```dart
await client.notifications.dismiss('12345');
```

### Clear all

```dart
await client.notifications.clear();
```

## Notification policy (Mastodon 4.3+)

### Fetch current policy

```dart
final policy = await client.notifications.fetchPolicy();
print(policy.forNotFollowing); // accept, filter, drop
```

### Update policy

```dart
await client.notifications.updatePolicy(policy);
```

## Notification requests (Mastodon 4.3+)

Filtered notifications from accounts that match the policy are collected as requests.

### List requests

```dart
final page = await client.notifications.fetchRequests(limit: 20);
```

### Accept / dismiss

```dart
// Single
await client.notifications.acceptRequest('12345');
await client.notifications.dismissRequest('12345');

// Batch
await client.notifications.acceptRequests(['1', '2', '3']);
await client.notifications.dismissRequests(['4', '5']);
```

### Check merge status

```dart
final merged = await client.notifications.checkRequestsMerged();
if (merged) {
  // Accepted requests have been merged into the notification list
}
```

## Grouped notifications (v2)

For the grouped notifications API, use `client.groupedNotifications`:

```dart
final result = await client.groupedNotifications.fetch(limit: 20);
for (final group in result.notificationGroups) {
  print('${group.type}: ${group.notificationsCount} notifications');
}
```
