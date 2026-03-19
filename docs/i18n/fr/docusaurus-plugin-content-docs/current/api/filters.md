---
sidebar_position: 6
---

# Filtres

L'API `client.filters` gère les filtres de contenu côté serveur (Mastodon 4.0+). Les filtres masquent ou avertissent sur les statuts correspondant aux mots-clés spécifiés ou à des IDs de statut individuels.

## Récupérer les filtres

### Tous les filtres

```dart
final filters = await client.filters.fetch();

for (final filter in filters) {
  print('${filter.title}: ${filter.filterAction}');
}
```

### Filtre unique

```dart
final filter = await client.filters.fetchById('1');
print(filter.title);
```

## Créer un filtre

`title` et `context` sont obligatoires. `context` est une liste d'un ou plusieurs contextes de placement où le filtre s'applique :

| Valeur | Où le filtre est appliqué |
|--------|--------------------------|
| `home` | Fil personnel et listes |
| `notifications` | Fil des notifications |
| `public` | Fils publics |
| `thread` | Dans un fil de conversation |
| `account` | Lors de la consultation d'un profil |

```dart
final filter = await client.filters.create(
  title: 'Hide spoilers',
  context: ['home', 'public'],
  filterAction: 'warn',
  expiresIn: 86400, // 1 day; omit for no expiration
);
```

`filterAction` accepte `'warn'` (afficher un avertissement), `'hide'` (supprimer le statut entièrement), ou `'blur'`. Si omis, la valeur par défaut du serveur s'applique.

### Créer avec des mots-clés

Fournissez `keywordsAttributes` pour ajouter des mots-clés lors de la création.

```dart
final filter = await client.filters.create(
  title: 'Election noise',
  context: ['home', 'notifications', 'public'],
  filterAction: 'warn',
  keywordsAttributes: [
    MastodonFilterKeywordParam(keyword: 'election', wholeWord: true),
    MastodonFilterKeywordParam(keyword: 'vote'),
  ],
);
```

## Mettre à jour un filtre

Tous les paramètres sont optionnels ; seuls les champs fournis sont mis à jour.

```dart
final updated = await client.filters.update(
  '1',
  title: 'Updated title',
  filterAction: 'hide',
);
```

## Supprimer un filtre

```dart
await client.filters.delete('1');
```

## Mots-clés de filtre

Les mots-clés sont les expressions qu'un filtre fait correspondre. Chaque mot-clé appartient à un filtre.

### Lister les mots-clés

```dart
final keywords = await client.filters.fetchKeywords('1');

for (final kw in keywords) {
  print('${kw.keyword} (whole word: ${kw.wholeWord})');
}
```

### Ajouter un mot-clé

```dart
final keyword = await client.filters.createKeyword(
  '1', // filter ID
  keyword: 'spoiler',
  wholeWord: true,
);
```

### Récupérer un mot-clé unique

```dart
final keyword = await client.filters.fetchKeywordById('42');
```

### Mettre à jour un mot-clé

```dart
final updated = await client.filters.updateKeyword(
  '42',
  keyword: 'spoilers',
  wholeWord: false,
);
```

### Supprimer un mot-clé

```dart
await client.filters.deleteKeyword('42');
```

### Mise à jour groupée de mots-clés avec une mise à jour de filtre

Passez `keywordsAttributes` à `update()` pour ajouter, modifier ou supprimer plusieurs mots-clés en une seule requête. Définissez `destroy: true` sur une entrée pour la supprimer.

```dart
await client.filters.update(
  '1',
  keywordsAttributes: [
    MastodonFilterKeywordUpdateParam(keyword: 'newword'),           // add
    MastodonFilterKeywordUpdateParam(id: '10', keyword: 'changed'), // update
    MastodonFilterKeywordUpdateParam(id: '11', keyword: '', destroy: true), // delete
  ],
);
```

## Statuts filtrés

En plus de la correspondance par mots-clés, vous pouvez ajouter des statuts spécifiques à un filtre pour qu'ils soient toujours masqués.

### Lister les statuts filtrés

```dart
final statuses = await client.filters.fetchStatuses('1');
```

### Ajouter un statut à un filtre

```dart
final filterStatus = await client.filters.createStatus(
  '1', // filter ID
  statusId: '109876543210',
);
```

### Récupérer une entrée de statut filtré

```dart
final filterStatus = await client.filters.fetchStatusById('99');
```

### Retirer un statut d'un filtre

```dart
await client.filters.deleteStatus('99');
```

## Déprécié : filtres v1

L'API de filtres v1 a été dépréciée dans Mastodon 4.0.0. Elle n'est fournie que pour la compatibilité avec les instances plus anciennes.

| Méthode v1 | Équivalent v2 |
|------------|---------------|
| `fetchV1()` | `fetch()` |
| `fetchByIdV1(id)` | `fetchById(id)` |
| `createV1(phrase:, context:)` | `create(title:, context:)` |
| `updateV1(id, phrase:, context:)` | `update(id)` |
| `deleteV1(id)` | `delete(id)` |

Différences notables par rapport à v2 :

- v1 utilise une chaîne `phrase` unique au lieu d'une liste de mots-clés.
- `irreversible: true` supprime définitivement les publications correspondantes du fil personnel et des notifications sans aucun avertissement côté client.
- `deleteV1()` supprime uniquement l'enregistrement `FilterKeyword`, pas le filtre parent.
- Les filtres v1 sont uniquement côté client ; le serveur ne les applique pas.
