---
sidebar_position: 11
---

# Moderation

Diese Seite behandelt die APIs zur Verwaltung blockierter Accounts, stummgeschalteter Accounts, Domain-Sperren und Benutzermeldungen.

Alle Listenmethoden geben `MastodonPage<T>` zurück, das die Ergebniselemente zusammen mit den Cursorn `nextMaxId` und `prevMinId` enthält, die aus dem `Link`-Antwort-Header geparst wurden. Details findest du in der [Paginierungs-Anleitung](../pagination.md).

---

## Blockierte Accounts

### Sperren auflisten

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

Parameter:

| Parameter | Standard | Max | Beschreibung |
|-----------|---------|-----|-------------|
| `limit`   | 40      | 80  | Anzahl der Ergebnisse |
| `maxId`   | —       | —   | Ergebnisse älter als diese ID zurückgeben |
| `sinceId` | —       | —   | Ergebnisse neuer als diese ID zurückgeben |
| `minId`   | —       | —   | Älteste Ergebnisse nach dieser ID zurückgeben (Rückwärts-Paginierung) |

Zum Blockieren oder Entsperren eines Accounts `client.accounts.block()` und `client.accounts.unblock()` verwenden.

---

## Stummgeschaltete Accounts

### Stummschaltungen auflisten

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

Parameter:

| Parameter | Standard | Max | Beschreibung |
|-----------|---------|-----|-------------|
| `limit`   | 40      | 80  | Anzahl der Ergebnisse |
| `maxId`   | —       | —   | Ergebnisse älter als diese ID zurückgeben |
| `sinceId` | —       | —   | Ergebnisse neuer als diese ID zurückgeben |

Zum Stummschalten oder Aufheben der Stummschaltung `client.accounts.mute()` und `client.accounts.unmute()` verwenden.

---

## Domain-Sperren

Benutzerspezifische Domain-Sperren blenden Beiträge und Benachrichtigungen einer gesamten Domain aus. Dies unterscheidet sich von instanzweiten Domain-Sperren (siehe `client.instance.fetchDomainBlocks()`).

### Gesperrte Domains auflisten

```dart
final page = await client.domainBlocks.fetch(limit: 100);
for (final domain in page.items) {
  print(domain);
}
```

Parameter:

| Parameter | Standard | Max | Beschreibung |
|-----------|---------|-----|-------------|
| `limit`   | 100     | 200 | Anzahl der Ergebnisse |
| `maxId`   | —       | —   | Ergebnisse älter als diese ID zurückgeben |
| `sinceId` | —       | —   | Ergebnisse neuer als diese ID zurückgeben |
| `minId`   | —       | —   | Älteste Ergebnisse nach dieser ID zurückgeben (Rückwärts-Paginierung) |

### Domain sperren

```dart
await client.domainBlocks.block('spam.example.com');
```

Das Sperren einer Domain blendet alle öffentlichen Beiträge und Benachrichtigungen von Accounts dieser Domain aus, entfernt vorhandene Follower von dort und verhindert neue Follows zu dortigen Accounts.

### Domain-Sperre aufheben

```dart
await client.domainBlocks.unblock('spam.example.com');
```

---

## Meldungen

### Account melden

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

### Bestimmte Status melden

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

### An Remote-Admin weiterleiten

`forward: true` setzen, um eine Kopie der Meldung an die Administratoren des Heimservers des gemeldeten Accounts zu senden.

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '67890',
    comment: 'Harassment from a remote account.',
    forward: true,
  ),
);
```

### Anfragefelder

| Feld        | Pflicht | Beschreibung |
|--------------|----------|-------------|
| `accountId`  | Ja      | ID des zu meldenden Accounts |
| `statusIds`  | Nein       | Status-IDs als Beweise |
| `comment`    | Nein       | Grund der Meldung (max. 1000 Zeichen) |
| `forward`    | Nein       | An den Remote-Server-Administrator weiterleiten |
| `category`   | Nein       | `spam`, `legal`, `violation` oder `other` |
| `ruleIds`    | Nein       | IDs verletzter Regeln (bei Kategorie `violation`) |
