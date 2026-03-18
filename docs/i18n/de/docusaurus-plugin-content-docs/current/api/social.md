---
sidebar_position: 12
---

# Social

Diese Seite behandelt die sozialen Graph-APIs über einfache Follows hinaus: Follower-Anfragen, gefolgten Tags, Follow-Vorschläge, Empfehlungen, hervorgehobene Tags, Tag-Operationen, Favoriten und Lesezeichen.

## Follower-Anfragen

Wenn ein Account gesperrt ist, müssen eingehende Follower-Anfragen über `client.followRequests` explizit angenommen oder abgelehnt werden.

### Ausstehende Anfragen auflisten

```dart
final page = await client.followRequests.fetch(limit: 40);
for (final account in page.items) {
  print('${account.acct} wants to follow you');
}

// Paginate
if (page.nextMaxId != null) {
  final next = await client.followRequests.fetch(maxId: page.nextMaxId);
}
```

`fetch` gibt `MastodonPage<MastodonAccount>` zurück. Paginierungs-Cursor kommen aus dem `Link`-Antwort-Header. Das Standardlimit ist 40, das Maximum 80.

### Anfrage annehmen

```dart
final relationship = await client.followRequests.authorize('12345');
print(relationship.followedBy); // true
```

### Anfrage ablehnen

```dart
final relationship = await client.followRequests.reject('12345');
```

Beide Methoden, `authorize` und `reject`, geben eine `MastodonRelationship` zurück, die den aktualisierten Beziehungsstatus widerspiegelt.

## Gefolgte Tags

`client.followedTags` listet die Hashtags auf, denen der authentifizierte Benutzer folgt. Beiträge mit gefolgten Tags erscheinen in der Home-Timeline.

```dart
final page = await client.followedTags.fetch(limit: 100);
for (final tag in page.items) {
  print('#${tag.name}');
}
```

Das Standardlimit ist 100, das Maximum 200. Paginierung verwendet `maxId`, `sinceId` und `minId`. Cursor-IDs sind interne Follow-Beziehungs-Datensatz-IDs, keine Tag-IDs.

Zum Folgen oder Entfolgen eines bestimmten Tags `client.tags` verwenden (siehe unten).

## Follow-Vorschläge

`client.suggestions` gibt Accounts zurück, die der Server zum Folgen empfiehlt — vom Staff kuratierte Auswahlen oder Accounts, mit denen positive Interaktionen stattgefunden haben, aber noch nicht gefolgt wird.

```dart
final suggestions = await client.suggestions.fetch(limit: 20);
for (final suggestion in suggestions) {
  print('${suggestion.account.acct} — reason: ${suggestion.source}');
}
```

Gibt `List<MastodonSuggestion>` zurück. Das Standardlimit ist 40, das Maximum 80.

Einen Account aus der Vorschlagsliste entfernen:

```dart
await client.suggestions.remove('12345');
```

Dies ist erfolgreich, auch wenn der Account gerade nicht in den Vorschlägen ist.

## Empfehlungen

Empfehlungen sind Accounts, die ein Benutzer auf seinem Profil hervorheben möchte. `client.endorsements` zur Abfrage verwenden.

```dart
final page = await client.endorsements.fetch(limit: 40);
for (final account in page.items) {
  print(account.displayName);
}
```

Gibt `MastodonPage<MastodonAccount>` zurück. Das Standardlimit ist 40, das Maximum 80. Zum Empfehlen oder Zurückziehen einer Empfehlung `client.accounts.endorse` und `client.accounts.unendorse` verwenden.

## Hervorgehobene Tags

Hervorgehobene Tags sind Hashtags, die prominent auf dem Benutzerprofil angezeigt werden. `client.featuredTags` zur Verwaltung verwenden.

### Hervorgehobene Tags auflisten

```dart
final tags = await client.featuredTags.fetch();
for (final tag in tags) {
  print('#${tag.name} — ${tag.statusesCount} statuses');
}
```

### Hervorgehobenen Tag hinzufügen

```dart
final tag = await client.featuredTags.create('dart');
print(tag.id);
```

Tag-Namen ohne das `#`-Präfix angeben.

### Hervorgehobenen Tag entfernen

```dart
await client.featuredTags.delete(tag.id);
```

### Vorschläge für hervorgehobene Tags

Der Server gibt bis zu 10 zuletzt verwendete Hashtags als Kandidaten zurück:

```dart
final suggestions = await client.featuredTags.fetchSuggestions();
```

Gibt `List<MastodonTag>` zurück.

## Tags

`client.tags` bietet Tag-Informationen, Folgen- und Hervorhebungsoperationen.

### Tag-Informationen abrufen

```dart
final tag = await client.tags.fetch('dart');
print(tag.name);
print(tag.following); // null if unauthenticated
```

Die Namenssuche ist Groß-/Kleinschreibungsunabhängig. Wenn authentifiziert, wird das Feld `following` einbezogen.

### Tag folgen und entfolgen

```dart
final tag = await client.tags.follow('dart');
print(tag.following); // true

final unfollowed = await client.tags.unfollow('dart');
print(unfollowed.following); // false
```

### Tag hervorheben und zurückziehen (Mastodon 4.4.0+)

```dart
await client.tags.feature('dart');
await client.tags.unfeature('dart');
```

Beide geben `MastodonTag` zurück und spiegeln den aktualisierten Status wider.

## Favoriten

`client.favourites` listet alle Status auf, die der authentifizierte Benutzer favorisiert hat.

```dart
final page = await client.favourites.fetch(limit: 20);
for (final status in page.items) {
  print(status.content);
}

// Older results
if (page.nextMaxId != null) {
  final older = await client.favourites.fetch(maxId: page.nextMaxId);
}
```

Gibt `MastodonPage<MastodonStatus>` zurück. Das Standardlimit ist 20, das Maximum 40. Paginierung verwendet `maxId`, `sinceId` und `minId`.

Zum Favorisieren oder Entfernen aus den Favoriten eines Status `client.statuses.favourite` und `client.statuses.unfavourite` verwenden.

## Lesezeichen

`client.bookmarks` listet alle Status auf, die der authentifizierte Benutzer mit einem Lesezeichen versehen hat.

```dart
final page = await client.bookmarks.fetch(limit: 20);
for (final status in page.items) {
  print(status.id);
}
```

Gibt `MastodonPage<MastodonStatus>` zurück. Das Standardlimit ist 20, das Maximum 40. Paginierung verwendet `maxId`, `sinceId` und `minId`.

Zum Hinzufügen oder Entfernen eines Lesezeichens `client.statuses.bookmark` und `client.statuses.unbookmark` verwenden.
