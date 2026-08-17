---
sidebar_position: 15
---

# Streaming

Die `client.streaming`-API liefert Echtzeit-Aktualisierungen über die Mastodon-Streaming-API (WebSocket). Eine einzelne Verbindung multiplext alle Abonnements, sodass das Abonnieren mehrerer Kanäle nicht mehrere Sockets öffnet.

Der Zugriff auf `client.streaming` öffnet noch keine Verbindung. Der Socket wird erst bei `connect()` geöffnet, sodass rein REST-basierte Anwendungen über diese API nie das Netzwerk berühren.

## Verbinden

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();
```

Der Endpunkt wird automatisch ermittelt. Der Client liest `configuration.urls.streaming` aus `GET /api/v2/instance`, weicht auf `urls.streaming_api` aus `GET /api/v1/instance` aus und verwendet schließlich den REST-Host. Der ermittelte Wert wird normalisiert: `http` wird zu `ws`, `https` zu `wss`, der Port bleibt erhalten, und `/api/v1/streaming` wird angehängt, falls es fehlt.

Streaming erfordert in jedem Fall ein Zugriffstoken, auch für öffentliche Kanäle. Anonymer Zugriff wurde in Mastodon v4.2.0 entfernt.

## Abonnieren

```dart
final home = await client.streaming.subscribe(const MastodonStream.user());

home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonStatusUpdateEvent(:final status):
      print('bearbeitet: ${status.id}');
    case MastodonDeleteEvent(:final statusId):
      print('gelöscht: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    case MastodonUnknownStreamEvent(:final event):
      print('unbekanntes Ereignis: $event');
    default:
      break;
  }
});

await home.cancel();
```

Jedes Abonnement-Handle stellt drei Ebenen bereit:

| Eigenschaft | Typ | Inhalt |
|---|---|---|
| `events` | `Stream<MastodonStreamEvent>` | Typisierte, sealed Ereignisse |
| `statuses` | `Stream<MastodonStatus>` | Status aus `update` und `status.update` |
| `messages` | `Stream<MastodonStreamingMessage>` | Rohe Envelopes mit undekodierter Payload |

## Kanäle

Kanäle werden über den sealed Typ `MastodonStream` beschrieben.

| Factory | Protokollname |
|---|---|
| `MastodonStream.user()` | `user` |
| `MastodonStream.userNotification()` | `user:notification` |
| `MastodonStream.public()` | `public` |
| `MastodonStream.public(local: true)` | `public:local` |
| `MastodonStream.public(remote: true)` | `public:remote` |
| `MastodonStream.public(onlyMedia: true)` | `public:media` |
| `MastodonStream.public(local: true, onlyMedia: true)` | `public:local:media` |
| `MastodonStream.public(remote: true, onlyMedia: true)` | `public:remote:media` |
| `MastodonStream.hashtag('dart')` | `hashtag` |
| `MastodonStream.hashtag('dart', local: true)` | `hashtag:local` |
| `MastodonStream.list('42')` | `list` |
| `MastodonStream.direct()` | `direct` |

`local` und `remote` können nicht beide true sein — einen solchen Kanal gibt es auf dem Server nicht, und die Kombination wird durch eine Assertion abgelehnt.

Für Kanäle, die diese Bibliothek nicht abbildet, etwa solche aus Mastodon-Forks, steht `subscribeRaw` zur Verfügung:

```dart
final raw = await client.streaming.subscribeRaw('someCustomStream');
raw.messages.listen((message) => print(message.payload));
```

## Referenzzählung

Mastodon ignoriert ein zweites `subscribe` für einen bereits aktiven Kanal stillschweigend, deshalb führt der Client eine Referenzzählung. Der `subscribe`-Frame wird gesendet, wenn der Zähler von null auf eins steigt, `unsubscribe`, wenn er wieder null erreicht.

Hashtag-Schlüssel werden dafür in Kleinbuchstaben normalisiert. Ohne Normalisierung würden `Dart` und `dart` serverseitig kollidieren und das zweite Abonnement ohne Ereignisse zurücklassen.

```dart
final a = await client.streaming.subscribe(const MastodonStream.hashtag('Dart'));
final b = await client.streaming.subscribe(const MastodonStream.hashtag('dart'));

