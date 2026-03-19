---
sidebar_position: 1
---

# Accounts

The `client.accounts` API provides operations for retrieving and managing account information.

## Fetching accounts

### By ID

```dart
final account = await client.accounts.fetchById('12345');
print(account.displayName);
print(account.followersCount);
```

### By username (acct)

```dart
final account = await client.accounts.lookup('user@mastodon.social');
```

If the server does not support the lookup endpoint, the library automatically falls back to a search-based lookup.

### Current user

```dart
final me = await client.accounts.verifyCredentials();
print(me.source); // Additional fields only available for the authenticated user
```

### Multiple accounts

```dart
final accounts = await client.accounts.fetchMultiple(['1', '2', '3']);
```

### Search

```dart
final results = await client.accounts.search(
  'keyword',
  limit: 10,
  resolve: true, // Resolve remote accounts via WebFinger
);
```

## Social graph

### Followers and following

Both return `MastodonPage<MastodonAccount>` with pagination support.

```dart
final followers = await client.accounts.fetchFollowers('12345', limit: 40);
final following = await client.accounts.fetchFollowing('12345', limit: 40);
```

For private accounts, an empty page is returned instead of throwing an error.

### Relationships

```dart
final rels = await client.accounts.fetchRelationships(['12345', '67890']);
for (final rel in rels) {
  print('${rel.id}: following=${rel.following}, followedBy=${rel.followedBy}');
}
```

### Familiar followers

```dart
final familiar = await client.accounts.fetchFamiliarFollowers(['12345']);
```

## Follow / unfollow

```dart
// Follow with options
final rel = await client.accounts.follow(
  '12345',
  reblogs: true,        // Show boosts in home timeline
  notify: true,         // Receive notifications on new posts
  languages: ['en'],    // Only show posts in these languages
);

// Unfollow
await client.accounts.unfollow('12345');
```

## Block / mute

```dart
// Block
await client.accounts.block('12345');
await client.accounts.unblock('12345');

// Mute with duration
await client.accounts.mute('12345', duration: 3600); // 1 hour
await client.accounts.unmute('12345');
```

## Profile operations

### Update profile

```dart
final updated = await client.accounts.updateCredentials(
  MastodonCredentialAccountUpdateRequest(
    displayName: 'New Name',
    note: 'Updated bio',
  ),
);
```

### Endorse / unendorse (feature on profile)

```dart
await client.accounts.endorse('12345');   // Feature on profile
await client.accounts.unendorse('12345'); // Remove from profile
```

### Private notes

```dart
await client.accounts.setNote('12345', comment: 'Met at conference');
```

## Account statuses

```dart
final page = await client.accounts.fetchStatuses(
  '12345',
  limit: 20,
  excludeReplies: true,
  excludeReblogs: true,
);
```

Available filters: `excludeReplies`, `excludeReblogs`, `onlyMedia`, `pinned`, `tagged`.
