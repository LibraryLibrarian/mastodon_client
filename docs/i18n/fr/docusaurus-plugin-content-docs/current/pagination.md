---
sidebar_position: 3
---

# Pagination

L'API Mastodon utilise une pagination par curseur. Cette bibliothèque l'abstrait via `MastodonPage<T>`.

## Structure de MastodonPage

```dart
class MastodonPage<T> {
  final List<T> items;      // Items in the current page
  final String? nextMaxId;  // Cursor for the next page (older)
  final String? prevMinId;  // Cursor for the previous page (newer)
}
```

## Utilisation de base

### Récupérer la première page

```dart
final page = await client.notifications.fetch(limit: 20);

for (final notification in page.items) {
  print(notification.type);
}
```

### Récupérer la page suivante (plus ancienne)

Passez `nextMaxId` comme paramètre `maxId` :

```dart
if (page.nextMaxId != null) {
  final nextPage = await client.notifications.fetch(
    limit: 20,
    maxId: page.nextMaxId,
  );
}
```

### Récupérer la page précédente (plus récente)

Passez `prevMinId` comme paramètre `minId` :

```dart
if (page.prevMinId != null) {
  final prevPage = await client.notifications.fetch(
    limit: 20,
    minId: page.prevMinId,
  );
}
```

## Paramètres de pagination

| Paramètre | Direction | Description |
|-----------|-----------|-------------|
| `maxId` | Plus ancien | Retourner les résultats avant cet ID |
| `sinceId` | Plus récent | Retourner les résultats après cet ID (peut avoir des interruptions) |
| `minId` | Plus récent | Retourner les résultats immédiatement après cet ID (sans interruption) |
| `limit` | - | Nombre maximum de résultats (valeur par défaut du serveur si omis) |

### Différence entre `sinceId` et `minId`

- `sinceId` : Retourne les `limit` résultats **les plus récents** parmi ceux postérieurs à l'ID donné (peut sauter des éléments intermédiaires)
- `minId` : Retourne `limit` résultats **en commençant immédiatement après** l'ID donné (pagination séquentielle sans interruption)

Utilisez `sinceId` pour vérifier les mises à jour en temps réel. Utilisez `minId` pour la traversée séquentielle des pages.

## Itérer sur toutes les pages

```dart
Future<List<MastodonNotification>> fetchAll() async {
  final all = <MastodonNotification>[];
  String? maxId;

  while (true) {
    final page = await client.notifications.fetch(
      limit: 40,
      maxId: maxId,
    );
    all.addAll(page.items);

    if (page.nextMaxId == null) break;
    maxId = page.nextMaxId;
  }

  return all;
}
```

:::caution
Récupérer de grandes quantités de données en une seule fois charge le serveur. Soyez attentif aux limites de débit.
:::

## APIs avec pagination

Les principales APIs retournant des résultats paginés :

- `client.notifications.fetch()` — Notifications
- `client.accounts.fetchFollowers()` — Abonnés
- `client.accounts.fetchFollowing()` — Abonnements
- `client.accounts.fetchStatuses()` — Statuts d'un compte
- `client.timelines.*` — Fils d'actualité
- `client.favourites.fetch()` — Favoris
- `client.bookmarks.fetch()` — Signets
- `client.blocks.fetch()` — Comptes bloqués
- `client.mutes.fetch()` — Comptes masqués
