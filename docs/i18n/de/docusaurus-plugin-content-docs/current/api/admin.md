---
sidebar_position: 14
---

# Admin

Die Admin-APIs stellen Serververwaltungsfunktionen bereit. Alle Endpunkte erfordern erhöhte OAuth-Scopes (in der Regel `admin:read:*` oder `admin:write:*`). Verwende diese APIs ausschließlich mit Accounts, die über die entsprechenden serverseitigen Berechtigungen verfügen.

## Accounts

`client.adminAccounts` bietet vollständige Account-Verwaltung für Administratoren.

### Accounts auflisten

Es stehen zwei Versionen des Listenendpunkts zur Verfügung.

**v1** — boolesche Filterflags:

```dart
final page = await client.adminAccounts.fetch(
  pending: true,   // only accounts awaiting approval
  limit: 100,
);
for (final account in page.items) {
  print('${account.account?.acct} — ${account.email}');
}
```

Verfügbare Filter: `local`, `remote`, `active`, `pending`, `disabled`, `silenced`, `suspended`, `sensitized`, `staff`. Suchparameter: `username`, `displayName`, `email`, `ip`, `byDomain`. Paginierung: `maxId`, `sinceId`, `minId`. Standardlimit 100, Maximum 200.

**v2** — strukturierte Filterparameter (bevorzugt für neuen Code):

```dart
final page = await client.adminAccounts.fetchV2(
  origin: 'local',
  status: 'pending',
  limit: 50,
);
```

`origin` ist `local` oder `remote`. `status` ist einer der Werte `active`, `pending`, `disabled`, `silenced` oder `suspended`. `staff` als `permissions` übergeben, um nur Staff-Accounts anzuzeigen. `roleIds` filtert nach zugewiesenen Rollen-IDs, `invitedBy` filtert nach der Account-ID des Einladenden.

### Einzelnen Account abrufen

```dart
final account = await client.adminAccounts.fetchById('12345');
print(account.ip);
print(account.confirmed);
```

### Ausstehende Accounts genehmigen und ablehnen

```dart
await client.adminAccounts.approve('12345');
await client.adminAccounts.reject('12345');
```

### Moderationsmaßnahmen durchführen

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

Zusammenhängende ungelöste Meldungen werden automatisch geschlossen. Erfordert die Berechtigungen „Benutzer verwalten" und „Meldungen verwalten".

### Weitere Moderationsmethoden

```dart
await client.adminAccounts.enable('12345');       // re-enable a disabled account
await client.adminAccounts.unsilence('12345');    // remove silence
await client.adminAccounts.unsuspend('12345');    // lift suspension
await client.adminAccounts.unsensitive('12345'); // remove sensitive flag
```

### Account-Daten löschen

```dart
await client.adminAccounts.delete('12345');
```

Löscht dauerhaft die Daten eines gesperrten Accounts. Erfordert die Berechtigung „Benutzerdaten löschen".

## Meldungen

`client.adminReports` verwaltet von Benutzern eingereichte Missbrauchsmeldungen.

### Meldungen auflisten

```dart
final page = await client.adminReports.fetch(
  resolved: false,  // unresolved reports only
  limit: 100,
);
```

Nach `accountId` (Meldender) oder `targetAccountId` (gemeldeter Account) filtern. Mit `resolved: true` werden nur erledigte Meldungen angezeigt. Paginierung über `maxId`, `sinceId`, `minId`.

### Meldung abrufen und aktualisieren

```dart
final report = await client.adminReports.fetchById('42');

final updated = await client.adminReports.update(
  '42',
  MastodonAdminReportUpdateRequest(assignedAccountId: 'moderator-id'),
);
```

### Zuweisung und Erledigung

```dart
await client.adminReports.assignToSelf('42');
await client.adminReports.unassign('42');
await client.adminReports.resolve('42');
await client.adminReports.reopen('42'); // re-open a resolved report
```

## Domain-Verwaltung

### Domain-Positivliste

Für Server im Positivlisten-Modus steuert `client.adminDomainAllows`, welchen Remote-Domains die Föderierung erlaubt ist.

