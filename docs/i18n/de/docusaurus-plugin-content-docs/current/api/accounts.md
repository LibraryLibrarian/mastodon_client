---
sidebar_position: 1
---

# Accounts

Die `client.accounts`-API stellt Operationen zum Abrufen und Verwalten von Kontoinformationen bereit.

## Accounts abrufen

### Nach ID

```dart
final account = await client.accounts.fetchById('12345');
print(account.displayName);
print(account.followersCount);
```

### Nach Benutzername (acct)

```dart
final account = await client.accounts.lookup('user@mastodon.social');
```

Wenn der Server den Lookup-Endpunkt nicht unterstützt, greift die Bibliothek automatisch auf eine suchbasierte Abfrage zurück.

### Aktueller Benutzer

```dart
final me = await client.accounts.verifyCredentials();
print(me.source); // Additional fields only available for the authenticated user
```

### Mehrere Accounts

```dart
final accounts = await client.accounts.fetchMultiple(['1', '2', '3']);
```

### Suche

```dart
final results = await client.accounts.search(
  'keyword',
  limit: 10,
  resolve: true, // Resolve remote accounts via WebFinger
);
```

## Sozialer Graph

### Follower und Gefolgte

Beide geben `MastodonPage<MastodonAccount>` mit Paginierungsunterstützung zurück.

```dart
final followers = await client.accounts.fetchFollowers('12345', limit: 40);
final following = await client.accounts.fetchFollowing('12345', limit: 40);
```

Bei privaten Accounts wird eine leere Seite zurückgegeben, anstatt einen Fehler zu werfen.

### Beziehungen

```dart
final rels = await client.accounts.fetchRelationships(['12345', '67890']);
for (final rel in rels) {
  print('${rel.id}: following=${rel.following}, followedBy=${rel.followedBy}');
}
```

### Gemeinsame Follower

```dart
final familiar = await client.accounts.fetchFamiliarFollowers(['12345']);
```

## Folgen / Entfolgen

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

## Blockieren / Stummschalten

```dart
// Block
await client.accounts.block('12345');
await client.accounts.unblock('12345');

// Mute with duration
await client.accounts.mute('12345', duration: 3600); // 1 hour
await client.accounts.unmute('12345');
```

## Profil-Operationen

### Profil aktualisieren

```dart
final updated = await client.accounts.updateCredentials(
  MastodonCredentialAccountUpdateRequest(
    displayName: 'New Name',
    note: 'Updated bio',
  ),
);
```

### Empfehlen / Empfehlung entfernen (im Profil hervorheben)

```dart
await client.accounts.endorse('12345');   // Feature on profile
await client.accounts.unendorse('12345'); // Remove from profile
```

### Private Notizen

```dart
await client.accounts.setNote('12345', comment: 'Met at conference');
```

## Account-Status

```dart
final page = await client.accounts.fetchStatuses(
  '12345',
  limit: 20,
  excludeReplies: true,
  excludeReblogs: true,
);
```

Verfügbare Filter: `excludeReplies`, `excludeReblogs`, `onlyMedia`, `pinned`, `tagged`.
