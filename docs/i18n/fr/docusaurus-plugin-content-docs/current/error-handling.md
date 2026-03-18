---
sidebar_position: 4
---

# Gestion des erreurs

Cette bibliothèque mappe les erreurs de l'API Mastodon vers une hiérarchie de classes scellées (sealed classes) dont la racine est `MastodonException`.

## Hiérarchie des exceptions

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

## Modèles de capture de base

### Capturer toutes les erreurs

```dart
try {
  final status = await client.statuses.fetch(id);
} on MastodonException catch (e) {
  print('Error: $e');
}
```

### Gérer par code de statut HTTP

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

### Obtenir les détails des erreurs de validation

```dart
try {
  await client.statuses.create(request);
} on MastodonValidationException catch (e) {
  print('Validation error: ${e.serverMessage}');
}
```

## Exceptions spéciales

### MastodonAlreadyVotedException

Levée lorsqu'on tente de voter dans un sondage auquel on a déjà participé.

```dart
try {
  await client.polls.vote(pollId, [0]);
} on MastodonAlreadyVotedException {
  print('Already voted on this poll');
}
```

### MastodonMediaProcessingTimeoutException

Levée lorsque le traitement asynchrone d'un média dépasse le délai après le téléversement.

```dart
try {
  final attachment = await client.media.upload(bytes, 'photo.jpg');
} on MastodonMediaProcessingTimeoutException catch (e) {
  print('Media ${e.mediaId} processing timed out');
  // Check status later with client.media.fetchById(e.mediaId)
}
```

## Gérer les limites de débit

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
