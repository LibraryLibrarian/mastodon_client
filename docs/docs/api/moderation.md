---
sidebar_position: 11
---

# Moderation

This page covers the APIs for managing blocked accounts, muted accounts, domain blocks, and user reports.

All list methods return `MastodonPage<T>`, which carries the result items along with `nextMaxId` and `prevMinId` cursors parsed from the `Link` response header. See the [Pagination](../pagination.md) guide for details.

---

## Blocked accounts

### Listing blocks

```dart
final page = await client.blocks.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// Next page
if (page.nextMaxId != null) {
  final next = await client.blocks.fetch(maxId: page.nextMaxId);
}
```

Parameters:

| Parameter | Default | Max | Description |
|-----------|---------|-----|-------------|
| `limit`   | 40      | 80  | Number of results |
| `maxId`   | —       | —   | Return results older than this ID |
| `sinceId` | —       | —   | Return results newer than this ID |
| `minId`   | —       | —   | Return the oldest results after this ID (reverse pagination) |

To block or unblock an account, use `client.accounts.block()` and `client.accounts.unblock()`.

---

## Muted accounts

### Listing mutes

```dart
final page = await client.mutes.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// Next page
if (page.nextMaxId != null) {
  final next = await client.mutes.fetch(maxId: page.nextMaxId);
}
```

Parameters:

| Parameter | Default | Max | Description |
|-----------|---------|-----|-------------|
| `limit`   | 40      | 80  | Number of results |
| `maxId`   | —       | —   | Return results older than this ID |
| `sinceId` | —       | —   | Return results newer than this ID |

To mute or unmute an account, use `client.accounts.mute()` and `client.accounts.unmute()`.

---

## Domain blocks

User-level domain blocks hide posts and notifications from an entire domain. This is distinct from instance-level domain blocks (see `client.instance.fetchDomainBlocks()`).

### Listing blocked domains

```dart
final page = await client.domainBlocks.fetch(limit: 100);
for (final domain in page.items) {
  print(domain);
}
```

Parameters:

| Parameter | Default | Max | Description |
|-----------|---------|-----|-------------|
| `limit`   | 100     | 200 | Number of results |
| `maxId`   | —       | —   | Return results older than this ID |
| `sinceId` | —       | —   | Return results newer than this ID |
| `minId`   | —       | —   | Return the oldest results after this ID (reverse pagination) |

### Blocking a domain

```dart
await client.domainBlocks.block('spam.example.com');
```

Blocking a domain hides all public posts and notifications from accounts on that domain, removes any existing followers from that domain, and prevents new follows to accounts there.

### Unblocking a domain

```dart
await client.domainBlocks.unblock('spam.example.com');
```

---

## Reports

### Reporting an account

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    comment: 'This account is posting spam.',
    category: 'spam',
  ),
);
print(report.id);
```

### Reporting specific statuses

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    statusIds: ['111', '222'],
    comment: 'These posts violate the rules.',
    category: 'violation',
    ruleIds: ['1', '3'],
  ),
);
```

### Forwarding to a remote admin

Set `forward: true` to send a copy of the report to the administrators of the reported account's home server.

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '67890',
    comment: 'Harassment from a remote account.',
    forward: true,
  ),
);
```

### Request fields

| Field        | Required | Description |
|--------------|----------|-------------|
| `accountId`  | Yes      | ID of the account to report |
| `statusIds`  | No       | Status IDs to attach as evidence |
| `comment`    | No       | Reason for the report (max 1000 characters) |
| `forward`    | No       | Forward to the remote server administrator |
| `category`   | No       | `spam`, `legal`, `violation`, or `other` |
| `ruleIds`    | No       | Rule IDs violated (used with `violation` category) |
