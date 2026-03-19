---
sidebar_position: 12
---

# Social

Cette page couvre les APIs du graphe social au-delà des abonnements simples : demandes d'abonnement, tags suivis, suggestions d'abonnement, mises en avant, tags vedettes, opérations sur les tags, favoris et signets.

## Demandes d'abonnement

Lorsqu'un compte est verrouillé, les demandes d'abonnement entrantes doivent être explicitement acceptées ou rejetées via `client.followRequests`.

### Lister les demandes en attente

```dart
final page = await client.followRequests.fetch(limit: 40);
for (final account in page.items) {
  print('${account.acct} wants to follow you');
}

// Paginate
if (page.nextMaxId != null) {
  final next = await client.followRequests.fetch(maxId: page.nextMaxId);
}
```

`fetch` retourne `MastodonPage<MastodonAccount>`. Les curseurs de pagination proviennent de l'en-tête de réponse `Link`. La limite par défaut est 40 et le maximum est 80.

### Accepter une demande

```dart
final relationship = await client.followRequests.authorize('12345');
print(relationship.followedBy); // true
```

### Rejeter une demande

```dart
final relationship = await client.followRequests.reject('12345');
```

`authorize` et `reject` retournent tous deux un `MastodonRelationship` reflétant l'état de la relation mise à jour.

## Tags suivis

`client.followedTags` liste les hashtags que l'utilisateur authentifié suit. Les publications avec des tags suivis apparaissent dans le fil personnel.

```dart
final page = await client.followedTags.fetch(limit: 100);
for (final tag in page.items) {
  print('#${tag.name}');
}
```

La limite par défaut est 100 et le maximum est 200. La pagination utilise `maxId`, `sinceId` et `minId`. Notez que les IDs de curseur sont des IDs internes d'enregistrements de relation d'abonnement, et non des IDs de tags.

Pour suivre ou ne plus suivre un tag spécifique, utilisez `client.tags` (voir ci-dessous).

## Suggestions d'abonnement

`client.suggestions` retourne les comptes que le serveur recommande de suivre — des comptes sélectionnés par l'équipe ou des comptes avec lesquels l'utilisateur a eu des interactions positives sans encore les suivre.

```dart
final suggestions = await client.suggestions.fetch(limit: 20);
for (final suggestion in suggestions) {
  print('${suggestion.account.acct} — reason: ${suggestion.source}');
}
```

Retourne `List<MastodonSuggestion>`. La limite par défaut est 40 et le maximum est 80.

Pour retirer un compte de la liste des suggestions :

```dart
await client.suggestions.remove('12345');
```

Cela réussit même si le compte ne figure pas dans les suggestions.

## Mises en avant

Les mises en avant sont des comptes que l'utilisateur a choisi de mettre en avant sur son profil. Utilisez `client.endorsements` pour les récupérer.

```dart
final page = await client.endorsements.fetch(limit: 40);
for (final account in page.items) {
  print(account.displayName);
}
```

Retourne `MastodonPage<MastodonAccount>`. La limite par défaut est 40 et le maximum est 80. Pour mettre en avant ou retirer la mise en avant d'un compte, utilisez `client.accounts.endorse` et `client.accounts.unendorse`.

## Tags vedettes

Les tags vedettes sont des hashtags affichés en évidence sur le profil d'un utilisateur. Utilisez `client.featuredTags` pour les gérer.

### Lister les tags vedettes

```dart
final tags = await client.featuredTags.fetch();
for (final tag in tags) {
  print('#${tag.name} — ${tag.statusesCount} statuses');
}
```

### Ajouter un tag vedette

```dart
final tag = await client.featuredTags.create('dart');
print(tag.id);
```

Passez le nom du tag sans le préfixe `#`.

### Retirer un tag vedette

```dart
await client.featuredTags.delete(tag.id);
```

### Suggestions de tags vedettes

Le serveur retourne jusqu'à 10 hashtags récemment utilisés comme candidats :

```dart
final suggestions = await client.featuredTags.fetchSuggestions();
```

Retourne `List<MastodonTag>`.

## Tags

`client.tags` fournit des informations sur les tags ainsi que les opérations de suivi et de mise en avant.

### Récupérer les informations d'un tag

```dart
final tag = await client.tags.fetch('dart');
print(tag.name);
print(tag.following); // null if unauthenticated
```

La recherche par nom est insensible à la casse. Quand authentifié, le champ `following` est inclus.

### Suivre et ne plus suivre un tag

```dart
final tag = await client.tags.follow('dart');
print(tag.following); // true

final unfollowed = await client.tags.unfollow('dart');
print(unfollowed.following); // false
```

### Mettre en avant et retirer la mise en avant d'un tag (Mastodon 4.4.0+)

```dart
await client.tags.feature('dart');
await client.tags.unfeature('dart');
```

Les deux retournent `MastodonTag` reflétant l'état mis à jour.

## Favoris

`client.favourites` liste tous les statuts que l'utilisateur authentifié a mis en favoris.

```dart
final page = await client.favourites.fetch(limit: 20);
for (final status in page.items) {
  print(status.content);
}

// Older results
if (page.nextMaxId != null) {
  final older = await client.favourites.fetch(maxId: page.nextMaxId);
}
```

Retourne `MastodonPage<MastodonStatus>`. La limite par défaut est 20 et le maximum est 40. La pagination utilise `maxId`, `sinceId` et `minId`.

Pour ajouter ou retirer un statut des favoris, utilisez `client.statuses.favourite` et `client.statuses.unfavourite`.

## Signets

`client.bookmarks` liste tous les statuts que l'utilisateur authentifié a ajoutés aux signets.

```dart
final page = await client.bookmarks.fetch(limit: 20);
for (final status in page.items) {
  print(status.id);
}
```

Retourne `MastodonPage<MastodonStatus>`. La limite par défaut est 20 et le maximum est 40. La pagination utilise `maxId`, `sinceId` et `minId`.

Pour ajouter ou supprimer un signet, utilisez `client.statuses.bookmark` et `client.statuses.unbookmark`.
