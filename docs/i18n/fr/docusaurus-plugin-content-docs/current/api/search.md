---
sidebar_position: 5
---

# Recherche

L'API `client.search` effectue des recherches sur les comptes, statuts et hashtags en une seule requête.

## Recherche de base

```dart
final result = await client.search.search('mastodon');

print('Accounts: ${result.accounts.length}');
print('Statuses: ${result.statuses.length}');
print('Hashtags: ${result.hashtags.length}');
```

Le résultat est un `MastodonSearchResult` avec trois listes :

- `accounts` — `List<MastodonAccount>`
- `statuses` — `List<MastodonStatus>`
- `hashtags` — `List<MastodonTag>`

## Filtrer par type

Passez un `type` pour restreindre les résultats à une catégorie. Les valeurs acceptées sont `'accounts'`, `'statuses'` et `'hashtags'`.

```dart
// Accounts only
final result = await client.search.search('alice', type: 'accounts');

// Statuses only
final result = await client.search.search('hello world', type: 'statuses');

// Hashtags only
final result = await client.search.search('dart', type: 'hashtags');
```

## Résoudre les comptes distants

Définissez `resolve: true` pour rechercher un compte distant via WebFinger si aucun résultat local n'est trouvé. Cela nécessite un token utilisateur.

```dart
final result = await client.search.search(
  'alice@example.social',
  resolve: true,
);
```

## Restreindre aux comptes suivis

Définissez `following: true` pour retourner uniquement les comptes que vous suivez. Cela nécessite un token utilisateur.

```dart
final result = await client.search.search(
  'alice',
  type: 'accounts',
  following: true,
);
```

## Restreindre les statuts à un compte spécifique

`accountId` limite les résultats de statuts aux publications d'un seul compte.

```dart
final result = await client.search.search(
  'hello',
  type: 'statuses',
  accountId: '109876543210',
);
```

## Exclure les hashtags non examinés

Définissez `excludeUnreviewed: true` pour masquer les hashtags non encore examinés par les modérateurs (ajouté dans Mastodon 3.0.0).

```dart
final result = await client.search.search(
  'dart',
  type: 'hashtags',
  excludeUnreviewed: true,
);
```

## Pagination

L'API de recherche supporte la pagination par décalage quand `type` est spécifié, et la pagination par curseur avec `minId` / `maxId`.

### Pagination par décalage

`offset` saute des résultats depuis le début. À utiliser avec `limit` et un `type` fixe. Nécessite un token utilisateur.

```dart
final page1 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 0,
);

final page2 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 20,
);
```

### Pagination par curseur

Utilisez `maxId` et `minId` pour la navigation par curseur, similaire aux endpoints de fil.

```dart
final result = await client.search.search(
  'mastodon',
  type: 'statuses',
  maxId: '109876543210',
);
```

La `limit` par défaut est 20 par catégorie ; le maximum est 40.

## Dépréciée : recherche v1

`searchV1()` a été supprimé dans Mastodon 3.0.0. Il n'est fourni que pour la compatibilité avec les instances fonctionnant encore sous 2.x. Utilisez `search()` pour toutes les nouvelles intégrations.

Différences clés par rapport à v2 :

- `hashtags` retourne `List<String>` (noms simples) plutôt que `List<MastodonTag>`
- Les paramètres `following` et `excludeUnreviewed` ne sont pas disponibles