```dart
// List allowed domains
final page = await client.adminDomainAllows.fetch();

// Allow a domain
final entry = await client.adminDomainAllows.create(domain: 'example.social');

// Remove an allowed domain
await client.adminDomainAllows.delete(entry.id);
```

### Domain-Sperrliste

`client.adminDomainBlocks` verwaltet Föderations-Sperren für Remote-Domains.

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

## IP-Sperren

`client.adminIpBlocks` verwaltet Sperren für IP-Adressbereiche.

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

## E-Mail-Sperren

### Kanonische E-Mail-Sperren

`client.adminCanonicalEmailBlocks` sperrt normalisierte (kanonische) E-Mail-Adressen. Dadurch wird verhindert, dass Benutzer sich mit Adress-Varianten einer gesperrten E-Mail-Adresse erneut registrieren.

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

### E-Mail-Domain-Sperren

`client.adminEmailDomainBlocks` verhindert Registrierungen von ganzen E-Mail-Domains.

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

## Admin-Tags

`client.adminTags` bietet Administratoren Kontrolle über Hashtags.

### Tags auflisten und abrufen

```dart
final page = await client.adminTags.fetch(limit: 50);
final tag = await client.adminTags.fetchById('tag-id');
```

### Tag aktualisieren

```dart
final updated = await client.adminTags.update(
  'tag-id',
  displayName: 'Dart',
  listable: true,
  trendable: true,
  usable: true,
);
```

Alle Felder sind optional; nur angegebene Werte werden geändert. `listable` steuert, ob der Tag in öffentlichen Auflistungen erscheint, `trendable` ob er für den Trends-Endpunkt in Frage kommt, und `usable` ob er in Beiträgen verwendet werden darf.

## Admin-Trends

`client.adminTrends` ermöglicht den Zugriff auf nicht überprüfte Trend-Inhalte und das Genehmigen oder Ablehnen von Elementen, bevor sie öffentlich erscheinen.

### Trending Links

```dart
final links = await client.adminTrends.fetchLinks();
await client.adminTrends.approveLink(id: links.first.id);
await client.adminTrends.rejectLink(id: links.first.id);
```

### Link-Publisher

```dart
final publishers = await client.adminTrends.fetchPublishers();
await client.adminTrends.approvePublisher(id: publishers.first.id);
await client.adminTrends.rejectPublisher(id: publishers.first.id);
```

### Trending Status

```dart
final statuses = await client.adminTrends.fetchStatuses();
await client.adminTrends.approveStatus(id: statuses.first.id);
await client.adminTrends.rejectStatus(id: statuses.first.id);
```

### Trending Tags

```dart
final tags = await client.adminTrends.fetchTags();
await client.adminTrends.approveTag(id: tags.first.id);
await client.adminTrends.rejectTag(id: tags.first.id);
```

Leseendpunkte erfordern den `admin:read`-Scope; Schreibendpunkte erfordern `admin:write`.

## Kennzahlen, Dimensionen und Retention

Diese Analyse-Endpunkte verwenden alle `POST` mit einem Anfrage-Body, der die abzufragenden Metriken und den Datumsbereich angibt.

### Kennzahlen (quantitative Daten)

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

Gibt Zeitreihendaten zurück, z. B. aktive Benutzer, Neuregistrierungen und Interaktionszähler.

### Dimensionen (qualitative Daten)

```dart
final dimensions = await client.adminDimensions.fetch(
  MastodonAdminDimensionRequest(
    keys: ['languages', 'sources'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
```

Gibt kategorische Aufschlüsselungen zurück, z. B. Sprachverteilung oder Client-Software-Versionen.

### Retention (Kohortendaten)

```dart
final cohorts = await client.adminRetention.fetch(
  MastodonAdminRetentionRequest(
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 3, 31),
    frequency: 'month',
  ),
);
```

Gibt Benutzer-Retention-Kohortendaten zurück, gruppiert nach Anmeldezeitraum und nachfolgender Aktivität. Alle drei Analyse-Endpunkte erfordern den OAuth-Scope `admin:read`.
