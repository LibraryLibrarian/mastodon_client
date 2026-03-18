---
sidebar_position: 4
---

# Fehlerbehandlung

Diese Bibliothek bildet Mastodon-API-Fehler auf eine Sealed-Class-Hierarchie ab, deren Wurzel `MastodonException` ist.

## Exception-Hierarchie

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

## Grundlegende Catch-Muster

### Alle Fehler abfangen

```dart
try {
  final status = await client.statuses.fetch(id);
} on MastodonException catch (e) {
  print('Error: $e');
}
```

### Nach HTTP-Status behandeln

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

### Details zu Validierungsfehlern abrufen

```dart
try {
  await client.statuses.create(request);
} on MastodonValidationException catch (e) {
  print('Validation error: ${e.serverMessage}');
}
```

## Besondere Exceptions

### MastodonAlreadyVotedException

Wird ausgelöst, wenn versucht wird, in einer Umfrage abzustimmen, in der bereits abgestimmt wurde.

```dart
try {
  await client.polls.vote(pollId, [0]);
} on MastodonAlreadyVotedException {
  print('Already voted on this poll');
}
```

### MastodonMediaProcessingTimeoutException

Wird ausgelöst, wenn die asynchrone Medienverarbeitung nach dem Upload zu lange dauert.

```dart
try {
  final attachment = await client.media.upload(bytes, 'photo.jpg');
} on MastodonMediaProcessingTimeoutException catch (e) {
  print('Media ${e.mediaId} processing timed out');
  // Check status later with client.media.fetchById(e.mediaId)
}
```

## Rate-Limits behandeln

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
