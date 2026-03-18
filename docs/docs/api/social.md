---
sidebar_position: 12
---

# Social

This page covers the social graph APIs beyond basic follows: follow requests, followed tags, follow suggestions, endorsements, featured tags, tag operations, favourites, and bookmarks.

## Follow requests

When an account is locked, incoming follow requests must be explicitly accepted or rejected via `client.followRequests`.

### Listing pending requests

```dart
final page = await client.followRequests.fetch(limit: 40);
for (final account in page.items) {
  print('${account.acct} wants to follow you');
}

// Paginate
if (page.nextMaxId != null) {
  final next = await client.followRequests.fetch(maxId: page.nextMaxId);
}
```

`fetch` returns `MastodonPage<MastodonAccount>`. Pagination cursors come from the `Link` response header. The default limit is 40 and the maximum is 80.

### Accepting a request

```dart
final relationship = await client.followRequests.authorize('12345');
print(relationship.followedBy); // true
```

### Rejecting a request

```dart
final relationship = await client.followRequests.reject('12345');
```

Both `authorize` and `reject` return a `MastodonRelationship` reflecting the updated relationship state.

## Followed tags

`client.followedTags` lists the hashtags the authenticated user follows. Posts with followed tags appear on the home timeline.

```dart
final page = await client.followedTags.fetch(limit: 100);
for (final tag in page.items) {
  print('#${tag.name}');
}
```

The default limit is 100 and the maximum is 200. Pagination uses `maxId`, `sinceId`, and `minId`. Note that cursor IDs are internal follow-relationship record IDs, not tag IDs.

To follow or unfollow a specific tag, use `client.tags` (see below).

## Follow suggestions

`client.suggestions` returns accounts that the server recommends following — staff-curated picks or accounts the user has had positive interactions with but does not yet follow.

```dart
final suggestions = await client.suggestions.fetch(limit: 20);
for (final suggestion in suggestions) {
  print('${suggestion.account.acct} — reason: ${suggestion.source}');
}
```

Returns `List<MastodonSuggestion>`. The default limit is 40 and the maximum is 80.

To remove an account from the suggestion list:

```dart
await client.suggestions.remove('12345');
```

This succeeds even if the account is not currently in the suggestions.

## Endorsements

Endorsements are accounts that the user has chosen to feature on their profile. Use `client.endorsements` to retrieve them.

```dart
final page = await client.endorsements.fetch(limit: 40);
for (final account in page.items) {
  print(account.displayName);
}
```

Returns `MastodonPage<MastodonAccount>`. The default limit is 40 and the maximum is 80. To endorse or un-endorse an account, use `client.accounts.endorse` and `client.accounts.unendorse`.

## Featured tags

Featured tags are hashtags displayed prominently on a user's profile. Use `client.featuredTags` to manage them.

### Listing featured tags

```dart
final tags = await client.featuredTags.fetch();
for (final tag in tags) {
  print('#${tag.name} — ${tag.statusesCount} statuses');
}
```

### Adding a featured tag

```dart
final tag = await client.featuredTags.create('dart');
print(tag.id);
```

Pass the tag name without the `#` prefix.

### Removing a featured tag

```dart
await client.featuredTags.delete(tag.id);
```

### Suggestions for featured tags

The server returns up to 10 recently used hashtags as candidates:

```dart
final suggestions = await client.featuredTags.fetchSuggestions();
```

Returns `List<MastodonTag>`.

## Tags

`client.tags` provides tag info, follow, and feature operations.

### Fetching tag info

```dart
final tag = await client.tags.fetch('dart');
print(tag.name);
print(tag.following); // null if unauthenticated
```

The name lookup is case-insensitive. When authenticated, the `following` field is included.

### Following and unfollowing a tag

```dart
final tag = await client.tags.follow('dart');
print(tag.following); // true

final unfollowed = await client.tags.unfollow('dart');
print(unfollowed.following); // false
```

### Featuring and unfeaturing a tag (Mastodon 4.4.0+)

```dart
await client.tags.feature('dart');
await client.tags.unfeature('dart');
```

Both return `MastodonTag` reflecting the updated state.

## Favourites

`client.favourites` lists all statuses the authenticated user has favourited.

```dart
final page = await client.favourites.fetch(limit: 20);
for (final status in page.items) {
  print(status.content);
}

// Older results
if (page.nextMaxId != null) {
  final older = await client.favourites.fetch(maxId: page.nextMaxId);
}
```

Returns `MastodonPage<MastodonStatus>`. The default limit is 20 and the maximum is 40. Pagination uses `maxId`, `sinceId`, and `minId`.

To favourite or unfavourite a specific status, use `client.statuses.favourite` and `client.statuses.unfavourite`.

## Bookmarks

`client.bookmarks` lists all statuses the authenticated user has bookmarked.

```dart
final page = await client.bookmarks.fetch(limit: 20);
for (final status in page.items) {
  print(status.id);
}
```

Returns `MastodonPage<MastodonStatus>`. The default limit is 20 and the maximum is 40. Pagination uses `maxId`, `sinceId`, and `minId`.

To bookmark or remove a bookmark, use `client.statuses.bookmark` and `client.statuses.unbookmark`.
