---
sidebar_position: 4
---

# Timelines

The `client.timelines` API fetches streams of statuses from different sources. All methods return `MastodonPage<MastodonStatus>` and support cursor-based pagination.

## Home timeline

The home timeline contains statuses from accounts you follow.

```dart
final page = await client.timelines.fetchHome(limit: 20);

for (final status in page.items) {
  print('${status.account.acct}: ${status.content}');
}
```

## Public timelines

### Local timeline

Statuses from accounts on the same instance.

```dart
final page = await client.timelines.fetchLocal(limit: 20);
```

Pass `onlyMedia: true` to restrict results to statuses that have media attachments.

```dart
final page = await client.timelines.fetchLocal(onlyMedia: true);
```

### Federated timeline

All public statuses the instance has received from across the network.

```dart
final page = await client.timelines.fetchFederated(limit: 20);
```

Optional parameters:

- `onlyMedia` — include only statuses with media attachments
- `remoteOnly` — exclude statuses from local accounts

```dart
final page = await client.timelines.fetchFederated(
  remoteOnly: true,
  onlyMedia: true,
);
```

## Hashtag timeline

Statuses that include the given hashtag. Pass the tag without the `#` prefix.

```dart
final page = await client.timelines.fetchHashtag('mastodon', limit: 20);
```

Additional tag filters let you broaden or narrow results:

- `any` — also include statuses with any of these additional tags
- `all` — require all of these additional tags to be present
- `none` — exclude statuses containing any of these tags

```dart
final page = await client.timelines.fetchHashtag(
  'dart',
  any: ['flutter'],
  none: ['spam'],
);
```

Scope can be restricted with `localOnly` or `remoteOnly`.

## List timeline

Statuses from accounts in a specific list. Requires the list's ID.

```dart
final page = await client.timelines.fetchList('42', limit: 20);
```

## Link timeline

Statuses related to a specific URL (requires server support).

```dart
final page = await client.timelines.fetchLink(
  'https://example.com/article',
  limit: 20,
);
```

## Pagination

All timeline methods return `MastodonPage<MastodonStatus>`, which carries cursors for navigating to older and newer pages.

### Fetching the next page (older statuses)

```dart
var page = await client.timelines.fetchHome(limit: 20);

while (page.nextMaxId != null) {
  page = await client.timelines.fetchHome(
    limit: 20,
    maxId: page.nextMaxId,
  );
  for (final status in page.items) {
    print(status.content);
  }
}
```

### Polling for new statuses

Use `sinceId` to check for statuses newer than the last known ID.

```dart
String? latestId = page.items.firstOrNull?.id;

final newPage = await client.timelines.fetchHome(
  sinceId: latestId,
);
```

### Forward pagination with `minId`

`minId` returns results starting immediately after the given ID with no gaps, which is useful for sequential traversal.

```dart
final nextPage = await client.timelines.fetchHome(
  minId: page.prevMinId,
);
```

See the [Pagination](../pagination.md) guide for a full explanation of the cursor parameters.

## Deprecated: Direct message timeline

`fetchDirect()` was removed in Mastodon 3.0.0. Use the Conversations API instead.
