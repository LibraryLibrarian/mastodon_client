---
sidebar_position: 4
---

# Fils d'actualité

L'API `client.timelines` récupère des flux de statuts depuis différentes sources. Toutes les méthodes retournent `MastodonPage<MastodonStatus>` et supportent la pagination par curseur.

## Fil personnel

Le fil personnel contient les statuts des comptes que vous suivez.

```dart
final page = await client.timelines.fetchHome(limit: 20);

for (final status in page.items) {
  print('${status.account.acct}: ${status.content}');
}
```

## Fils publics

### Fil local

Statuts des comptes de la même instance.

```dart
final page = await client.timelines.fetchLocal(limit: 20);
```

Passez `onlyMedia: true` pour restreindre les résultats aux statuts contenant des pièces jointes médias.

```dart
final page = await client.timelines.fetchLocal(onlyMedia: true);
```

### Fil fédéré

Tous les statuts publics reçus par l'instance depuis l'ensemble du réseau.

```dart
final page = await client.timelines.fetchFederated(limit: 20);
```

Paramètres optionnels :

- `onlyMedia` — inclure uniquement les statuts avec des pièces jointes médias
- `remoteOnly` — exclure les statuts des comptes locaux

```dart
final page = await client.timelines.fetchFederated(
  remoteOnly: true,
  onlyMedia: true,
);
```

## Fil de hashtag

Statuts incluant le hashtag donné. Passez le tag sans le préfixe `#`.

```dart
final page = await client.timelines.fetchHashtag('mastodon', limit: 20);
```

Des filtres de tags supplémentaires permettent d'élargir ou de restreindre les résultats :

- `any` — inclure également les statuts contenant l'un de ces tags supplémentaires
- `all` — exiger la présence de tous ces tags supplémentaires
- `none` — exclure les statuts contenant l'un de ces tags

```dart
final page = await client.timelines.fetchHashtag(
  'dart',
  any: ['flutter'],
  none: ['spam'],
);
```

La portée peut être restreinte avec `localOnly` ou `remoteOnly`.

## Fil de liste

Statuts des comptes dans une liste spécifique. Nécessite l'ID de la liste.

```dart
final page = await client.timelines.fetchList('42', limit: 20);
```

## Fil de lien

Statuts liés à une URL spécifique (nécessite le support du serveur).

```dart
final page = await client.timelines.fetchLink(
  'https://example.com/article',
  limit: 20,
);
```

## Pagination

Toutes les méthodes de fil retournent `MastodonPage<MastodonStatus>`, qui contient des curseurs pour naviguer vers les pages plus anciennes et plus récentes.

### Récupérer la page suivante (statuts plus anciens)

```dart
var page = await client.timelines.fetchHome(limit: 20);

while (page.nextMaxId != null) {
  page = await client.timelines.fetchHome(
    limit: 20,
    maxId: page.nextMaxId,
  );
  for (final status in page.items) {
    print(status.content);
  }
}
```

### Surveiller les nouveaux statuts

Utilisez `sinceId` pour vérifier les statuts plus récents que le dernier ID connu.

```dart
String? latestId = page.items.firstOrNull?.id;

final newPage = await client.timelines.fetchHome(
  sinceId: latestId,
);
```

### Pagination en avant avec `minId`

`minId` retourne les résultats démarrant immédiatement après l'ID donné sans lacunes, ce qui est utile pour la traversée séquentielle.

```dart
final nextPage = await client.timelines.fetchHome(
  minId: page.prevMinId,
);
```

Consultez le guide [Pagination](../pagination.md) pour une explication complète des paramètres de curseur.

## Déprécié : fil des messages directs

`fetchDirect()` a été supprimé dans Mastodon 3.0.0. Utilisez l'API Conversations à la place.
