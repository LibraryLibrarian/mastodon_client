---
sidebar_position: 14
---

# Admin

The admin APIs provide server management capabilities. All endpoints require elevated OAuth scopes (typically `admin:read:*` or `admin:write:*`). Use these APIs only with accounts that hold the appropriate server-side permissions.

## Accounts

`client.adminAccounts` exposes full account management for administrators.

### Listing accounts

Two versions of the listing endpoint are available.

**v1** — boolean filter flags:

```dart
final page = await client.adminAccounts.fetch(
  pending: true,   // only accounts awaiting approval
  limit: 100,
);
for (final account in page.items) {
  print('${account.account?.acct} — ${account.email}');
}
```

Available filters: `local`, `remote`, `active`, `pending`, `disabled`, `silenced`, `suspended`, `sensitized`, `staff`. Search parameters: `username`, `displayName`, `email`, `ip`, `byDomain`. Pagination: `maxId`, `sinceId`, `minId`. Default limit 100, maximum 200.

**v2** — structured filter parameters (preferred for new code):

```dart
final page = await client.adminAccounts.fetchV2(
  origin: 'local',
  status: 'pending',
  limit: 50,
);
```

`origin` is `local` or `remote`. `status` is one of `active`, `pending`, `disabled`, `silenced`, or `suspended`. Pass `staff` as `permissions` to restrict to staff accounts. `roleIds` filters by assigned role IDs, and `invitedBy` filters by the inviter's account ID.

### Fetching a single account

```dart
final account = await client.adminAccounts.fetchById('12345');
print(account.ip);
print(account.confirmed);
```

### Approving and rejecting pending accounts

```dart
await client.adminAccounts.approve('12345');
await client.adminAccounts.reject('12345');
```

### Performing moderation actions

```dart
await client.adminAccounts.performAction(
  '12345',
  MastodonAdminAccountActionRequest(
    type: 'suspend',
    reportId: '999',
    text: 'Violated community guidelines.',
    sendEmailNotification: true,
  ),
);
```

Related unresolved reports are automatically resolved. Requires "Manage Users" and "Manage Reports" permissions.

### Other moderation methods

```dart
await client.adminAccounts.enable('12345');       // re-enable a disabled account
await client.adminAccounts.unsilence('12345');    // remove silence
await client.adminAccounts.unsuspend('12345');    // lift suspension
await client.adminAccounts.unsensitive('12345'); // remove sensitive flag
```

### Deleting account data

```dart
await client.adminAccounts.delete('12345');
```

Permanently deletes the data of a suspended account. Requires "Delete user data" permission.

## Reports

`client.adminReports` manages abuse reports submitted by users.

### Listing reports

```dart
final page = await client.adminReports.fetch(
  resolved: false,  // unresolved reports only
  limit: 100,
);
```

Filter by `accountId` (reporter) or `targetAccountId` (reported account). Use `resolved: true` to show only resolved reports. Pagination via `maxId`, `sinceId`, `minId`.

### Fetching and updating a report

```dart
final report = await client.adminReports.fetchById('42');

final updated = await client.adminReports.update(
  '42',
  MastodonAdminReportUpdateRequest(assignedAccountId: 'moderator-id'),
);
```

### Assignment and resolution

```dart
await client.adminReports.assignToSelf('42');
await client.adminReports.unassign('42');
await client.adminReports.resolve('42');
await client.adminReports.reopen('42'); // re-open a resolved report
```

## Domain management

### Domain allow list

For servers running in allowlist mode, `client.adminDomainAllows` controls which remote domains are permitted to federate.

```dart
// List allowed domains
final page = await client.adminDomainAllows.fetch();

// Allow a domain
final entry = await client.adminDomainAllows.create(domain: 'example.social');

// Remove an allowed domain
await client.adminDomainAllows.delete(entry.id);
```

### Domain block list

`client.adminDomainBlocks` manages federation blocks against remote domains.

```dart
// List blocked domains
final page = await client.adminDomainBlocks.fetch();

// Block a domain
final block = await client.adminDomainBlocks.create(
  MastodonAdminDomainBlockRequest(
    domain: 'spam.example',
    severity: 'suspend',
    rejectMedia: true,
    rejectReports: true,
    privateComment: 'Known spam instance',
    publicComment: 'Suspended for spam.',
  ),
);

// Update a block
await client.adminDomainBlocks.update(block.id, updatedRequest);

// Delete a block
await client.adminDomainBlocks.delete(block.id);
```

