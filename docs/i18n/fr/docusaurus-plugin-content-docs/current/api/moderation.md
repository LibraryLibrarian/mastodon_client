---
sidebar_position: 11
---

# Modération

Cette page couvre les APIs pour gérer les comptes bloqués, les comptes masqués, les blocages de domaines et les signalements d'utilisateurs.

Toutes les méthodes de liste retournent `MastodonPage<T>`, qui contient les éléments de résultat ainsi que les curseurs `nextMaxId` et `prevMinId` extraits de l'en-tête de réponse `Link`. Consultez le guide [Pagination](../pagination.md) pour plus de détails.

---

## Comptes bloqués

### Lister les blocages

```dart
final page = await client.blocks.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// Next page
if (page.nextMaxId != null) {
  final next = await client.blocks.fetch(maxId: page.nextMaxId);
}
```

Paramètres :

| Paramètre | Défaut | Max | Description |
|-----------|--------|-----|-------------|
| `limit`   | 40     | 80  | Nombre de résultats |
| `maxId`   | —      | —   | Retourner les résultats plus anciens que cet ID |
| `sinceId` | —      | —   | Retourner les résultats plus récents que cet ID |
| `minId`   | —      | —   | Retourner les résultats les plus anciens après cet ID (pagination inverse) |

Pour bloquer ou débloquer un compte, utilisez `client.accounts.block()` et `client.accounts.unblock()`.

---

## Comptes masqués

### Lister les masquages

```dart
final page = await client.mutes.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// Next page
if (page.nextMaxId != null) {
  final next = await client.mutes.fetch(maxId: page.nextMaxId);
}
```

Paramètres :

| Paramètre | Défaut | Max | Description |
|-----------|--------|-----|-------------|
| `limit`   | 40     | 80  | Nombre de résultats |
| `maxId`   | —      | —   | Retourner les résultats plus anciens que cet ID |
| `sinceId` | —      | —   | Retourner les résultats plus récents que cet ID |

Pour masquer ou démasquer un compte, utilisez `client.accounts.mute()` et `client.accounts.unmute()`.

---

## Blocages de domaines

Les blocages de domaines au niveau utilisateur masquent les publications et notifications d'un domaine entier. Cela est distinct des blocages de domaines au niveau de l'instance (voir `client.instance.fetchDomainBlocks()`).

### Lister les domaines bloqués

```dart
final page = await client.domainBlocks.fetch(limit: 100);
for (final domain in page.items) {
  print(domain);
}
```

Paramètres :

| Paramètre | Défaut | Max | Description |
|-----------|--------|-----|-------------|
| `limit`   | 100    | 200 | Nombre de résultats |
| `maxId`   | —      | —   | Retourner les résultats plus anciens que cet ID |
| `sinceId` | —      | —   | Retourner les résultats plus récents que cet ID |
| `minId`   | —      | —   | Retourner les résultats les plus anciens après cet ID (pagination inverse) |

### Bloquer un domaine

```dart
await client.domainBlocks.block('spam.example.com');
```

Bloquer un domaine masque toutes les publications publiques et notifications des comptes de ce domaine, supprime les abonnés existants de ce domaine, et empêche de nouveaux abonnements vers des comptes de ce domaine.

### Débloquer un domaine

```dart
await client.domainBlocks.unblock('spam.example.com');
```

---

## Signalements

### Signaler un compte

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    comment: 'This account is posting spam.',
    category: 'spam',
  ),
);
print(report.id);
```

### Signaler des statuts spécifiques

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    statusIds: ['111', '222'],
    comment: 'These posts violate the rules.',
    category: 'violation',
    ruleIds: ['1', '3'],
  ),
);
```

### Transférer à un administrateur distant

Définissez `forward: true` pour envoyer une copie du signalement aux administrateurs du serveur d'accueil du compte signalé.

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '67890',
    comment: 'Harassment from a remote account.',
    forward: true,
  ),
);
```

### Champs de la requête

| Champ | Obligatoire | Description |
|-------|-------------|-------------|
| `accountId` | Oui | ID du compte à signaler |
| `statusIds` | Non | IDs de statuts à joindre comme preuves |
| `comment` | Non | Motif du signalement (max 1000 caractères) |
| `forward` | Non | Transférer à l'administrateur du serveur distant |
| `category` | Non | `spam`, `legal`, `violation` ou `other` |
| `ruleIds` | Non | IDs des règles enfreintes (utilisé avec la catégorie `violation`) |
