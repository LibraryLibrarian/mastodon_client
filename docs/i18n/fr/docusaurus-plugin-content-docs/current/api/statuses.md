---
sidebar_position: 2
---

# Statuts

L'API `client.statuses` fournit des opérations pour créer, récupérer et interagir avec les statuts (publications).

## Récupérer des statuts

### Statut unique

```dart
final status = await client.statuses.fetch('12345');
print(status.content);
```

### Plusieurs statuts

```dart
final statuses = await client.statuses.fetchMultiple(['1', '2', '3']);
```

Les IDs inexistants ou inaccessibles sont silencieusement exclus des résultats.

### Contexte du fil

```dart
final context = await client.statuses.fetchContext('12345');
print('${context.ancestors.length} ancestors');
print('${context.descendants.length} descendants');
```

### Historique des modifications

```dart
final history = await client.statuses.fetchHistory('12345');
for (final edit in history) {
  print(edit.content);
}
```

### Source (pour l'édition)

```dart
final source = await client.statuses.fetchSource('12345');
print(source.text);        // Plain text content
print(source.spoilerText); // CW text
```

## Créer un statut

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

### Avec des médias

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

### Avec un sondage

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

### Statut planifié

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

### Idempotence

```dart
final result = await client.statuses.create(
  request,
  idempotencyKey: 'unique-key-123',
);
```

Les requêtes répétées avec la même clé retournent le même résultat.

## Modifier un statut

```dart
final updated = await client.statuses.edit(
  '12345',
  MastodonStatusEditRequest(
    status: 'Updated content',
  ),
);
```

## Supprimer un statut

```dart
final deleted = await client.statuses.delete('12345');
// Returns a snapshot with source info for redraft purposes
print(deleted.text);
```

## Interactions

### Booster / annuler le boost

```dart
final boosted = await client.statuses.boost('12345');
// Returns a wrapper status; the original is in boosted.reblog

final unboosted = await client.statuses.unboost('12345');
// Returns the original status directly
```

### Ajouter / retirer des favoris

```dart
await client.statuses.favourite('12345');
await client.statuses.unfavourite('12345');
```

### Ajouter / supprimer un signet

```dart
await client.statuses.bookmark('12345');
await client.statuses.unbookmark('12345');
```

### Mettre en sourdine / réactiver la conversation

```dart
await client.statuses.mute('12345');   // Stop thread notifications
await client.statuses.unmute('12345');
```

### Épingler / désépingler

```dart
await client.statuses.pin('12345');
await client.statuses.unpin('12345');
```

## Qui a boosté / mis en favori

```dart
final boosters = await client.statuses.fetchRebloggedBy('12345', limit: 40);
final favouriters = await client.statuses.fetchFavouritedBy('12345', limit: 40);
```

Les deux retournent `MastodonPage<MastodonAccount>` avec pagination.

## Traduction

```dart
final translation = await client.statuses.translate('12345', lang: 'en');
print(translation.content);
```

Seuls les statuts publics ou non listés peuvent être traduits.
