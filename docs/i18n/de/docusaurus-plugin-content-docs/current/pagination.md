---
sidebar_position: 3
---

# Paginierung

Die Mastodon-API verwendet Cursor-basierte Paginierung. Diese Bibliothek abstrahiert sie mit `MastodonPage<T>`.

## Struktur von MastodonPage

```dart
class MastodonPage<T> {
  final List<T> items;      // Items in the current page
  final String? nextMaxId;  // Cursor for the next page (older)
  final String? prevMinId;  // Cursor for the previous page (newer)
}
```

## Grundlegende Verwendung

### Erste Seite abrufen

```dart
final page = await client.notifications.fetch(limit: 20);

for (final notification in page.items) {
  print(notification.type);
}
```

### Nächste Seite abrufen (ältere Einträge)

`nextMaxId` als `maxId`-Parameter übergeben:

```dart
if (page.nextMaxId != null) {
  final nextPage = await client.notifications.fetch(
    limit: 20,
    maxId: page.nextMaxId,
  );
}
```

### Vorherige Seite abrufen (neuere Einträge)

`prevMinId` als `minId`-Parameter übergeben:

```dart
if (page.prevMinId != null) {
  final prevPage = await client.notifications.fetch(
    limit: 20,
    minId: page.prevMinId,
  );
}
```

## Paginierungsparameter

| Parameter | Richtung | Beschreibung |
|-----------|-----------|-------------|
| `maxId` | Älter | Ergebnisse vor dieser ID zurückgeben |
| `sinceId` | Neuer | Ergebnisse nach dieser ID zurückgeben (Lücken möglich) |
| `minId` | Neuer | Ergebnisse unmittelbar nach dieser ID zurückgeben (lückenlos) |
| `limit` | - | Maximale Anzahl von Ergebnissen (Serverstandard, wenn weggelassen) |

### Unterschied zwischen `sinceId` und `minId`

- `sinceId`: Gibt die **neuesten** `limit` Ergebnisse zurück, die neuer als die angegebene ID sind (Einträge dazwischen können übersprungen werden)
- `minId`: Gibt `limit` Ergebnisse **unmittelbar nach** der angegebenen ID zurück (lückenlose Vorwärts-Paginierung)

Verwende `sinceId` für Echtzeit-Update-Prüfungen und `minId` für die sequenzielle Durchblätterung.

## Alle Seiten durchlaufen

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
Das gleichzeitige Abrufen großer Datenmengen belastet den Server. Beachte die Rate-Limits.
:::

## APIs mit Paginierung

Die wichtigsten APIs, die paginierte Ergebnisse liefern:

- `client.notifications.fetch()` — Benachrichtigungen
- `client.accounts.fetchFollowers()` — Follower
- `client.accounts.fetchFollowing()` — Gefolgte
- `client.accounts.fetchStatuses()` — Account-Status
- `client.timelines.*` — Timelines
- `client.favourites.fetch()` — Favoriten
- `client.bookmarks.fetch()` — Lesezeichen
- `client.blocks.fetch()` — Blockierte Accounts
- `client.mutes.fetch()` — Stummgeschaltete Accounts
