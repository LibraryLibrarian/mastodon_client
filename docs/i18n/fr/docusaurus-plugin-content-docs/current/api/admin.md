---
sidebar_position: 14
---

# Administration

Les APIs d'administration offrent des capacités de gestion du serveur. Tous les endpoints nécessitent des scopes OAuth élevés (typiquement `admin:read:*` ou `admin:write:*`). Utilisez ces APIs uniquement avec des comptes disposant des permissions appropriées côté serveur.

## Comptes

`client.adminAccounts` expose la gestion complète des comptes pour les administrateurs.

### Lister les comptes

Deux versions de l'endpoint de liste sont disponibles.

**v1** — indicateurs de filtre booléens :

```dart
final page = await client.adminAccounts.fetch(
  pending: true,   // only accounts awaiting approval
  limit: 100,
);
for (final account in page.items) {
  print('${account.account?.acct} — ${account.email}');
}
```

Filtres disponibles : `local`, `remote`, `active`, `pending`, `disabled`, `silenced`, `suspended`, `sensitized`, `staff`. Paramètres de recherche : `username`, `displayName`, `email`, `ip`, `byDomain`. Pagination : `maxId`, `sinceId`, `minId`. Limite par défaut 100, maximum 200.

**v2** — paramètres de filtre structurés (recommandé pour le nouveau code) :

```dart
final page = await client.adminAccounts.fetchV2(
  origin: 'local',
  status: 'pending',
  limit: 50,
);
```

`origin` vaut `local` ou `remote`. `status` est l'un des suivants : `active`, `pending`, `disabled`, `silenced` ou `suspended`. Passez `staff` comme `permissions` pour restreindre aux comptes staff. `roleIds` filtre par IDs de rôle assignés, et `invitedBy` filtre par ID du compte ayant envoyé l'invitation.

### Récupérer un compte unique

```dart
final account = await client.adminAccounts.fetchById('12345');
print(account.ip);
print(account.confirmed);
```

### Approuver et rejeter les comptes en attente

```dart
await client.adminAccounts.approve('12345');
await client.adminAccounts.reject('12345');
```

### Effectuer des actions de modération

```dart
await client.adminAccounts.performAction(
  '12345',
  MastodonAdminAccountActionRequest(
    type: 'suspend',
    reportId: '999',
    text: 'Violated community guidelines.',
    sendEmailNotification: true,
  ),
);
```

Les signalements non résolus associés sont automatiquement résolus. Requiert les permissions "Gérer les utilisateurs" et "Gérer les signalements".

### Autres méthodes de modération

```dart
await client.adminAccounts.enable('12345');       // re-enable a disabled account
await client.adminAccounts.unsilence('12345');    // remove silence
await client.adminAccounts.unsuspend('12345');    // lift suspension
await client.adminAccounts.unsensitive('12345'); // remove sensitive flag
```

### Supprimer les données d'un compte

```dart
await client.adminAccounts.delete('12345');
```

Supprime définitivement les données d'un compte suspendu. Requiert la permission "Supprimer les données utilisateur".

## Signalements

`client.adminReports` gère les signalements d'abus soumis par les utilisateurs.

### Lister les signalements

```dart
final page = await client.adminReports.fetch(
  resolved: false,  // unresolved reports only
  limit: 100,
);
```

Filtrez par `accountId` (auteur du signalement) ou `targetAccountId` (compte signalé). Utilisez `resolved: true` pour n'afficher que les signalements résolus. Pagination via `maxId`, `sinceId`, `minId`.

### Récupérer et mettre à jour un signalement

```dart
final report = await client.adminReports.fetchById('42');

final updated = await client.adminReports.update(
  '42',
  MastodonAdminReportUpdateRequest(assignedAccountId: 'moderator-id'),
);
```

### Assignation et résolution

```dart
await client.adminReports.assignToSelf('42');
await client.adminReports.unassign('42');
await client.adminReports.resolve('42');
await client.adminReports.reopen('42'); // re-open a resolved report
```

## Gestion des domaines

### Liste d'autorisation de domaines

Pour les serveurs fonctionnant en mode liste d'autorisation, `client.adminDomainAllows` contrôle quels domaines distants sont autorisés à fédérer.

```dart
// List allowed domains
final page = await client.adminDomainAllows.fetch();

// Allow a domain
final entry = await client.adminDomainAllows.create(domain: 'example.social');

// Remove an allowed domain
await client.adminDomainAllows.delete(entry.id);
```

### Liste de blocage de domaines

`client.adminDomainBlocks` gère les blocages de fédération contre les domaines distants.

```dart
// List blocked domains
final page = await client.adminDomainBlocks.fetch();

// Block a domain
final block = await client.adminDomainBlocks.create(
  MastodonAdminDomainBlockRequest(
    domain: 'spam.example',
    severity: 'suspend',
    rejectMedia: true,
    rejectReports: true,
    privateComment: 'Known spam instance',
    publicComment: 'Suspended for spam.',
  ),
);

// Update a block
await client.adminDomainBlocks.update(block.id, updatedRequest);

// Delete a block
await client.adminDomainBlocks.delete(block.id);
```

