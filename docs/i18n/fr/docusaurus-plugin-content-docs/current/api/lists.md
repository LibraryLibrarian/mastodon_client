---
sidebar_position: 7
---

# Listes

L'API `client.lists` vous permet de créer et gérer des listes, d'ajouter ou retirer des comptes, et de lire les fils de listes.

## Récupérer les listes

### Toutes les listes

```dart
final lists = await client.lists.fetch();
for (final list in lists) {
  print('${list.id}: ${list.title}');
}
```

Retourne `List<MastodonList>` contenant toutes les listes appartenant à l'utilisateur authentifié.

### Liste unique

```dart
final list = await client.lists.fetchById('42');
print(list.title);
print(list.repliesPolicy); // "followed" | "list" | "none"
print(list.exclusive);     // true if home timeline excludes list members
```

## Créer une liste

```dart
final list = await client.lists.create(
  title: 'Developer friends',
  repliesPolicy: 'list',   // show replies between list members
  exclusive: false,
);
print(list.id);
```

`repliesPolicy` accepte :
- `followed` — afficher les réponses aux utilisateurs que l'utilisateur suit
- `list` — afficher les réponses aux autres membres de la liste
- `none` — masquer toutes les réponses

Quand `exclusive` vaut `true`, les publications des membres de la liste sont exclues du fil personnel.

## Mettre à jour une liste

```dart
final updated = await client.lists.update(
  '42',
  title: 'Close friends',
  repliesPolicy: 'followed',
  exclusive: true,
);
```

## Supprimer une liste

```dart
await client.lists.delete('42');
```

## Gérer les comptes

### Récupérer les comptes d'une liste

```dart
final page = await client.lists.fetchAccounts(
  '42',
  limit: 40,
);

for (final account in page.items) {
  print(account.acct);
}
```

Retourne `MastodonPage<MastodonAccount>`. Utilisez `nextMaxId` et `prevMinId` pour la pagination :

```dart
MastodonPage<MastodonAccount>? page = await client.lists.fetchAccounts('42');

while (page != null && page.nextMaxId != null) {
  page = await client.lists.fetchAccounts(
    '42',
    maxId: page.nextMaxId,
  );
  for (final account in page.items) {
    print(account.acct);
  }
}
```

Paramètres de pagination :

| Paramètre | Description |
|-----------|-------------|
| `limit`   | Nombre maximum de résultats (défaut : 40, max : 80 ; passez `0` pour tous) |
| `maxId`   | Retourner les résultats plus anciens que cet ID |
| `sinceId` | Retourner les résultats plus récents que cet ID |
| `minId`   | Retourner les résultats immédiatement après cet ID (pagination en avant) |

### Ajouter des comptes

Les comptes doivent être suivis par l'utilisateur authentifié.

```dart
await client.lists.addAccounts(
  '42',
  accountIds: ['100', '101', '102'],
);
```

### Retirer des comptes

```dart
await client.lists.removeAccounts(
  '42',
  accountIds: ['101'],
);
```

## Le modèle MastodonList

| Champ | Type | Description |
|-------|------|-------------|
| `id` | `String` | ID interne de la liste |
| `title` | `String` | Titre de la liste |
| `repliesPolicy` | `String` | Politique d'affichage des réponses (`followed` / `list` / `none`) |
| `exclusive` | `bool` | Indique si les membres de la liste sont exclus du fil personnel |
