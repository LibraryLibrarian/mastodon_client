---
sidebar_position: 2
---

# Authentication

Mastodon uses OAuth 2.0. Most API endpoints require an access token.

## Authentication flow overview

```
1. Register app   → Obtain client_id / client_secret
2. User authorize → Open browser authorization screen → Get authorization code
3. Obtain token   → Exchange authorization code for access token
```

## Step 1: Register your application

```dart
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

final clientId = app.clientId!;
final clientSecret = app.clientSecret!;
```

Passing `urn:ietf:wg:oauth:2.0:oob` as the redirect URI enables the OOB (Out-of-Band) flow, which displays the authorization code on screen. For web or mobile apps, specify a callback URL instead.

## Step 2: User authorization

Open the authorization URL in a browser to prompt the user for permission. This step is platform-dependent and outside the scope of this library.

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

Once the user grants permission, an authorization code is returned.

## Step 3: Obtain the access token

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

Initialize a new client with the obtained token:

```dart
final authenticatedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## Revoking a token

```dart
await client.oauth.revokeToken(
  clientId: clientId,
  clientSecret: clientSecret,
  token: accessToken,
);
```

## Client credentials

To obtain an app-only token without user interaction:

```dart
final token = await client.oauth.obtainToken(
  grantType: 'client_credentials',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  scope: 'read',
);
```

This token can only access public information.

## Server metadata

You can retrieve the scopes and endpoints supported by the server in advance:

```dart
final metadata = await client.oauth.fetchServerMetadata();
print(metadata.scopesSupported);
```

## Scopes

| Scope | Description |
|-------|-------------|
| `read` | All read operations |
| `write` | All write operations |
| `push` | Receive Web Push notifications |
| `follow` | Modify follow relationships (alias for `read:follows` + `write:follows`) |
| `admin:read` | Admin read operations |
| `admin:write` | Admin write operations |

Granular scopes such as `read:accounts` and `write:statuses` are also available.
See the [Mastodon official documentation](https://docs.joinmastodon.org/api/oauth-scopes/) for details.
