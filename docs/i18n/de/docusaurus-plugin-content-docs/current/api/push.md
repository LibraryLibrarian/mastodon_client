---
sidebar_position: 8
---

# Push-Benachrichtigungen

Die `client.push`-API verwaltet Web-Push-Abonnements. Sie folgt dem [Web Push Protocol](https://www.rfc-editor.org/rfc/rfc8030) und ermöglicht es der Anwendung, Benachrichtigungen im Hintergrund zu empfangen.

## Abonnieren

Ein neues Web-Push-Abonnement durch Angabe des Push-Endpunkts und der VAPID-Keys erstellen:

```dart
final subscription = await client.push.create(
  MastodonPushSubscriptionRequest(
    endpoint: 'https://push.example.com/subscription/abc123',
    p256dh: '<Base64url-encoded P-256 ECDH public key>',
    auth: '<Base64url-encoded authentication secret>',
    standard: true,
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: true,
      reblog: true,
      favourite: true,
      poll: true,
    ),
    policy: 'followed', // all | followed | follower | none
  ),
);

print(subscription.id);
print(subscription.serverKey); // use to verify incoming pushes
```

### Alert-Typen

`MastodonPushAlertSettings` akzeptiert jede Kombination der folgenden Felder. Auf `null` gesetzte Felder werden aus der Anfrage weggelassen und bleiben unverändert.

| Feld | Beschreibung |
|------|-------------|
| `mention` | In einem Status erwähnt |
| `quote` | Status wurde zitiert |
| `status` | Neuer Beitrag eines gefolgten Benutzers |
| `reblog` | Status wurde geboostet |
| `follow` | Neuer Follower |
| `followRequest` | Neue Follower-Anfrage |
| `favourite` | Status wurde favorisiert |
| `poll` | Eine Umfrage, an der abgestimmt oder die erstellt wurde, ist beendet |
| `update` | Ein Status, mit dem interagiert wurde, wurde bearbeitet |
| `quotedUpdate` | Ein zitierter Status wurde bearbeitet |
| `adminSignUp` | Neue Benutzerregistrierung (nur Admin) |
| `adminReport` | Neue Meldung (nur Admin) |

### Richtlinienwerte

| Wert | Beschreibung |
|------|-------------|
| `all` | Benachrichtigungen von allen Benutzern empfangen |
| `followed` | Nur Benachrichtigungen von gefolgten Benutzern empfangen |
| `follower` | Nur Benachrichtigungen von eigenen Followern empfangen |
| `none` | Alle Push-Benachrichtigungen deaktivieren |

## Aktuelles Abonnement abrufen

```dart
final subscription = await client.push.fetch();
print(subscription.endpoint);
print(subscription.alerts.mention);
print(subscription.policy);
```

## Alert-Einstellungen aktualisieren

Mit `update` können Alert-Einstellungen oder die Richtlinie geändert werden, ohne das Abonnement neu zu erstellen. Nur der `data`-Teil (Alerts und Richtlinie) kann geändert werden.

```dart
final updated = await client.push.update(
  MastodonPushSubscriptionUpdateRequest(
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: false,
    ),
    policy: 'all',
  ),
);
```

## Abonnement beenden

```dart
await client.push.delete();
```

Löscht das aktuelle Web-Push-Abonnement. Anschließende Aufrufe von `fetch` werfen eine `MastodonNotFoundException`.

## Das MastodonWebPushSubscription-Modell

| Feld | Typ | Beschreibung |
|------|-----|-------------|
| `id` | `String` | Abonnement-ID |
| `endpoint` | `String` | Push-Endpunkt-URL |
| `serverKey` | `String` | Öffentlicher Serverschlüssel zur Verifizierung von Push-Nachrichten |
| `alerts` | `MastodonPushAlerts` | Aktive Alert-Einstellungen |
| `policy` | `String` | Benachrichtigungsrichtlinie |
| `standard` | `bool?` | Ob das Abonnement der standardisierten Web-Push-Spezifikation entspricht (Mastodon 4.4+) |
