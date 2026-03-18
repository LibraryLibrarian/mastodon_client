---
sidebar_position: 5
---

# Search

The `client.search` API searches across accounts, statuses, and hashtags in a single request.

## Basic search

```dart
final result = await client.search.search('mastodon');

print('Accounts: ${result.accounts.length}');
print('Statuses: ${result.statuses.length}');
print('Hashtags: ${result.hashtags.length}');
```

The result is a `MastodonSearchResult` with three lists:

- `accounts` — `List<MastodonAccount>`
- `statuses` — `List<MastodonStatus>`
- `hashtags` — `List<MastodonTag>`

## Filtering by type

Pass a `type` to restrict results to one category. Accepted values are `'accounts'`, `'statuses'`, and `'hashtags'`.

```dart
// Accounts only
final result = await client.search.search('alice', type: 'accounts');

// Statuses only
final result = await client.search.search('hello world', type: 'statuses');

// Hashtags only
final result = await client.search.search('dart', type: 'hashtags');
```

## Resolving remote accounts

Set `resolve: true` to look up a remote account via WebFinger when no local result is found. This requires a user token.

```dart
final result = await client.search.search(
  'alice@example.social',
  resolve: true,
);
```

## Restricting to followed accounts

Set `following: true` to return only accounts you follow. This requires a user token.

```dart
final result = await client.search.search(
  'alice',
  type: 'accounts',
  following: true,
);
```

## Restricting statuses to a specific account

`accountId` limits status results to posts from a single account.

```dart
final result = await client.search.search(
  'hello',
  type: 'statuses',
  accountId: '109876543210',
);
```

## Excluding unreviewed hashtags

Set `excludeUnreviewed: true` to hide hashtags that have not been reviewed by moderators (added in Mastodon 3.0.0).

```dart
final result = await client.search.search(
  'dart',
  type: 'hashtags',
  excludeUnreviewed: true,
);
```

## Pagination

The search API supports offset-based pagination when `type` is specified, and cursor-based pagination with `minId` / `maxId`.

### Offset-based pagination

`offset` skips results from the beginning. Use together with `limit` and a fixed `type`. Requires a user token.

```dart
final page1 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 0,
);

final page2 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 20,
);
```

### Cursor-based pagination

Use `maxId` and `minId` for cursor-based navigation similar to timeline endpoints.

```dart
final result = await client.search.search(
  'mastodon',
  type: 'statuses',
  maxId: '109876543210',
);
```

The default `limit` is 20 per category; the maximum is 40.

## Deprecated: v1 search

`searchV1()` was removed in Mastodon 3.0.0. It is provided only for compatibility with instances still running 2.x. Use `search()` for all new integrations.

Key differences from v2:

- `hashtags` returns `List<String>` (plain names) rather than `List<MastodonTag>`
- The `following` and `excludeUnreviewed` parameters are not available
