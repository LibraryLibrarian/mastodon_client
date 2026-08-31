[English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-Hans.md) | [Français](README.fr.md) | [한국어](README.ko.md)

# mastodon_client

Eine reine Dart-Clientbibliothek für die [Mastodon](https://joinmastodon.org/) API. Bietet typisierten Zugriff auf alle wichtigen API-Kategorien mit integrierter OAuth-Unterstützung, cursorbasierter Paginierung und strukturierter Fehlerbehandlung.

> **Beta**: Die API-Implementierung ist abgeschlossen, die Testabdeckung ist jedoch minimal. Response-Modelle und Methodensignaturen können sich auf Basis von Testergebnissen ändern. Siehe [CHANGELOG](CHANGELOG.md) für Details.

## Funktionen

- Deckt alle wichtigen Mastodon-API-Kategorien ab (Konten, Status, Timelines, Benachrichtigungen, Medien und mehr)
- OAuth 2.0 Token-Verwaltung (Abrufen, Widerrufen, Weitergabe des PKCE-`code_verifier` beim Token-Austausch)
- Cursorbasierte Paginierung über `MastodonPage<T>`
- Sealed-Ausnahmehierarchie für erschöpfende Fehlerbehandlung
- Asynchroner Medien-Upload mit automatischem v2/v1-Fallback und expliziter Statusabfrage
- Streaming-API über WebSocket mit gemultiplexten Abonnements und automatischer Wiederverbindung
- Konfigurierbares Logging über eine austauschbare `Logger`-Schnittstelle
- Reines Dart — keine Flutter-Abhängigkeit erforderlich

## Installation

Fügen Sie das Paket zu Ihrer `pubspec.yaml` hinzu:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.3
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

Der REST-Client setzt keine eigenen HTTP-Zeitüberschreitungen. Anfragen folgen
dem Verhalten des Transports und des Mastodon-Servers, statt durch
Bibliotheksvorgaben abgebrochen zu werden.

Bei asynchronen Medien-Uploads gibt `upload()` einen HTTP-202-Anhang sofort mit
`url: null` zurück. Prüfe ihn explizit mit `client.media.fetchById(id)`: HTTP 206
bedeutet laufende Verarbeitung, HTTP 200 liefert den aktuellen Anhang und HTTP
422 wird als `MastodonValidationException` gemeldet.

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
| `streaming` | Streaming-API über WebSocket (siehe [Streaming](#streaming)) |
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

## Erkennung von Serverfunktionen

Server können unterschiedliche Mastodon-API-Stände bereitstellen. Prüfen Sie
die Unterstützung, bevor Sie versionsabhängige Funktionen anbieten:

```dart
final capabilities = await client.instance.detectCapabilities();
final support = capabilities.supportFor(MastodonCapability.collections);

if (support == MastodonCapabilitySupport.supported) {
  // Sammlungsfunktionen anbieten.
}
```

Der Helfer bevorzugt `api_versions.mastodon`, greift andernfalls auf die
gemeldete Versionszeichenfolge zurück und versucht bei einer 404-Antwort des
v2-Instanz-Endpunkts den veralteten v1-Endpunkt. Cachen Sie das Ergebnis einmal
pro Server für die Laufzeit des App-Prozesses. Behandeln Sie `unknown`
vorsichtig und fangen Sie weiterhin Fehler des tatsächlichen API-Aufrufs ab,
da Forks und kompatible Implementierungen von der gemeldeten Version abweichen
können.

Die API-Version bezeichnet einen API-Oberflächenstand und keine
Mastodon-Releaseversion. Sie kann in Patch-Releases oder durch Änderungen ohne
neue Route steigen, für mehrere Releases gleich sein und Werte überspringen.
Die Funktionstabelle und Details zum Fallback stehen im
[Instanzleitfaden](https://librarylibrarian.github.io/mastodon_client/de/api/instance).

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

## Streaming

Echtzeit-Aktualisierungen über die Streaming-API (WebSocket). Eine einzelne Verbindung multiplext alle Abonnements, und der Endpunkt wird automatisch aus den Instanz-Metadaten ermittelt.

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();

final home = await client.streaming.subscribe(const MastodonStream.user());
home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonDeleteEvent(:final statusId):
      print('gelöscht: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    default:
      break;
  }
});

// Nur Status (`update` und `status.update`)
home.statuses.listen((status) => print(status.id));

final tag = await client.streaming.subscribe(
  const MastodonStream.hashtag('dart'),
);

await tag.cancel();
await client.dispose();
```

Kanäle werden über `MastodonStream` beschrieben: `user()`, `userNotification()`, `public()` (mit `local`, `remote`, `onlyMedia`), `hashtag()` (mit `local`), `list()` und `direct()`. Für Kanäle, die diese Bibliothek nicht abbildet, steht `subscribeRaw` zur Verfügung.

Abonnements werden referenzgezählt, sodass ein doppeltes Abonnement desselben Kanals nur einen `subscribe`-Frame sendet. Die Wiederverbindung erfolgt automatisch mit exponentiellem Backoff und Jitter, danach wird jedes aktive Abonnement erneut gesendet. Nutze `suspend()` und `resume()` bei Lebenszyklus-Wechseln der Anwendung und beobachte `stateChanges` sowie `errors`, um die Verbindung zu überwachen.

### Wissenswertes

- Streaming erfordert immer ein Zugriffstoken, auch für öffentliche Kanäle.
- Ein Token mit nur `read:statuses` empfängt Home-Status über `user`, erhält aber stillschweigend keine Benachrichtigungen. Verwende `read` oder `read:notifications`, wenn Benachrichtigungen benötigt werden.
- `only_media` wird über WebSocket ignoriert. Wähle stattdessen den Kanalnamen, etwa über `MastodonStream.public(onlyMedia: true)`.
- Wer `user` und `userNotification` gleichzeitig abonniert, erhält jede Benachrichtigung doppelt. `user` allein genügt.
- Öffentliche und Hashtag-Aktualisierungen können durch Spracheinstellungen, Feed-Zugriffseinstellungen, Blockierungen oder Stummschaltungen stillschweigend verworfen werden. Ein stiller Stream ist nicht zwangsläufig ein Fehler.
- Während einer Trennung erzeugte Ereignisse werden nicht nachgeliefert. Schließe die Lücke über REST-Endpunkte mit `since_id` oder `min_id`.

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
