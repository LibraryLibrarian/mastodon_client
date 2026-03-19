[English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-Hans.md) | [Français](README.fr.md) | [한국어](README.ko.md)

# mastodon_client

Eine reine Dart-Clientbibliothek für die [Mastodon](https://joinmastodon.org/) API. Bietet typisierten Zugriff auf alle wichtigen API-Kategorien mit integrierter OAuth-Unterstützung, cursorbasierter Paginierung und strukturierter Fehlerbehandlung.

> **Beta**: Die API-Implementierung ist abgeschlossen, die Testabdeckung ist jedoch minimal. Response-Modelle und Methodensignaturen können sich auf Basis von Testergebnissen ändern. Siehe [CHANGELOG](CHANGELOG.md) für Details.

## Funktionen

- Deckt alle wichtigen Mastodon-API-Kategorien ab (Konten, Status, Timelines, Benachrichtigungen, Medien und mehr)
- OAuth 2.0 Token-Verwaltung (Abrufen, Widerrufen, PKCE-Unterstützung)
- Cursorbasierte Paginierung über `MastodonPage<T>`
- Sealed-Ausnahmehierarchie für erschöpfende Fehlerbehandlung
- Asynchroner Medien-Upload mit automatischem v2/v1-Fallback und Verarbeitungs-Polling
- Konfigurierbares Logging über eine austauschbare `Logger`-Schnittstelle
- Reines Dart — keine Flutter-Abhängigkeit erforderlich

## Installation

Fügen Sie das Paket zu Ihrer `pubspec.yaml` hinzu:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.1
```

Führen Sie dann aus:

```
dart pub get
```

## Schnellstart

```dart
import 'package:mastodon_client/mastodon_client.dart';

void main() async {
  final client = MastodonClient(
    baseUrl: 'https://mastodon.social',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  // Fetch the authenticated user
  final me = await client.accounts.verifyCredentials();
  print(me.displayName);

  // Post a status
  await client.statuses.create(
    MastodonStatusCreateRequest(
      status: 'Hello from mastodon_client!',
      visibility: MastodonVisibility.public,
    ),
  );

  // Paginated home timeline
  final page = await client.timelines.fetchHome(limit: 20);
  for (final status in page.items) {
    print(status.content);
  }
}
```

## API-Übersicht

`MastodonClient` stellt die folgenden Eigenschaften bereit, die jeweils einen eigenen Bereich der Mastodon-API abdecken:

| Eigenschaft | Beschreibung |
|---|---|
| `accounts` | Kontoinformationen, Suche, Folgen, Blockieren, Stummschalten, Profilaktualisierungen |
| `statuses` | Status erstellen, bearbeiten, löschen, boosten, als Favorit markieren, als Lesezeichen speichern, anheften, übersetzen |
| `timelines` | Startseite, lokal, föderiert, Hashtag-, Listen-Timelines |
| `notifications` | Benachrichtigungen, Richtlinien, Anfragen (v1 + gruppiert v2) |
| `media` | Upload (v2/v1-Fallback), asynchrone Verarbeitung, Aktualisieren, Löschen |
| `search` | Konten, Status, Hashtags (Offset- + Cursor-Paginierung) |
| `filters` | v2-CRUD mit Schlüsselwörtern und Status-Einträgen (+ veraltetes v1) |
| `lists` | Listen-CRUD und Kontoverwaltung |
| `oauth` | Token abrufen/widerrufen, Server-Metadaten, Benutzerinformationen |
| `apps` | Anwendungsregistrierung und -verifizierung |
| `instance` | Serverinformationen (v1/v2), Peers, Aktivität, Regeln, Domain-Blockierungen |
| `customEmojis` | Auflistung benutzerdefinierter Emojis |
| `announcements` | Serverankündigungen und Reaktionen |
| `conversations` | Direktnachrichten-Unterhaltungen |
| `polls` | Umfragen abrufen und abstimmen |
| `push` | Web-Push-Abonnementverwaltung |
| `tags` | Hashtag-Informationen, Folgen/beenden |
| `trends` | Trending-Tags, Status, Links |
| `blocks` | Liste blockierter Konten |
| `mutes` | Liste stummgeschalteter Konten |
| `domainBlocks` | Benutzerbasierte Domain-Blockverwaltung |
| `reports` | Meldungen erstellen |
| `followRequests` | Folgeanfragen-Verwaltung |
| `suggestions` | Folgevorschläge |
| `favourites` | Liste der als Favorit markierten Status |
| `bookmarks` | Liste der als Lesezeichen gespeicherten Status |
| `endorsements` | Liste empfohlener Konten |
| `featuredTags` | Verwaltung hervorgehobener Tags |
| `followedTags` | Liste gefolgter Tags |
| `directory` | Profilverzeichnis |
| `preferences` | Benutzereinstellungen |
| `markers` | Timeline-Lesepositionsmarkierungen |
| `scheduledStatuses` | Verwaltung geplanter Status |
| `health` | Server-Gesundheitsprüfung |
| `profile` | Avatar-/Header-Bildverwaltung |
| `groupedNotifications` | Gruppierte Benachrichtigungen (v2) |
| `adminAccounts` | Admin-Kontoverwaltung |
| `adminReports` | Admin-Meldungsverwaltung |
| `adminDomainBlocks` | Admin-Domain-Blockverwaltung |
| `adminDomainAllows` | Admin-Domain-Erlaubnisverwaltung |
| `adminIpBlocks` | Admin-IP-Blockverwaltung |
| `adminCanonicalEmailBlocks` | Admin-Verwaltung kanonischer E-Mail-Blockierungen |
| `adminEmailDomainBlocks` | Admin-E-Mail-Domain-Blockverwaltung |
| `adminTags` | Admin-Tag-Verwaltung |
| `adminTrends` | Admin-Trends-Verwaltung |
| `adminMeasures` | Administrative quantitative Kennzahlen |
| `adminDimensions` | Administrative kategorische Dimensionen |
| `adminRetention` | Administrative Benutzer-Bindungskohorten |

## Authentifizierung

Mastodon verwendet OAuth 2.0. Registrieren Sie eine Anwendung, leiten Sie den Benutzer zur Autorisierung weiter und tauschen Sie den Code gegen ein Token aus:

```dart
// 1. Register your app
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

// 2. Direct the user to the authorization URL (platform-dependent)

// 3. Exchange the authorization code for a token
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: app.clientId!,
  clientSecret: app.clientSecret!,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode,
);

// 4. Create a new client with the token
final authedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## Fehlerbehandlung

Alle Ausnahmen erweitern die sealed-Klasse `MastodonException` und ermöglichen erschöpfendes Pattern-Matching:

```dart
try {
  final user = await client.accounts.fetchById('abc123');
} on MastodonUnauthorizedException {
  // 401 — token invalid or expired
} on MastodonForbiddenException {
  // 403 — operation not permitted
} on MastodonNotFoundException {
  // 404 — resource not found
} on MastodonRateLimitException catch (e) {
  // 429 — rate limited; check e.retryAfter
} on MastodonValidationException {
  // 422 — invalid request body
} on MastodonServerException {
  // 5xx — server-side error
} on MastodonNetworkException {
  // Timeout, connection refused, etc.
}
```

## Logging

Aktivieren Sie den integrierten Stdout-Logger über `enableLog`, oder stellen Sie eine eigene `Logger`-Implementierung bereit:

```dart
class MyLogger implements Logger {
  @override void debug(String message) { /* ... */ }
  @override void info(String message)  { /* ... */ }
  @override void warn(String message)  { /* ... */ }
  @override void error(String message, [Object? error, StackTrace? stackTrace]) { /* ... */ }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  logger: MyLogger(),
);
```

## Dokumentation

- API-Referenz: https://librarylibrarian.github.io/mastodon_client/
- pub.dev-Seite: https://pub.dev/packages/mastodon_client
- GitHub: https://github.com/LibraryLibrarian/mastodon_client

## Lizenz

Siehe [LICENSE](LICENSE).
