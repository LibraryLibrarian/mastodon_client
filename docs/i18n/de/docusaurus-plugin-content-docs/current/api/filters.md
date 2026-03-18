---
sidebar_position: 6
---

# Filter

Die `client.filters`-API verwaltet serverseitige Inhaltsfilter (Mastodon 4.0+). Filter blenden Status aus oder zeigen eine Warnung an, wenn sie bestimmte Schlüsselwörter oder einzelne Status-IDs enthalten.

## Filter abrufen

### Alle Filter

```dart
final filters = await client.filters.fetch();

for (final filter in filters) {
  print('${filter.title}: ${filter.filterAction}');
}
```

### Einzelner Filter

```dart
final filter = await client.filters.fetchById('1');
print(filter.title);
```

## Filter erstellen

`title` und `context` sind Pflichtfelder. `context` ist eine Liste mit einem oder mehreren Anzeigebereichen, in denen der Filter gilt:

| Wert | Wo der Filter angewendet wird |
|---|---|
| `home` | Home-Timeline und Listen-Timelines |
| `notifications` | Benachrichtigungs-Timeline |
| `public` | Öffentliche Timelines |
| `thread` | Innerhalb eines Konversations-Threads |
| `account` | Beim Anzeigen eines Profils |

```dart
final filter = await client.filters.create(
  title: 'Hide spoilers',
  context: ['home', 'public'],
  filterAction: 'warn',
  expiresIn: 86400, // 1 day; omit for no expiration
);
```

`filterAction` akzeptiert `'warn'` (Warnung anzeigen), `'hide'` (Status vollständig ausblenden) oder `'blur'`. Wenn weggelassen, gilt der Serverstandard.

### Mit Schlüsselwörtern erstellen

`keywordsAttributes` angeben, um beim Erstellen gleich Schlüsselwörter hinzuzufügen.

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

## Filter aktualisieren

Alle Parameter sind optional; nur angegebene Felder werden geändert.

```dart
final updated = await client.filters.update(
  '1',
  title: 'Updated title',
  filterAction: 'hide',
);
```

## Filter löschen

```dart
await client.filters.delete('1');
```

## Filter-Schlüsselwörter

Schlüsselwörter sind die Phrasen, gegen die ein Filter abgleicht. Jedes Schlüsselwort gehört zu einem Filter.

### Schlüsselwörter auflisten

```dart
final keywords = await client.filters.fetchKeywords('1');

for (final kw in keywords) {
  print('${kw.keyword} (whole word: ${kw.wholeWord})');
}
```

### Schlüsselwort hinzufügen

```dart
final keyword = await client.filters.createKeyword(
  '1', // filter ID
  keyword: 'spoiler',
  wholeWord: true,
);
```

### Einzelnes Schlüsselwort abrufen

```dart
final keyword = await client.filters.fetchKeywordById('42');
```

### Schlüsselwort aktualisieren

```dart
final updated = await client.filters.updateKeyword(
  '42',
  keyword: 'spoilers',
  wholeWord: false,
);
```

### Schlüsselwort löschen

```dart
await client.filters.deleteKeyword('42');
```

### Schlüsselwörter per Batch mit einer Filter-Aktualisierung verwalten

`keywordsAttributes` an `update()` übergeben, um in einer Anfrage mehrere Schlüsselwörter hinzuzufügen, zu ändern oder zu löschen. `destroy: true` bei einem Eintrag setzen, um ihn zu löschen.

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

## Filter-Status

Zusätzlich zum Schlüsselwortabgleich können bestimmte Status zu einem Filter hinzugefügt werden, sodass sie immer ausgeblendet sind.

### Gefilterte Status auflisten

```dart
final statuses = await client.filters.fetchStatuses('1');
```

### Status zu einem Filter hinzufügen

```dart
final filterStatus = await client.filters.createStatus(
  '1', // filter ID
  statusId: '109876543210',
);
```

### Einzelnen Filter-Status-Eintrag abrufen

```dart
final filterStatus = await client.filters.fetchStatusById('99');
```

### Status aus einem Filter entfernen

```dart
await client.filters.deleteStatus('99');
```

## Veraltet: v1-Filter

Die v1-Filter-API wurde in Mastodon 4.0.0 als veraltet markiert. Sie wird nur für die Kompatibilität mit älteren Instanzen bereitgestellt.

| v1-Methode | v2-Äquivalent |
|---|---|
| `fetchV1()` | `fetch()` |
| `fetchByIdV1(id)` | `fetchById(id)` |
| `createV1(phrase:, context:)` | `create(title:, context:)` |
| `updateV1(id, phrase:, context:)` | `update(id)` |
| `deleteV1(id)` | `delete(id)` |

Wesentliche Unterschiede zu v2:

- v1 verwendet einen einzelnen `phrase`-String anstelle einer Liste von Schlüsselwörtern.
- `irreversible: true` verwirft passende Beiträge dauerhaft aus Home und Benachrichtigungen, ohne clientseitige Warnung.
- `deleteV1()` löscht nur den `FilterKeyword`-Datensatz, nicht den übergeordneten Filter.
- v1-Filter sind nur clientseitig; der Server erzwingt sie nicht.
