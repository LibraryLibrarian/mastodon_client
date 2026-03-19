---
sidebar_position: 7
---

# Listen

Die `client.lists`-API ermöglicht das Erstellen und Verwalten von Listen, das Hinzufügen und Entfernen von Accounts sowie das Lesen von Listen-Timelines.

## Listen abrufen

### Alle Listen

```dart
final lists = await client.lists.fetch();
for (final list in lists) {
  print('${list.id}: ${list.title}');
}
```

Gibt `List<MastodonList>` mit allen Listen des authentifizierten Benutzers zurück.

### Einzelne Liste

```dart
final list = await client.lists.fetchById('42');
print(list.title);
print(list.repliesPolicy); // "followed" | "list" | "none"
print(list.exclusive);     // true if home timeline excludes list members
```

## Liste erstellen

```dart
final list = await client.lists.create(
  title: 'Developer friends',
  repliesPolicy: 'list',   // show replies between list members
  exclusive: false,
);
print(list.id);
```

`repliesPolicy` akzeptiert:
- `followed` — Antworten an Benutzer zeigen, denen der Betrachter folgt
- `list` — Antworten an andere Listenmitglieder zeigen
- `none` — Alle Antworten ausblenden

Wenn `exclusive` den Wert `true` hat, werden Beiträge von Listenmitgliedern aus der Home-Timeline ausgeschlossen.

## Liste aktualisieren

```dart
final updated = await client.lists.update(
  '42',
  title: 'Close friends',
  repliesPolicy: 'followed',
  exclusive: true,
);
```

## Liste löschen

```dart
await client.lists.delete('42');
```

## Accounts verwalten

### Accounts einer Liste abrufen

```dart
final page = await client.lists.fetchAccounts(
  '42',
  limit: 40,
);

for (final account in page.items) {
  print(account.acct);
}
```

Gibt `MastodonPage<MastodonAccount>` zurück. Verwende `nextMaxId` und `prevMinId` zur Paginierung:

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

Paginierungsparameter:

| Parameter | Beschreibung |
|-----------|-------------|
| `limit`   | Maximale Ergebnisanzahl (Standard: 40, max: 80; `0` für alle) |
| `maxId`   | Ergebnisse älter als diese ID zurückgeben |
| `sinceId` | Ergebnisse neuer als diese ID zurückgeben |
| `minId`   | Ergebnisse unmittelbar nach dieser ID zurückgeben (Vorwärts-Paginierung) |

### Accounts hinzufügen

Die Accounts müssen vom authentifizierten Benutzer gefolgt werden.

```dart
await client.lists.addAccounts(
  '42',
  accountIds: ['100', '101', '102'],
);
```

### Accounts entfernen

```dart
await client.lists.removeAccounts(
  '42',
  accountIds: ['101'],
);
```

## Das MastodonList-Modell

| Feld | Typ | Beschreibung |
|------|-----|-------------|
| `id` | `String` | Interne Listen-ID |
| `title` | `String` | Titel der Liste |
| `repliesPolicy` | `String` | Antwort-Anzeigerichtlinie (`followed` / `list` / `none`) |
| `exclusive` | `bool` | Ob Listenmitglieder aus der Home-Timeline ausgeschlossen sind |
