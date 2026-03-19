---
sidebar_position: 4
---

# Timelines

Die `client.timelines`-API ruft Status-Ströme aus verschiedenen Quellen ab. Alle Methoden geben `MastodonPage<MastodonStatus>` zurück und unterstützen Cursor-basierte Paginierung.

## Home-Timeline

Die Home-Timeline enthält Status von Accounts, denen gefolgt wird.

```dart
final page = await client.timelines.fetchHome(limit: 20);

for (final status in page.items) {
  print('${status.account.acct}: ${status.content}');
}
```

## Öffentliche Timelines

### Lokale Timeline

Status von Accounts derselben Instanz.

```dart
final page = await client.timelines.fetchLocal(limit: 20);
```

`onlyMedia: true` übergeben, um Ergebnisse auf Status mit Medienanhängen zu beschränken.

```dart
final page = await client.timelines.fetchLocal(onlyMedia: true);
```

### Föderierte Timeline

Alle öffentlichen Status, die die Instanz aus dem gesamten Netzwerk erhalten hat.

```dart
final page = await client.timelines.fetchFederated(limit: 20);
```

Optionale Parameter:

- `onlyMedia` — Nur Status mit Medienanhängen einbeziehen
- `remoteOnly` — Status von lokalen Accounts ausschließen

```dart
final page = await client.timelines.fetchFederated(
  remoteOnly: true,
  onlyMedia: true,
);
```

## Hashtag-Timeline

Status, die den angegebenen Hashtag enthalten. Tag ohne das `#`-Präfix übergeben.

```dart
final page = await client.timelines.fetchHashtag('mastodon', limit: 20);
```

Zusätzliche Tag-Filter ermöglichen das Erweitern oder Einschränken der Ergebnisse:

- `any` — Auch Status mit einem dieser zusätzlichen Tags einbeziehen
- `all` — Alle diese zusätzlichen Tags müssen vorhanden sein
- `none` — Status ausschließen, die einen dieser Tags enthalten

```dart
final page = await client.timelines.fetchHashtag(
  'dart',
  any: ['flutter'],
  none: ['spam'],
);
```

Der Bereich kann mit `localOnly` oder `remoteOnly` eingeschränkt werden.

## Listen-Timeline

Status von Accounts einer bestimmten Liste. Die ID der Liste ist erforderlich.

```dart
final page = await client.timelines.fetchList('42', limit: 20);
```

## Link-Timeline

Status zu einer bestimmten URL (erfordert Server-Unterstützung).

```dart
final page = await client.timelines.fetchLink(
  'https://example.com/article',
  limit: 20,
);
```

## Paginierung

Alle Timeline-Methoden geben `MastodonPage<MastodonStatus>` zurück, das Cursor für die Navigation zu älteren und neueren Seiten enthält.

### Nächste Seite abrufen (ältere Status)

```dart
var page = await client.timelines.fetchHome(limit: 20);

while (page.nextMaxId != null) {
  page = await client.timelines.fetchHome(
    limit: 20,
    maxId: page.nextMaxId,
  );
  for (final status in page.items) {
    print(status.content);
  }
}
```

### Neue Status abfragen

`sinceId` verwenden, um Status abzurufen, die neuer als die letzte bekannte ID sind.

```dart
String? latestId = page.items.firstOrNull?.id;

final newPage = await client.timelines.fetchHome(
  sinceId: latestId,
);
```

### Vorwärts-Paginierung mit `minId`

`minId` gibt Ergebnisse zurück, die unmittelbar nach der angegebenen ID beginnen, ohne Lücken. Das eignet sich gut für die sequenzielle Durchblätterung.

```dart
final nextPage = await client.timelines.fetchHome(
  minId: page.prevMinId,
);
```

Eine vollständige Erläuterung der Cursor-Parameter findest du in der [Paginierungs-Anleitung](../pagination.md).

## Veraltet: Direktnachrichten-Timeline

`fetchDirect()` wurde in Mastodon 3.0.0 entfernt. Stattdessen die Konversations-API verwenden.
