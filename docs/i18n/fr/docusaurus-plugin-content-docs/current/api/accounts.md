---
sidebar_position: 1
---

# Comptes

L'API `client.accounts` fournit des opérations pour récupérer et gérer les informations de compte.

## Récupérer des comptes

### Par ID

```dart
final account = await client.accounts.fetchById('12345');
print(account.displayName);
print(account.followersCount);
```

### Par nom d'utilisateur (acct)

```dart
final account = await client.accounts.lookup('user@mastodon.social');
```

Si le serveur ne prend pas en charge l'endpoint de lookup, la bibliothèque bascule automatiquement vers une recherche par nom.

### Utilisateur actuel

```dart
final me = await client.accounts.verifyCredentials();
print(me.source); // Additional fields only available for the authenticated user
```

### Plusieurs comptes

```dart
final accounts = await client.accounts.fetchMultiple(['1', '2', '3']);
```

### Recherche

```dart
final results = await client.accounts.search(
  'keyword',
  limit: 10,
  resolve: true, // Resolve remote accounts via WebFinger
);
```

## Graphe social

### Abonnés et abonnements

Les deux retournent `MastodonPage<MastodonAccount>` avec support de la pagination.

```dart
final followers = await client.accounts.fetchFollowers('12345', limit: 40);
final following = await client.accounts.fetchFollowing('12345', limit: 40);
```

Pour les comptes privés, une page vide est retournée au lieu de lever une erreur.

### Relations

```dart
final rels = await client.accounts.fetchRelationships(['12345', '67890']);
for (final rel in rels) {
  print('${rel.id}: following=${rel.following}, followedBy=${rel.followedBy}');
}
```

### Abonnés communs

```dart
final familiar = await client.accounts.fetchFamiliarFollowers(['12345']);
```

## S'abonner / se désabonner

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

## Bloquer / masquer

```dart
// Block
await client.accounts.block('12345');
await client.accounts.unblock('12345');

// Mute with duration
await client.accounts.mute('12345', duration: 3600); // 1 hour
await client.accounts.unmute('12345');
```

## Opérations sur le profil

### Mettre à jour le profil

```dart
final updated = await client.accounts.updateCredentials(
  MastodonCredentialAccountUpdateRequest(
    displayName: 'New Name',
    note: 'Updated bio',
  ),
);
```

### Mettre en avant / retirer de la mise en avant (sur le profil)

```dart
await client.accounts.endorse('12345');   // Feature on profile
await client.accounts.unendorse('12345'); // Remove from profile
```

### Notes privées

```dart
await client.accounts.setNote('12345', comment: 'Met at conference');
```

## Statuts d'un compte

```dart
final page = await client.accounts.fetchStatuses(
  '12345',
  limit: 20,
  excludeReplies: true,
  excludeReblogs: true,
);
```

Filtres disponibles : `excludeReplies`, `excludeReblogs`, `onlyMedia`, `pinned`, `tagged`.
