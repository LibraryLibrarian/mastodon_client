---
sidebar_position: 3
---

# Pagination

The Mastodon API uses cursor-based pagination. This library abstracts it with `MastodonPage<T>`.

## MastodonPage structure

```dart
class MastodonPage<T> {
  final List<T> items;      // Items in the current page
  final String? nextMaxId;  // Cursor for the next page (older)
  final String? prevMinId;  // Cursor for the previous page (newer)
}
```

## Basic usage

### Fetching the first page

```dart
final page = await client.notifications.fetch(limit: 20);

for (final notification in page.items) {
  print(notification.type);
}
```

### Fetching the next page (older)

Pass `nextMaxId` as the `maxId` parameter:

```dart
if (page.nextMaxId != null) {
  final nextPage = await client.notifications.fetch(
    limit: 20,
    maxId: page.nextMaxId,
  );
}
```

### Fetching the previous page (newer)

Pass `prevMinId` as the `minId` parameter:

```dart
if (page.prevMinId != null) {
  final prevPage = await client.notifications.fetch(
    limit: 20,
    minId: page.prevMinId,
  );
}
```

## Pagination parameters

| Parameter | Direction | Description |
|-----------|-----------|-------------|
| `maxId` | Older | Return results before this ID |
| `sinceId` | Newer | Return results after this ID (may have gaps) |
| `minId` | Newer | Return results immediately after this ID (no gaps) |
| `limit` | - | Maximum number of results (server default when omitted) |

### Difference between `sinceId` and `minId`

- `sinceId`: Returns the **most recent** `limit` results newer than the given ID (may skip items in between)
- `minId`: Returns `limit` results **starting immediately after** the given ID (gap-free forward pagination)

Use `sinceId` for real-time update checks. Use `minId` for sequential page traversal.

## Iterating through all pages

```dart
Future<List<MastodonNotification>> fetchAll() async {
  final all = <MastodonNotification>[];
  String? maxId;

  while (true) {
    final page = await client.notifications.fetch(
      limit: 40,
      maxId: maxId,
    );
    all.addAll(page.items);

    if (page.nextMaxId == null) break;
    maxId = page.nextMaxId;
  }

  return all;
}
```

:::caution
Fetching large amounts of data at once puts load on the server. Be mindful of rate limits.
:::

## APIs with pagination

Major APIs that return paginated results:

- `client.notifications.fetch()` — Notifications
- `client.accounts.fetchFollowers()` — Followers
- `client.accounts.fetchFollowing()` — Following
- `client.accounts.fetchStatuses()` — Account statuses
- `client.timelines.*` — Timelines
- `client.favourites.fetch()` — Favourites
- `client.bookmarks.fetch()` — Bookmarks
- `client.blocks.fetch()` — Blocked accounts
- `client.mutes.fetch()` — Muted accounts
