---
sidebar_position: 7
---

# Lists

The `client.lists` API lets you create and manage lists, add or remove accounts, and read list timelines.

## Fetching lists

### All lists

```dart
final lists = await client.lists.fetch();
for (final list in lists) {
  print('${list.id}: ${list.title}');
}
```

Returns `List<MastodonList>` containing every list owned by the authenticated user.

### Single list

```dart
final list = await client.lists.fetchById('42');
print(list.title);
print(list.repliesPolicy); // "followed" | "list" | "none"
print(list.exclusive);     // true if home timeline excludes list members
```

## Creating a list

```dart
final list = await client.lists.create(
  title: 'Developer friends',
  repliesPolicy: 'list',   // show replies between list members
  exclusive: false,
);
print(list.id);
```

`repliesPolicy` accepts:
- `followed` — show replies to users the viewer follows
- `list` — show replies to other list members
- `none` — hide all replies

When `exclusive` is `true`, posts from list members are excluded from the home timeline.

## Updating a list

```dart
final updated = await client.lists.update(
  '42',
  title: 'Close friends',
  repliesPolicy: 'followed',
  exclusive: true,
);
```

## Deleting a list

```dart
await client.lists.delete('42');
```

## Managing accounts

### Fetching accounts in a list

```dart
final page = await client.lists.fetchAccounts(
  '42',
  limit: 40,
);

for (final account in page.items) {
  print(account.acct);
}
```

Returns `MastodonPage<MastodonAccount>`. Use `nextMaxId` and `prevMinId` for pagination:

```dart
MastodonPage<MastodonAccount>? page = await client.lists.fetchAccounts('42');

while (page != null && page.nextMaxId != null) {
  page = await client.lists.fetchAccounts(
    '42',
    maxId: page.nextMaxId,
  );
  for (final account in page.items) {
    print(account.acct);
  }
}
```

Pagination parameters:

| Parameter | Description |
|-----------|-------------|
| `limit`   | Maximum results (default: 40, max: 80; pass `0` for all) |
| `maxId`   | Return results older than this ID |
| `sinceId` | Return results newer than this ID |
| `minId`   | Return results immediately after this ID (forward pagination) |

### Adding accounts

The accounts must be followed by the authenticated user.

```dart
await client.lists.addAccounts(
  '42',
  accountIds: ['100', '101', '102'],
);
```

### Removing accounts

```dart
await client.lists.removeAccounts(
  '42',
  accountIds: ['101'],
);
```

## The MastodonList model

| Field | Type | Description |
|-------|------|-------------|
| `id` | `String` | Internal list ID |
| `title` | `String` | Title of the list |
| `repliesPolicy` | `String` | Reply display policy (`followed` / `list` / `none`) |
| `exclusive` | `bool` | Whether list members are excluded from the home timeline |