## Blocages d'adresses IP

`client.adminIpBlocks` gère les blocages de plages d'adresses IP.

```dart
// List IP blocks
final page = await client.adminIpBlocks.fetch();

// Create an IP block
final block = await client.adminIpBlocks.create(
  MastodonAdminIpBlockCreateRequest(
    ip: '192.0.2.0/24',
    severity: 'no_access',
    comment: 'Abusive subnet',
  ),
);

// Update
await client.adminIpBlocks.update(
  block.id,
  MastodonAdminIpBlockUpdateRequest(severity: 'sign_up_block'),
);

// Delete
await client.adminIpBlocks.delete(block.id);
```

## Blocages d'e-mails

### Blocages d'e-mails canoniques

`client.adminCanonicalEmailBlocks` bloque les adresses e-mail normalisées (canoniques). Cela empêche les utilisateurs de se réinscrire avec des variantes d'une adresse e-mail bloquée.

```dart
// List blocks
final page = await client.adminCanonicalEmailBlocks.fetch();

// Test whether an email matches any existing block
final matches = await client.adminCanonicalEmailBlocks.test(
  email: 'test@example.com',
);

// Block by email address (canonical hash is computed server-side)
final block = await client.adminCanonicalEmailBlocks.create(
  email: 'spammer@example.com',
);

// Or block by pre-computed hash
await client.adminCanonicalEmailBlocks.create(
  canonicalEmailHash: 'sha256hashvalue',
);

// Delete
await client.adminCanonicalEmailBlocks.delete(block.id);
```

### Blocages de domaines e-mail

`client.adminEmailDomainBlocks` empêche les inscriptions depuis des domaines e-mail entiers.

```dart
// List blocked email domains
final page = await client.adminEmailDomainBlocks.fetch();

// Block a domain
final block = await client.adminEmailDomainBlocks.create(
  domain: 'disposable-mail.example',
);

// Delete
await client.adminEmailDomainBlocks.delete(block.id);
```

## Tags d'administration

`client.adminTags` fournit un contrôle administratif sur les hashtags.

### Lister et récupérer des tags

```dart
final page = await client.adminTags.fetch(limit: 50);
final tag = await client.adminTags.fetchById('tag-id');
```

### Mettre à jour un tag

```dart
final updated = await client.adminTags.update(
  'tag-id',
  displayName: 'Dart',
  listable: true,
  trendable: true,
  usable: true,
);
```

Tous les champs sont optionnels ; seules les valeurs fournies sont modifiées. `listable` contrôle si le tag apparaît dans les listes publiques, `trendable` s'il est éligible à l'endpoint des tendances, et `usable` s'il peut être utilisé dans les publications.

## Tendances d'administration

`client.adminTrends` donne accès aux contenus tendance non encore examinés et permet d'approuver ou rejeter des éléments avant qu'ils apparaissent publiquement.

### Liens tendance

```dart
final links = await client.adminTrends.fetchLinks();
await client.adminTrends.approveLink(id: links.first.id);
await client.adminTrends.rejectLink(id: links.first.id);
```

### Éditeurs de liens

```dart
final publishers = await client.adminTrends.fetchPublishers();
await client.adminTrends.approvePublisher(id: publishers.first.id);
await client.adminTrends.rejectPublisher(id: publishers.first.id);
```

### Statuts tendance

```dart
final statuses = await client.adminTrends.fetchStatuses();
await client.adminTrends.approveStatus(id: statuses.first.id);
await client.adminTrends.rejectStatus(id: statuses.first.id);
```

### Tags tendance

```dart
final tags = await client.adminTrends.fetchTags();
await client.adminTrends.approveTag(id: tags.first.id);
await client.adminTrends.rejectTag(id: tags.first.id);
```

Les endpoints de lecture nécessitent le scope `admin:read` ; les endpoints d'écriture nécessitent `admin:write`.

## Mesures, dimensions et rétention

Ces endpoints d'analytique utilisent tous `POST` avec un corps de requête spécifiant les métriques et la plage de dates à interroger.

### Mesures (données quantitatives)

```dart
final measures = await client.adminMeasures.fetch(
  MastodonAdminMeasureRequest(
    keys: ['active_users', 'new_users'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
for (final m in measures) {
  print('${m.key}: ${m.total}');
}
```

Retourne des données de série temporelle telles que les utilisateurs actifs, les nouvelles inscriptions et les compteurs d'interactions.

### Dimensions (données qualitatives)

```dart
final dimensions = await client.adminDimensions.fetch(
  MastodonAdminDimensionRequest(
    keys: ['languages', 'sources'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
```

Retourne des répartitions catégorielles telles que la distribution des langues ou les versions des logiciels clients.

### Rétention (données de cohorte)

```dart
final cohorts = await client.adminRetention.fetch(
  MastodonAdminRetentionRequest(
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 3, 31),
    frequency: 'month',
  ),
);
```

Retourne les données de rétention des cohortes d'utilisateurs regroupées par période d'inscription et activité ultérieure. Ces trois endpoints d'analytique nécessitent le scope OAuth `admin:read`.
