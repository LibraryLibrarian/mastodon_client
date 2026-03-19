---
sidebar_position: 2
---

# Status

Die `client.statuses`-API stellt Operationen zum Erstellen, Abrufen und Interagieren mit Statusmeldungen (Beiträgen) bereit.

## Status abrufen

### Einzelner Status

```dart
final status = await client.statuses.fetch('12345');
print(status.content);
```

### Mehrere Status

```dart
final statuses = await client.statuses.fetchMultiple(['1', '2', '3']);
```

Nicht vorhandene oder nicht zugängliche IDs werden stillschweigend aus den Ergebnissen ausgeschlossen.

### Thread-Kontext

```dart
final context = await client.statuses.fetchContext('12345');
print('${context.ancestors.length} ancestors');
print('${context.descendants.length} descendants');
```

### Bearbeitungsverlauf

```dart
final history = await client.statuses.fetchHistory('12345');
for (final edit in history) {
  print(edit.content);
}
```

### Quelle (zum Bearbeiten)

```dart
final source = await client.statuses.fetchSource('12345');
print(source.text);        // Plain text content
print(source.spoilerText); // CW text
```

## Status erstellen

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

### Mit Medien

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

### Mit einer Umfrage

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

### Geplanter Status

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

### Idempotenz

```dart
final result = await client.statuses.create(
  request,
  idempotencyKey: 'unique-key-123',
);
```

Wiederholte Anfragen mit demselben Key liefern dasselbe Ergebnis.

## Status bearbeiten

```dart
final updated = await client.statuses.edit(
  '12345',
  MastodonStatusEditRequest(
    status: 'Updated content',
  ),
);
```

## Status löschen

```dart
final deleted = await client.statuses.delete('12345');
// Returns a snapshot with source info for redraft purposes
print(deleted.text);
```

## Interaktionen

### Boost / Boost aufheben

```dart
final boosted = await client.statuses.boost('12345');
// Returns a wrapper status; the original is in boosted.reblog

final unboosted = await client.statuses.unboost('12345');
// Returns the original status directly
```

### Favorisieren / Favorit entfernen

```dart
await client.statuses.favourite('12345');
await client.statuses.unfavourite('12345');
```

### Lesezeichen / Lesezeichen aufheben

```dart
await client.statuses.bookmark('12345');
await client.statuses.unbookmark('12345');
```

### Konversation stummschalten / Stummschaltung aufheben

```dart
await client.statuses.mute('12345');   // Stop thread notifications
await client.statuses.unmute('12345');
```

### Anheften / Loslösen

```dart
await client.statuses.pin('12345');
await client.statuses.unpin('12345');
```

## Wer geboostet / favorisiert hat

```dart
final boosters = await client.statuses.fetchRebloggedBy('12345', limit: 40);
final favouriters = await client.statuses.fetchFavouritedBy('12345', limit: 40);
```

Beide geben `MastodonPage<MastodonAccount>` mit Paginierung zurück.

## Übersetzung

```dart
final translation = await client.statuses.translate('12345', lang: 'en');
print(translation.content);
```

Nur öffentliche oder nicht gelistete Status können übersetzt werden.