await a.cancel(); // Noch kein unsubscribe — b ist weiterhin aktiv.
await b.cancel(); // Jetzt wird unsubscribe gesendet.
```

## Fehler

Ein erfolgreiches Abonnement erzeugt keine Bestätigung, und Serverfehler enthalten weder Kanalnamen noch Korrelations-ID. Abonnement-Frames werden daher serialisiert, und ein Fehler, der im anschließenden Ruhefenster eintrifft, wird der letzten Anfrage zugeordnet.

```dart
try {
  await client.streaming.subscribe(const MastodonStream.list('999'));
} on MastodonStreamingSubscriptionException catch (e) {
  print('${e.message} (${e.status})');
}
```

`MastodonStreamingSubscriptionException.status` ist nullable, weil der Server `status` bei `unsubscribe`-Fehlern weglässt.

Fehler auf Verbindungsebene erscheinen als `MastodonStreamingConnectionException`, unerwartete Trennungen als `MastodonStreamingClosedException`. Beide werden zusätzlich über `client.streaming.errors` ausgegeben, falls Beobachten dem Abfangen vorgezogen wird.

## Wiederverbindung und Lebenszyklus

Die Wiederverbindung erfolgt automatisch mit exponentiellem Backoff und Jitter, begrenzt durch `MastodonStreamingConfig.reconnectMaxDelay`. Da der Abonnementzustand an der Verbindung hängt, wird jedes aktive Abonnement erneut gesendet, sobald die Ersatzverbindung nutzbar ist.

Close-Codes werden unterschiedlich behandelt:

| Close-Code | Verhalten |
|---|---|
| `1000` | Normaler Abschluss. Keine Wiederverbindung. |
| `1003` | Der Server hat einen Binär-Frame abgelehnt. Wird als Fehler gemeldet, ohne erneut zu versuchen. |
| `1005` | Kein Close-Frame. Kann ein widerrufenes Token bedeuten, daher kein blindes Wiederholen. |
| Andere | Wiederverbindung mit Backoff. |

Ein HTTP 401 während des Handshakes wird sofort ausgelöst, statt in die Wiederholungsschleife zu gehen, da ein ungültiges Token durch Wiederholen nicht gültig wird.

Verwende `suspend()` und `resume()`, wenn die Anwendung in den Hintergrund wechselt und zurückkehrt, und gib alles mit `dispose()` frei:

```dart
await client.streaming.suspend();
await client.streaming.resume();

await client.dispose();
```

`MastodonClient.dispose()` schließt die Streaming-Verbindung und den HTTP-Transport. Ein Streaming-Client wird dabei nicht erzeugt, wenn nie einer verwendet wurde.

## Konfiguration

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
  streamingConfig: MastodonStreamingConfig(
    authMode: MastodonStreamingAuthMode.subprotocol,
    pingInterval: Duration(seconds: 30),
    reconnectMaxDelay: Duration(seconds: 30),
    reconnectJitter: 0.2,
  ),
);
```

Drei Authentifizierungsmodi werden unterstützt. Der Standard `subprotocol` sendet das Token als einziges WebSocket-Subprotokoll; er funktioniert auf allen Plattformen einschließlich Web und hält das Token aus Zugriffsprotokollen heraus. `header` benötigt `dart:io`, und `queryParameter` ist ein Alt-Modus, der das Token in der URL offenlegt. Bleibt `enableAuthFallback` aktiviert, werden nach einem Fehlschlag die übrigen Modi versucht, und der erfolgreiche Modus wird bei späteren Wiederverbindungen bevorzugt. Tokens werden in der Log-Ausgabe stets maskiert.

## Wissenswertes

Die folgenden Verhaltensweisen stammen vom Mastodon-Streaming-Server selbst und wirken regelmäßig wie Client-Fehler.

- Ein Token mit nur `read:statuses` empfängt Home-Status über `user`, erhält aber überhaupt keine Benachrichtigungen — ohne jede Fehlermeldung. Benachrichtigungen erfordern `read` oder `read:notifications`.
- `only_media` wird über WebSocket ignoriert. Nur-Medien-Verhalten muss über den Kanalnamen gewählt werden.
- Wer `user` und `user:notification` gleichzeitig abonniert, erhält jede Benachrichtigung doppelt, weil der Server sie als getrennte Kanalmengen behandelt. `user` allein genügt.
- `update` und `status.update` auf öffentlichen und Hashtag-Kanälen können durch Spracheinstellungen, Feed-Zugriffseinstellungen (ab Mastodon v4.5), Blockierungen, Stummschaltungen und Domain-Blockaden stillschweigend verworfen werden. Ein öffentlicher Stream, der still bleibt, ist nicht zwangsläufig defekt.
- `filters_changed` ist als Ereignistyp definiert, wird ab Mastodon v4.3 jedoch nicht an Clients ausgeliefert, weil der Server Nachrichten ohne Payload verwirft.
- Ereignisse, die während einer Trennung entstehen, werden nach der Wiederverbindung nicht nachgeliefert. Schließe die Lücke über REST-Endpunkte mit `since_id` oder `min_id`.

## Gesundheitsprüfung

Der Streaming-Prozess besitzt einen eigenen Health-Endpunkt, der reinen Text statt JSON zurückgibt:

```dart
final healthy = await client.health.checkStreaming();
```
