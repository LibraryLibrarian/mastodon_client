---
sidebar_position: 13
---

# Weitere APIs

Diese Seite behandelt geplante Status, Trends, Profilbild-Verwaltung, App-Registrierung, E-Mail-Bestätigung und den asynchronen Aktualisierungsstatus.

## Geplante Status

Mit `client.scheduledStatuses` werden Status verwaltet, die zur späteren Veröffentlichung eingeplant sind. Um einen geplanten Status zu erstellen, `scheduledAt` beim Aufruf von `client.statuses.create` übergeben.

### Geplante Status auflisten

```dart
final page = await client.scheduledStatuses.fetch(limit: 20);
for (final s in page.items) {
  print('${s.id} scheduled for ${s.scheduledAt}');
}

// Paginate
if (page.nextMaxId != null) {
  final next = await client.scheduledStatuses.fetch(maxId: page.nextMaxId);
}
```

Gibt `MastodonPage<MastodonScheduledStatus>` zurück. Das Standardlimit ist 20, das Maximum 40.

### Einzelnen geplanten Status abrufen

```dart
final s = await client.scheduledStatuses.fetchById('9876');
```

### Neu planen

Die neue Zeit muss mindestens 5 Minuten in der Zukunft liegen und im ISO-8601-Format angegeben werden:

```dart
final updated = await client.scheduledStatuses.update(
  '9876',
  scheduledAt: '2025-12-31T23:59:00.000Z',
);
```

### Abbrechen

```dart
await client.scheduledStatuses.delete('9876');
```

## Trends

Alle Trend-Endpunkte sind öffentlich und erfordern keine Authentifizierung. `client.trends` verwenden.

### Trending Tags

```dart
final tags = await client.trends.fetchTags(limit: 10);
for (final tag in tags) {
  print('#${tag.name}');
}
```

Gibt Tags mit steigender Nutzung in der vergangenen Woche zurück, sortiert nach dem internen Trend-Score. Das Standardlimit ist 10, das Maximum 20. Für die Paginierung `offset` verwenden.

### Trending Status

```dart
final statuses = await client.trends.fetchStatuses(limit: 20);
```

Gibt Status zurück, die deutlich mehr Interaktionen als üblich erhalten haben. Das Standardlimit ist 20, das Maximum 40.

### Trending Links

```dart
final links = await client.trends.fetchLinks(limit: 10);
for (final link in links) {
  print(link.url);
}
```

Gibt häufig im Netzwerk geteilte Links zurück. Das Standardlimit ist 10, das Maximum 20.

Alle drei Methoden akzeptieren einen `offset`-Parameter für Offset-basierte Paginierung.

## Profilbild-Verwaltung

`client.profile` ermöglicht das Entfernen von Profilbild und Header-Bild.

### Avatar löschen

```dart
final account = await client.profile.deleteAvatar();
```

### Header löschen

```dart
final account = await client.profile.deleteHeader();
```

Beide Methoden geben den aktualisierten `MastodonCredentialAccount` zurück und sind erfolgreich, auch wenn kein Bild gesetzt ist. Sie erfordern den OAuth-Scope `write:accounts`.

Zum Hochladen eines neuen Avatars oder Headers `client.accounts.updateCredentials` verwenden.

## App-Registrierung

`client.apps` für OAuth-Anwendungsregistrierung und Token-Verifizierung verwenden.

### Anwendung registrieren

```dart
final app = await client.apps.create(
  clientName: 'My Mastodon App',
  redirectUris: ['myapp://oauth/callback'],
  scopes: 'read write push',
  website: 'https://example.com',
);
print(app.clientId);
print(app.clientSecret);
```

`redirectUris` ist Pflicht. Für den Out-of-Band-Flow `['urn:ietf:wg:oauth:2.0:oob']` übergeben. `scopes` ist standardmäßig `read`, wenn weggelassen. Gibt `MastodonCredentialApplication` zurück.

### App-Credentials verifizieren

```dart
final app = await client.apps.verifyCredentials();
print(app.name);
```

Gibt `MastodonApplication` zurück. Wirft einen Authentifizierungsfehler, wenn der Token ungültig ist.

## E-Mail-Bestätigung

`client.emails` verwaltet das erneute Senden von Bestätigungs-E-Mails für neu registrierte Accounts.

### Bestätigungs-E-Mail erneut senden

```dart
await client.emails.resendConfirmation();

// Optionally update the email address at the same time
await client.emails.resendConfirmation(email: 'new@example.com');
```

Wenn `email` angegeben ist, wird die unbestätigte E-Mail-Adresse aktualisiert, bevor die Bestätigung gesendet wird.

### Bestätigungsstatus prüfen

```dart
await client.emails.checkConfirmation();
```

Beide Methoden erfordern einen Token, der vom Client erhalten wurde, der den unbestätigten Account erstellt hat.

## Asynchrone Aktualisierungen

`client.asyncRefreshes` ermöglicht die Abfrage des Fortschritts von Hintergrundaktualisierungsjobs. Dies ist eine experimentelle API, die in Mastodon 4.4.0 hinzugefügt wurde.

Wenn eine Antwort einen `Mastodon-Async-Refresh`-Header enthält, ist der Wert eine ID, die abgefragt werden kann, bis der Vorgang abgeschlossen ist:

```dart
final refresh = await client.asyncRefreshes.fetch('refresh-id-from-header');
print(refresh.complete); // true when done
```

Gibt `MastodonAsyncRefresh` zurück. Erfordert den OAuth-Scope `read`.
