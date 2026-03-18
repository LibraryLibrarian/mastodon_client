---
sidebar_position: 13
---

# Other APIs

This page covers scheduled statuses, trends, profile image management, app registration, email confirmation, and async refresh status.

## Scheduled statuses

Use `client.scheduledStatuses` to manage statuses queued for future publication. To create a scheduled status, pass `scheduledAt` when calling `client.statuses.create`.

### Listing scheduled statuses

```dart
final page = await client.scheduledStatuses.fetch(limit: 20);
for (final s in page.items) {
  print('${s.id} scheduled for ${s.scheduledAt}');
}

// Paginate
if (page.nextMaxId != null) {
  final next = await client.scheduledStatuses.fetch(maxId: page.nextMaxId);
}
```

Returns `MastodonPage<MastodonScheduledStatus>`. The default limit is 20 and the maximum is 40.

### Fetching a single scheduled status

```dart
final s = await client.scheduledStatuses.fetchById('9876');
```

### Rescheduling

The new time must be at least 5 minutes in the future and should be provided in ISO 8601 format:

```dart
final updated = await client.scheduledStatuses.update(
  '9876',
  scheduledAt: '2025-12-31T23:59:00.000Z',
);
```

### Cancelling

```dart
await client.scheduledStatuses.delete('9876');
```

## Trends

All trend endpoints are public and require no authentication. Use `client.trends`.

### Trending tags

```dart
final tags = await client.trends.fetchTags(limit: 10);
for (final tag in tags) {
  print('#${tag.name}');
}
```

Returns tags with increasing usage over the past week, sorted by internal trend score. The default limit is 10 and the maximum is 20. Use `offset` for pagination.

### Trending statuses

```dart
final statuses = await client.trends.fetchStatuses(limit: 20);
```

Returns statuses that have received significantly more interactions than usual. The default limit is 20 and the maximum is 40.

### Trending links

```dart
final links = await client.trends.fetchLinks(limit: 10);
for (final link in links) {
  print(link.url);
}
```

Returns links being frequently shared across the network. The default limit is 10 and the maximum is 20.

All three methods accept an `offset` parameter for offset-based pagination.

## Profile image management

`client.profile` allows removal of the profile avatar and header images.

### Deleting the avatar

```dart
final account = await client.profile.deleteAvatar();
```

### Deleting the header

```dart
final account = await client.profile.deleteHeader();
```

Both methods return the updated `MastodonCredentialAccount` and succeed even if no image is currently set. They require the `write:accounts` OAuth scope.

To upload a new avatar or header, use `client.accounts.updateCredentials`.

## App registration

Use `client.apps` for OAuth application registration and token verification.

### Registering an application

```dart
final app = await client.apps.create(
  clientName: 'My Mastodon App',
  redirectUris: ['myapp://oauth/callback'],
  scopes: 'read write push',
  website: 'https://example.com',
);
print(app.clientId);
print(app.clientSecret);
```

`redirectUris` is required. For the out-of-band flow, pass `['urn:ietf:wg:oauth:2.0:oob']`. `scopes` defaults to `read` when omitted. Returns `MastodonCredentialApplication`.

### Verifying app credentials

```dart
final app = await client.apps.verifyCredentials();
print(app.name);
```

Returns `MastodonApplication`. Throws an authentication error if the token is invalid.

## Email confirmation

`client.emails` handles confirmation email resending for newly registered accounts.

### Resending the confirmation email

```dart
await client.emails.resendConfirmation();

// Optionally update the email address at the same time
await client.emails.resendConfirmation(email: 'new@example.com');
```

When `email` is provided, the unconfirmed email address is updated before the confirmation is sent.

### Checking confirmation status

```dart
await client.emails.checkConfirmation();
```

Both methods require a token obtained from the client that created the unconfirmed account.

## Async refreshes

`client.asyncRefreshes` allows checking the progress of background refresh jobs. This is an experimental API added in Mastodon 4.4.0.

When a response includes a `Mastodon-Async-Refresh` header, the value is an ID that can be polled until the operation completes:

```dart
final refresh = await client.asyncRefreshes.fetch('refresh-id-from-header');
print(refresh.complete); // true when done
```

Returns `MastodonAsyncRefresh`. Requires the `read` OAuth scope.
