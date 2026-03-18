---
sidebar_position: 1
slug: /
---

# Erste Schritte

mastodon_client ist eine reine Dart-Bibliothek für die Mastodon-API.
Sie läuft in jeder Umgebung, in der Dart unterstützt wird: Flutter, serverseitiges Dart, CLI-Tools und mehr.

## Installation

Füge die Abhängigkeit in deine `pubspec.yaml` ein:

```yaml
dependencies:
  mastodon_client: ^0.0.1
```

Anschließend ausführen:

```bash
dart pub get
```

## Grundlegende Verwendung

### Client initialisieren

```dart
import 'package:mastodon_client/mastodon_client.dart';

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_access_token',
);
```

`baseUrl` muss das Schema enthalten (z. B. `https://`).
`accessToken` kann weggelassen werden, wenn ausschließlich Endpunkte verwendet werden, die keine Authentifizierung erfordern.

### Erster API-Aufruf

Serverinformationen abrufen (keine Authentifizierung erforderlich):

```dart
final instance = await client.instance.fetch();
print(instance.title);       // Server name
print(instance.description); // Server description
```

Konto des angemeldeten Benutzers abrufen:

```dart
final me = await client.accounts.verifyCredentials();
print(me.displayName); // Display name
print(me.acct);        // Username
```

### API-Struktur

Jede API ist als Property von `MastodonClient` verfügbar und dient als Namensraum:

```dart
client.accounts      // Account operations
client.statuses      // Status operations
client.timelines     // Timeline retrieval
client.notifications // Notification operations
client.media         // Media upload
client.search        // Search
client.oauth         // OAuth token operations
// ... and many more
```

### Log-Ausgabe steuern

HTTP-Request/Response-Logs werden standardmäßig auf stdout ausgegeben.

```dart
// Disable logging
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);

// Use a custom logger
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // Your custom log handling
  }),
);
```

Details findest du unter [Logging](./advanced/logging.md).

## Nächste Schritte

- [Authentifizierung](./authentication.md) — Access Token via OAuth beziehen
- [Paginierung](./pagination.md) — Cursor-basierte Paginierung
- [Fehlerbehandlung](./error-handling.md) — Exception-Hierarchie und Catch-Muster
