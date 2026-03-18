---
sidebar_position: 10
---

# Instanz & Server

Diese Seite behandelt die APIs zum Abrufen von Server-Metadaten, benutzerdefinierten Emojis, Ankündigungen, dem Gesundheitsstatus, Benutzereinstellungen, dem Profil-Verzeichnis, oEmbed-Einbettungen und Timeline-Markierungen.

## Instanzinformationen

### Aktuelle Instanz (v2)

```dart
final instance = await client.instance.fetch();
print(instance.title);
print(instance.description);
print(instance.version);
```

Gibt eine `MastodonInstance` mit vollständigen v2-Metadaten zurück, einschließlich konfigurierter Sprachen, Regeln und Kontaktinformationen.

### Bekannte Domains (Peers)

```dart
final peers = await client.instance.fetchPeers();
// List<String> of known federated domains
```

### Wöchentliche Aktivität

```dart
final activity = await client.instance.fetchActivity();
for (final week in activity) {
  print('Statuses: ${week.statuses}');
}
```

Gibt bis zu 12 Wochen an `MastodonWeeklyActivity`-Objekten zurück.

### Instanzregeln

```dart
final rules = await client.instance.fetchRules();
for (final rule in rules) {
  print(rule.text);
}
```

### Domain-Sperren

```dart
final blocked = await client.instance.fetchDomainBlocks();
```

Gibt die Liste der von der Instanz gesperrten Domains zurück. Dies ist eine serverweit geltende Liste, nicht die benutzerspezifische; für benutzerspezifische Domain-Sperren siehe die Seite [Moderation](./moderation.md).

### Erweiterte Beschreibung

```dart
final description = await client.instance.fetchExtendedDescription();
print(description.content);
```

### Datenschutzrichtlinie und Nutzungsbedingungen

```dart
final policy = await client.instance.fetchPrivacyPolicy();
final tos = await client.instance.fetchTermsOfService();

// Fetch a specific historical version of the ToS by date
final old = await client.instance.fetchTermsOfServiceByDate('2024-01-01');
```

### Übersetzungssprachen

```dart
final languages = await client.instance.fetchTranslationLanguages();
// Map<String, List<String>> — source lang → supported target langs
languages.forEach((source, targets) {
  print('$source → $targets');
});
```

### Veraltetes v1

```dart
// ignore: deprecated_member_use
final instanceV1 = await client.instance.fetchV1();
```

`fetchV1()` ist seit Mastodon 4.0.0 veraltet. Verwende `fetch()`, außer wenn ältere Server unterstützt werden müssen.

---

## Benutzerdefinierte Emojis

```dart
final emojis = await client.customEmojis.fetch();
for (final emoji in emojis) {
  print(':${emoji.shortcode}: → ${emoji.url}');
}
```

Keine Authentifizierung erforderlich. Gibt eine `List<MastodonCustomEmoji>` aller auf dem Server verfügbaren benutzerdefinierten Emojis zurück.

---

## Ankündigungen

### Ankündigungen auflisten

```dart
final announcements = await client.announcements.fetch();
for (final a in announcements) {
  print(a.text);
}
```

### Ankündigung schließen

```dart
await client.announcements.dismiss('announcement-id');
```

Markiert die Ankündigung für den authentifizierten Benutzer als gelesen.

### Reaktionen

```dart
// Add a reaction (Unicode emoji or custom shortcode)
await client.announcements.addReaction('announcement-id', '👍');
await client.announcements.addReaction('announcement-id', 'blobcat');

// Remove a reaction
await client.announcements.removeReaction('announcement-id', '👍');
```

---

## Gesundheitsprüfung

```dart
final healthy = await client.health.check();
// Returns true if the web process, database, and cache are all healthy.
// Throws MastodonException if any component is unhealthy.
```

Keine Authentifizierung erforderlich. Nützlich für Monitoring und Readiness-Prüfungen.

---

## Benutzereinstellungen

```dart
final prefs = await client.preferences.fetch();
print(prefs.postingDefaultVisibility);
print(prefs.postingDefaultLanguage);
print(prefs.expandSpoilers);
```

Gibt die `MastodonPreferences` des authentifizierten Benutzers zurück. Zum Aktualisieren der Einstellungen `client.accounts.updateCredentials()` verwenden.

---

## Profil-Verzeichnis

```dart
// Most recently active accounts (global)
final active = await client.directory.fetch(
  order: 'active',
  limit: 40,
);

// Newest local accounts only
final newLocal = await client.directory.fetch(
  order: 'new',
  local: true,
);
```

Parameter:

| Parameter | Standard | Max | Beschreibung |
|-----------|---------|-----|-------------|
| `limit`   | 40      | 80  | Anzahl der Ergebnisse |
| `offset`  | —       | —   | Diese Anzahl an Ergebnissen überspringen |
| `order`   | —       | —   | `active` oder `new` |
| `local`   | —       | —   | `true` für nur lokale Accounts |

Keine Authentifizierung erforderlich.

---

## oEmbed

```dart
final embed = await client.oembed.fetch(
  'https://mastodon.social/@user/12345',
  maxwidth: 500,
);
print(embed.html);
```

Gibt ein `MastodonOEmbed` mit dem einbettbaren HTML für eine Status-URL zurück. Keine Authentifizierung erforderlich.

---

## Timeline-Markierungen

Markierungen ermöglichen es, die zuletzt gelesene Position eines Benutzers in der Home-Timeline und der Benachrichtigungs-Timeline sitzungs- und geräteübergreifend zu speichern.

### Markierungen abrufen

```dart
final markers = await client.markers.fetch(['home', 'notifications']);
final home = markers['home'];
print(home?.lastReadId);
```

Eine Liste mit `'home'`, `'notifications'` oder beidem übergeben. Gibt eine leere Map zurück, wenn keines angegeben ist.

### Markierungen speichern

```dart
final updated = await client.markers.save(
  homeLastReadId: '109876543210',
  notificationsLastReadId: '987654321',
);
```

Mindestens eines der Felder `homeLastReadId` oder `notificationsLastReadId` muss angegeben werden. Wenn der Server mit `409 Conflict` antwortet (Schreibkonflikt durch ein anderes Gerät), die Anfrage wiederholen.

```dart
// Retry on conflict example
Map<String, MastodonMarker> result;
while (true) {
  try {
    result = await client.markers.save(homeLastReadId: lastId);
    break;
  } on MastodonConflictException {
    // Small delay before retry
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
```
