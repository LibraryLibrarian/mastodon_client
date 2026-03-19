---
sidebar_position: 6
---

# Filters

The `client.filters` API manages server-side content filters (Mastodon 4.0+). Filters hide or warn on statuses matching specified keywords or individual status IDs.

## Fetching filters

### All filters

```dart
final filters = await client.filters.fetch();

for (final filter in filters) {
  print('${filter.title}: ${filter.filterAction}');
}
```

### Single filter

```dart
final filter = await client.filters.fetchById('1');
print(filter.title);
```

## Creating a filter

`title` and `context` are required. `context` is a list of one or more placement contexts where the filter applies:

| Value | Where the filter is applied |
|---|---|
| `home` | Home and list timelines |
| `notifications` | Notification timeline |
| `public` | Public timelines |
| `thread` | Within a conversation thread |
| `account` | When viewing a profile |

```dart
final filter = await client.filters.create(
  title: 'Hide spoilers',
  context: ['home', 'public'],
  filterAction: 'warn',
  expiresIn: 86400, // 1 day; omit for no expiration
);
```

`filterAction` accepts `'warn'` (show a warning), `'hide'` (remove the status entirely), or `'blur'`. When omitted the server default applies.

### Creating with keywords

Supply `keywordsAttributes` to add keywords at creation time.

```dart
final filter = await client.filters.create(
  title: 'Election noise',
  context: ['home', 'notifications', 'public'],
  filterAction: 'warn',
  keywordsAttributes: [
    MastodonFilterKeywordParam(keyword: 'election', wholeWord: true),
    MastodonFilterKeywordParam(keyword: 'vote'),
  ],
);
```

## Updating a filter

All parameters are optional; only the fields you provide are updated.

```dart
final updated = await client.filters.update(
  '1',
  title: 'Updated title',
  filterAction: 'hide',
);
```

## Deleting a filter

```dart
await client.filters.delete('1');
```

## Filter keywords

Keywords are the phrases a filter matches against. Each keyword belongs to a filter.

### Listing keywords

```dart
final keywords = await client.filters.fetchKeywords('1');

for (final kw in keywords) {
  print('${kw.keyword} (whole word: ${kw.wholeWord})');
}
```

### Adding a keyword

```dart
final keyword = await client.filters.createKeyword(
  '1', // filter ID
  keyword: 'spoiler',
  wholeWord: true,
);
```

### Fetching a single keyword

```dart
final keyword = await client.filters.fetchKeywordById('42');
```

### Updating a keyword

```dart
final updated = await client.filters.updateKeyword(
  '42',
  keyword: 'spoilers',
  wholeWord: false,
);
```

### Deleting a keyword

```dart
await client.filters.deleteKeyword('42');
```

### Batch-updating keywords with a filter update

Pass `keywordsAttributes` to `update()` to add, modify, or delete multiple keywords in one request. Set `destroy: true` on an entry to delete it.

```dart
await client.filters.update(
  '1',
  keywordsAttributes: [
    MastodonFilterKeywordUpdateParam(keyword: 'newword'),           // add
    MastodonFilterKeywordUpdateParam(id: '10', keyword: 'changed'), // update
    MastodonFilterKeywordUpdateParam(id: '11', keyword: '', destroy: true), // delete
  ],
);
```

## Filter statuses

In addition to keyword matching, you can add specific statuses to a filter so they are always hidden.

### Listing filtered statuses

```dart
final statuses = await client.filters.fetchStatuses('1');
```

### Adding a status to a filter

```dart
final filterStatus = await client.filters.createStatus(
  '1', // filter ID
  statusId: '109876543210',
);
```

### Fetching a single filter status entry

```dart
final filterStatus = await client.filters.fetchStatusById('99');
```

### Removing a status from a filter

```dart
await client.filters.deleteStatus('99');
```

## Deprecated: v1 filters

The v1 filter API was deprecated in Mastodon 4.0.0. It is provided only for compatibility with older instances.

| v1 method | v2 equivalent |
|---|---|
| `fetchV1()` | `fetch()` |
| `fetchByIdV1(id)` | `fetchById(id)` |
| `createV1(phrase:, context:)` | `create(title:, context:)` |
| `updateV1(id, phrase:, context:)` | `update(id)` |
| `deleteV1(id)` | `delete(id)` |

Notable differences from v2:

- v1 uses a single `phrase` string instead of a list of keywords.
- `irreversible: true` permanently drops matching posts from home and notifications without any client-side warning.
- `deleteV1()` deletes only the `FilterKeyword` record, not the parent filter.
- v1 filters are client-side only; the server does not enforce them.
