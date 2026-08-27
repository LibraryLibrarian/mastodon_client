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
│   │   ├── retryAfter                //   Recommended wait duration
│   │   ├── limit                     //   Request limit for the window
│   │   ├── remaining                 //   Remaining requests
│   │   └── resetAt                   //   Time when the window resets
│   ├── MastodonValidationException   // 422 - Validation error
│   │   ├── serverMessage             //   Detailed server message
│   │   └── MastodonAlreadyVotedException // Already voted
│   └── MastodonServerException       // 5xx - Server error
├── MastodonNetworkException          // Network connection error
└── MastodonAuthException (sealed)    // OAuth authentication flow errors
    ├── MastodonAuthCancelledException    // User cancelled
    ├── MastodonAuthStateMismatchException // CSRF detected
    └── MastodonAuthTokenException        // Token acquisition failed
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

## Gérer les limites de débit

`MastodonRateLimitException` expose les en-têtes `X-RateLimit-*` de Mastodon.
L'attente recommandée utilise `Retry-After` lorsqu'il est fourni par le serveur
ou le proxy, puis se rabat sur l'horodatage `X-RateLimit-Reset`.

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
    print('${e.remaining}/${e.limit} requêtes restantes ; réinitialisation à ${e.resetAt}');
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
