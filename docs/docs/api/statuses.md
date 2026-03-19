---
sidebar_position: 2
---

# Statuses

The `client.statuses` API provides operations for creating, fetching, and interacting with statuses (posts).

## Fetching statuses

### Single status

```dart
final status = await client.statuses.fetch('12345');
print(status.content);
```

### Multiple statuses

```dart
final statuses = await client.statuses.fetchMultiple(['1', '2', '3']);
```

Non-existent or inaccessible IDs are silently excluded from the results.

### Thread context

```dart
final context = await client.statuses.fetchContext('12345');
print('${context.ancestors.length} ancestors');
print('${context.descendants.length} descendants');
```

### Edit history

```dart
final history = await client.statuses.fetchHistory('12345');
for (final edit in history) {
  print(edit.content);
}
```

### Source (for editing)

```dart
final source = await client.statuses.fetchSource('12345');
print(source.text);        // Plain text content
print(source.spoilerText); // CW text
```

## Creating a status

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Hello, Mastodon!',
    visibility: MastodonVisibility.public,
  ),
);

// result is MastodonStatusCreated or MastodonStatusScheduled
if (result case MastodonStatusCreated(:final status)) {
  print('Posted: ${status.url}');
}
```

### With media

```dart
final attachment = await client.media.upload(imageBytes, 'photo.jpg',
  description: 'A beautiful sunset',
);

final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Check this out!',
    mediaIds: [attachment.id],
  ),
);
```

### With a poll

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'What do you prefer?',
    poll: MastodonPollCreateRequest(
      options: ['Option A', 'Option B', 'Option C'],
      expiresIn: 86400, // 24 hours
      multiple: false,
    ),
  ),
);
```

### Scheduled status

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'This will be posted later',
    scheduledAt: '2025-12-31T00:00:00.000Z',
  ),
);

if (result case MastodonStatusScheduled(:final scheduledStatus)) {
  print('Scheduled for: ${scheduledStatus.scheduledAt}');
}
```

### Idempotency

```dart
final result = await client.statuses.create(
  request,
  idempotencyKey: 'unique-key-123',
);
```

Repeated requests with the same key return the same result.

## Editing a status

```dart
final updated = await client.statuses.edit(
  '12345',
  MastodonStatusEditRequest(
    status: 'Updated content',
  ),
);
```

## Deleting a status

```dart
final deleted = await client.statuses.delete('12345');
// Returns a snapshot with source info for redraft purposes
print(deleted.text);
```

## Interactions

### Boost / unboost

```dart
final boosted = await client.statuses.boost('12345');
// Returns a wrapper status; the original is in boosted.reblog

final unboosted = await client.statuses.unboost('12345');
// Returns the original status directly
```

### Favourite / unfavourite

```dart
await client.statuses.favourite('12345');
await client.statuses.unfavourite('12345');
```

### Bookmark / unbookmark

```dart
await client.statuses.bookmark('12345');
await client.statuses.unbookmark('12345');
```

### Mute / unmute conversation

```dart
await client.statuses.mute('12345');   // Stop thread notifications
await client.statuses.unmute('12345');
```

### Pin / unpin

```dart
await client.statuses.pin('12345');
await client.statuses.unpin('12345');
```

## Who boosted / favourited

```dart
final boosters = await client.statuses.fetchRebloggedBy('12345', limit: 40);
final favouriters = await client.statuses.fetchFavouritedBy('12345', limit: 40);
```

Both return `MastodonPage<MastodonAccount>` with pagination.

## Translation

```dart
final translation = await client.statuses.translate('12345', lang: 'en');
print(translation.content);
```

Only public or unlisted statuses can be translated.
