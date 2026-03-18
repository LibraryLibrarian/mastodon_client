---
sidebar_position: 2
---

# Authentifizierung

Mastodon verwendet OAuth 2.0. Die meisten API-Endpunkte erfordern einen Access Token.

## Überblick über den Authentifizierungsablauf

```
1. App registrieren   → client_id / client_secret erhalten
2. Benutzer autorisieren → Browser-Autorisierungsseite öffnen → Autorisierungscode erhalten
3. Token anfordern    → Autorisierungscode gegen Access Token tauschen
```

## Schritt 1: Anwendung registrieren

```dart
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

final clientId = app.clientId!;
final clientSecret = app.clientSecret!;
```

Mit `urn:ietf:wg:oauth:2.0:oob` als Redirect-URI wird der OOB-Flow (Out-of-Band) aktiviert, der den Autorisierungscode direkt auf dem Bildschirm anzeigt. Für Web- oder Mobile-Apps wird stattdessen eine Callback-URL angegeben.

## Schritt 2: Benutzerautorisierung

Öffne die Autorisierungs-URL im Browser, um den Benutzer um Erlaubnis zu bitten. Dieser Schritt ist plattformabhängig und liegt außerhalb des Geltungsbereichs dieser Bibliothek.

```dart
// Building the authorization URL
final authorizeUrl = Uri.parse('${baseUrl}/oauth/authorize').replace(
  queryParameters: {
    'client_id': clientId,
    'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
    'response_type': 'code',
    'scope': 'read write push',
  },
);
// → Open this URL in a browser
```

Sobald der Benutzer die Berechtigung erteilt, wird ein Autorisierungscode zurückgegeben.

## Schritt 3: Access Token erhalten

```dart
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode, // The code from Step 2
);

print(token.accessToken); // Token for API calls
```

Einen neuen Client mit dem erhaltenen Token initialisieren:

```dart
final authenticatedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## Token widerrufen

```dart
await client.oauth.revokeToken(
  clientId: clientId,
  clientSecret: clientSecret,
  token: accessToken,
);
```

## Client Credentials

Um einen rein app-bezogenen Token ohne Benutzerinteraktion zu erhalten:

```dart
final token = await client.oauth.obtainToken(
  grantType: 'client_credentials',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  scope: 'read',
);
```

Mit diesem Token können nur öffentliche Informationen abgerufen werden.

## Server-Metadaten

Die vom Server unterstützten Scopes und Endpunkte können vorab abgerufen werden:

```dart
final metadata = await client.oauth.fetchServerMetadata();
print(metadata.scopesSupported);
```

## Scopes

| Scope | Beschreibung |
|-------|-------------|
| `read` | Alle Leseoperationen |
| `write` | Alle Schreiboperationen |
| `push` | Web-Push-Benachrichtigungen empfangen |
| `follow` | Folgebeziehungen ändern (Alias für `read:follows` + `write:follows`) |
| `admin:read` | Admin-Leseoperationen |
| `admin:write` | Admin-Schreiboperationen |

Granulare Scopes wie `read:accounts` und `write:statuses` sind ebenfalls verfügbar.
Details findest du in der [offiziellen Mastodon-Dokumentation](https://docs.joinmastodon.org/api/oauth-scopes/).
