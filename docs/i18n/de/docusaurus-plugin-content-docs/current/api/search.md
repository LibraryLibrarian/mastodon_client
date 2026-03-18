---
sidebar_position: 5
---

# Suche

Die `client.search`-API durchsucht Accounts, Status und Hashtags in einer einzigen Anfrage.

## Grundlegende Suche

```dart
final result = await client.search.search('mastodon');

print('Accounts: ${result.accounts.length}');
print('Statuses: ${result.statuses.length}');
print('Hashtags: ${result.hashtags.length}');
```

Das Ergebnis ist ein `MastodonSearchResult` mit drei Listen:

- `accounts` — `List<MastodonAccount>`
- `statuses` — `List<MastodonStatus>`
- `hashtags` — `List<MastodonTag>`

## Nach Typ filtern

Ein `type` angeben, um Ergebnisse auf eine Kategorie zu beschränken. Akzeptierte Werte sind `'accounts'`, `'statuses'` und `'hashtags'`.

```dart
// Accounts only
final result = await client.search.search('alice', type: 'accounts');

// Statuses only
final result = await client.search.search('hello world', type: 'statuses');

// Hashtags only
final result = await client.search.search('dart', type: 'hashtags');
```

## Remote-Accounts auflösen

`resolve: true` setzen, um einen Remote-Account über WebFinger zu suchen, wenn kein lokales Ergebnis gefunden wird. Dies erfordert einen Benutzer-Token.

```dart
final result = await client.search.search(
  'alice@example.social',
  resolve: true,
);
```

## Auf gefolgten Accounts einschränken

`following: true` setzen, um nur Accounts zurückzugeben, denen gefolgt wird. Dies erfordert einen Benutzer-Token.

```dart
final result = await client.search.search(
  'alice',
  type: 'accounts',
  following: true,
);
```

## Status auf einen bestimmten Account einschränken

`accountId` schränkt Status-Ergebnisse auf Beiträge eines einzelnen Accounts ein.

```dart
final result = await client.search.search(
  'hello',
  type: 'statuses',
  accountId: '109876543210',
);
```

## Nicht überprüfte Hashtags ausschließen

`excludeUnreviewed: true` setzen, um Hashtags auszublenden, die nicht von Moderatoren überprüft wurden (ab Mastodon 3.0.0).

```dart
final result = await client.search.search(
  'dart',
  type: 'hashtags',
  excludeUnreviewed: true,
);
```

## Paginierung

Die Such-API unterstützt Offset-basierte Paginierung, wenn `type` angegeben ist, sowie Cursor-basierte Paginierung mit `minId` / `maxId`.

### Offset-basierte Paginierung

`offset` überspringt Ergebnisse vom Anfang. Zusammen mit `limit` und einem festen `type` verwenden. Erfordert einen Benutzer-Token.

```dart
final page1 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 0,
);

final page2 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 20,
);
```

### Cursor-basierte Paginierung

`maxId` und `minId` für Cursor-basierte Navigation ähnlich wie bei Timeline-Endpunkten verwenden.

```dart
final result = await client.search.search(
  'mastodon',
  type: 'statuses',
  maxId: '109876543210',
);
```

Das Standard-`limit` ist 20 pro Kategorie; das Maximum ist 40.

## Veraltet: v1-Suche

`searchV1()` wurde in Mastodon 3.0.0 entfernt. Es wird nur für die Kompatibilität mit Instanzen bereitgestellt, die noch 2.x betreiben. Für alle neuen Integrationen `search()` verwenden.

Wesentliche Unterschiede zu v2:

- `hashtags` gibt `List<String>` (einfache Namen) statt `List<MastodonTag>` zurück
- Die Parameter `following` und `excludeUnreviewed` sind nicht verfügbar