## IP blocks

`client.adminIpBlocks` manages IP address range blocks.

```dart
// List IP blocks
final page = await client.adminIpBlocks.fetch();

// Create an IP block
final block = await client.adminIpBlocks.create(
  MastodonAdminIpBlockCreateRequest(
    ip: '192.0.2.0/24',
    severity: 'no_access',
    comment: 'Abusive subnet',
  ),
);

// Update
await client.adminIpBlocks.update(
  block.id,
  MastodonAdminIpBlockUpdateRequest(severity: 'sign_up_block'),
);

// Delete
await client.adminIpBlocks.delete(block.id);
```

## Email blocks

### Canonical email blocks

`client.adminCanonicalEmailBlocks` blocks normalized (canonical) email addresses. This prevents users from re-registering with address variations of a blocked email.

```dart
// List blocks
final page = await client.adminCanonicalEmailBlocks.fetch();

// Test whether an email matches any existing block
final matches = await client.adminCanonicalEmailBlocks.test(
  email: 'test@example.com',
);

// Block by email address (canonical hash is computed server-side)
final block = await client.adminCanonicalEmailBlocks.create(
  email: 'spammer@example.com',
);

// Or block by pre-computed hash
await client.adminCanonicalEmailBlocks.create(
  canonicalEmailHash: 'sha256hashvalue',
);

// Delete
await client.adminCanonicalEmailBlocks.delete(block.id);
```

### Email domain blocks

`client.adminEmailDomainBlocks` prevents sign-ups from entire email domains.

```dart
// List blocked email domains
final page = await client.adminEmailDomainBlocks.fetch();

// Block a domain
final block = await client.adminEmailDomainBlocks.create(
  domain: 'disposable-mail.example',
);

// Delete
await client.adminEmailDomainBlocks.delete(block.id);
```

## Admin tags

`client.adminTags` provides administrative control over hashtags.

### Listing and fetching tags

```dart
final page = await client.adminTags.fetch(limit: 50);
final tag = await client.adminTags.fetchById('tag-id');
```

### Updating a tag

```dart
final updated = await client.adminTags.update(
  'tag-id',
  displayName: 'Dart',
  listable: true,
  trendable: true,
  usable: true,
);
```

All fields are optional; only provided values are changed. `listable` controls whether the tag appears in public listings, `trendable` whether it is eligible for the trends endpoint, and `usable` whether it may be used in posts.

## Admin trends

`client.adminTrends` provides access to unreviewed trending content and allows approving or rejecting items before they appear publicly.

### Trending links

```dart
final links = await client.adminTrends.fetchLinks();
await client.adminTrends.approveLink(id: links.first.id);
await client.adminTrends.rejectLink(id: links.first.id);
```

### Link publishers

```dart
final publishers = await client.adminTrends.fetchPublishers();
await client.adminTrends.approvePublisher(id: publishers.first.id);
await client.adminTrends.rejectPublisher(id: publishers.first.id);
```

### Trending statuses

```dart
final statuses = await client.adminTrends.fetchStatuses();
await client.adminTrends.approveStatus(id: statuses.first.id);
await client.adminTrends.rejectStatus(id: statuses.first.id);
```

### Trending tags

```dart
final tags = await client.adminTrends.fetchTags();
await client.adminTrends.approveTag(id: tags.first.id);
await client.adminTrends.rejectTag(id: tags.first.id);
```

Read endpoints require the `admin:read` scope; write endpoints require `admin:write`.

## Measures, dimensions, and retention

These analytics endpoints all use `POST` with a request body that specifies the metrics and date range to query.

### Measures (quantitative data)

```dart
final measures = await client.adminMeasures.fetch(
  MastodonAdminMeasureRequest(
    keys: ['active_users', 'new_users'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
for (final m in measures) {
  print('${m.key}: ${m.total}');
}
```

Returns time-series data such as active users, new user registrations, and interaction counts.

### Dimensions (qualitative data)

```dart
final dimensions = await client.adminDimensions.fetch(
  MastodonAdminDimensionRequest(
    keys: ['languages', 'sources'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
```

Returns categorical breakdowns such as language distribution or client software versions.

### Retention (cohort data)

```dart
final cohorts = await client.adminRetention.fetch(
  MastodonAdminRetentionRequest(
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 3, 31),
    frequency: 'month',
  ),
);
```

Returns user retention cohort data grouped by signup period and subsequent activity. All three analytics endpoints require the `admin:read` OAuth scope.
