---
sidebar_position: 4
---

# Error Handling

This library maps Mastodon API errors to a sealed class hierarchy rooted at `MastodonException`.

## Exception hierarchy

```
MastodonException (sealed)
├── MastodonApiException              // General HTTP response errors
│   ├── MastodonUnauthorizedException // 401 - Authentication error
│   ├── MastodonForbiddenException    // 403 - Permission error
│   ├── MastodonNotFoundException     // 404 - Resource not found
│   ├── MastodonRateLimitException    // 429 - Rate limited
│   │   └── retryAfter                //   Recommended wait duration
│   ├── MastodonValidationException   // 422 - Validation error
│   │   ├── serverMessage             //   Detailed server message
│   │   └── MastodonAlreadyVotedException // Already voted
│   └── MastodonServerException       // 5xx - Server error
├── MastodonNetworkException          // Network connection error
├── MastodonAuthException (sealed)    // OAuth authentication flow errors
│   ├── MastodonAuthCancelledException    // User cancelled
│   ├── MastodonAuthStateMismatchException // CSRF detected
│   └── MastodonAuthTokenException        // Token acquisition failed
└── MastodonMediaProcessingTimeoutException // Media processing timeout
```

## Basic catch patterns

### Catching all errors

```dart
try {
  final status = await client.statuses.fetch(id);
} on MastodonException catch (e) {
  print('Error: $e');
}
```

### Handling by HTTP status

```dart
try {
  final account = await client.accounts.fetchById(accountId);
} on MastodonNotFoundException {
  print('Account not found');
} on MastodonUnauthorizedException {
  print('Token is invalid. Please re-authenticate');
} on MastodonRateLimitException catch (e) {
  print('Rate limited. Retry after ${e.retryAfter}');
} on MastodonApiException catch (e) {
  print('API error (${e.statusCode}): ${e.message}');
} on MastodonNetworkException {
  print('Check your network connection');
}
```

### Getting validation error details

```dart
try {
  await client.statuses.create(request);
} on MastodonValidationException catch (e) {
  print('Validation error: ${e.serverMessage}');
}
```

## Special exceptions

### MastodonAlreadyVotedException

Thrown when attempting to vote on a poll that has already been voted on.

```dart
try {
  await client.polls.vote(pollId, [0]);
} on MastodonAlreadyVotedException {
  print('Already voted on this poll');
}
```

### MastodonMediaProcessingTimeoutException

Thrown when async media processing times out after upload.

```dart
try {
  final attachment = await client.media.upload(bytes, 'photo.jpg');
} on MastodonMediaProcessingTimeoutException catch (e) {
  print('Media ${e.mediaId} processing timed out');
  // Check status later with client.media.fetchById(e.mediaId)
}
```

## Handling rate limits

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
    final wait = e.retryAfter ?? const Duration(seconds: 60);
    await Future<void>.delayed(wait);
    return action();
  }
}

// Usage
final timeline = await withRetry(
  () => client.timelines.fetchHome(limit: 20),
);
```
