---
sidebar_position: 2
---

# Authentification

Mastodon utilise OAuth 2.0. La plupart des endpoints API nécessitent un token d'accès.

## Vue d'ensemble du flux d'authentification

```
1. Enregistrer l'app   → Obtenir client_id / client_secret
2. Autorisation        → Ouvrir l'écran d'autorisation dans le navigateur → Obtenir le code d'autorisation
3. Obtenir le token    → Échanger le code d'autorisation contre un token d'accès
```

## Étape 1 : Enregistrer votre application

```dart
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

final clientId = app.clientId!;
final clientSecret = app.clientSecret!;
```

Passer `urn:ietf:wg:oauth:2.0:oob` comme URI de redirection active le flux OOB (Out-of-Band), qui affiche le code d'autorisation à l'écran. Pour les applications web ou mobiles, spécifiez une URL de callback à la place.

## Étape 2 : Autorisation de l'utilisateur

Ouvrez l'URL d'autorisation dans un navigateur pour inviter l'utilisateur à accorder les permissions. Cette étape dépend de la plateforme et sort du cadre de cette bibliothèque.

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

Une fois que l'utilisateur a accordé les permissions, un code d'autorisation est retourné.

## Étape 3 : Obtenir le token d'accès

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

Initialisez un nouveau client avec le token obtenu :

```dart
final authenticatedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## Révoquer un token

```dart
await client.oauth.revokeToken(
  clientId: clientId,
  clientSecret: clientSecret,
  token: accessToken,
);
```

## Identifiants client (client credentials)

Pour obtenir un token applicatif sans interaction utilisateur :

```dart
final token = await client.oauth.obtainToken(
  grantType: 'client_credentials',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  scope: 'read',
);
```

Ce token ne peut accéder qu'aux informations publiques.

## Métadonnées du serveur

Vous pouvez récupérer à l'avance les scopes et endpoints supportés par le serveur :

```dart
final metadata = await client.oauth.fetchServerMetadata();
print(metadata.scopesSupported);
```

## Scopes

| Scope | Description |
|-------|-------------|
| `read` | Toutes les opérations de lecture |
| `write` | Toutes les opérations d'écriture |
| `push` | Recevoir des notifications Web Push |
| `follow` | Modifier les relations d'abonnement (alias pour `read:follows` + `write:follows`) |
| `admin:read` | Opérations de lecture administrateur |
| `admin:write` | Opérations d'écriture administrateur |

Des scopes plus granulaires tels que `read:accounts` et `write:statuses` sont également disponibles.
Consultez la [documentation officielle Mastodon](https://docs.joinmastodon.org/api/oauth-scopes/) pour plus de détails.
