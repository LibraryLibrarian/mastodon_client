[English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-Hans.md) | [Deutsch](README.de.md) | [한국어](README.ko.md)

# mastodon_client

Une bibliothèque cliente pure Dart pour l'API [Mastodon](https://joinmastodon.org/). Fournit un accès typé à toutes les principales catégories d'API avec prise en charge OAuth intégrée, pagination par curseur et gestion structurée des erreurs.

## Fonctionnalités

- Couvre toutes les principales catégories de l'API Mastodon (comptes, statuts, fils d'actualité, notifications, médias, et plus)
- Gestion des jetons OAuth 2.0 (obtention, révocation, support PKCE)
- Pagination par curseur via `MastodonPage<T>`
- Hiérarchie d'exceptions sealed pour une gestion exhaustive des erreurs
- Téléversement de médias asynchrone avec basculement automatique v2/v1 et scrutation du traitement
- Journalisation configurable via une interface `Logger` interchangeable
- Pure Dart — aucune dépendance Flutter requise

## Installation

Ajoutez le paquet à votre `pubspec.yaml` :

```yaml
dependencies:
  mastodon_client: ^0.0.1
```

Puis exécutez :

```
dart pub get
```

## Démarrage rapide

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

## Aperçu de l'API

`MastodonClient` expose les propriétés suivantes, chacune couvrant un domaine distinct de l'API Mastodon :

| Propriété | Description |
|---|---|
| `accounts` | Informations de compte, recherche, abonnement, blocage, masquage, mises à jour de profil |
| `statuses` | Créer, modifier, supprimer, booster, ajouter aux favoris, mettre en signet, épingler, traduire |
| `timelines` | Fils d'actualité personnel, local, fédéré, hashtag, liste |
| `notifications` | Notifications, politiques, demandes (v1 + groupées v2) |
| `media` | Téléversement (basculement v2/v1), traitement asynchrone, mise à jour, suppression |
| `search` | Comptes, statuts, hashtags (pagination par décalage + curseur) |
| `filters` | CRUD v2 avec mots-clés et entrées de statuts (+ v1 déprécié) |
| `lists` | CRUD de listes et gestion des comptes |
| `oauth` | Obtention/révocation de jetons, métadonnées du serveur, informations utilisateur |
| `apps` | Enregistrement et vérification d'applications |
| `instance` | Informations serveur (v1/v2), pairs, activité, règles, blocages de domaines |
| `customEmojis` | Listing des emojis personnalisés |
| `announcements` | Annonces du serveur et réactions |
| `conversations` | Conversations en messages privés |
| `polls` | Récupération et vote dans les sondages |
| `push` | Gestion des abonnements Web Push |
| `tags` | Informations sur les hashtags, abonnement/désabonnement |
| `trends` | Tags, statuts et liens tendance |
| `blocks` | Liste des comptes bloqués |
| `mutes` | Liste des comptes masqués |
| `domainBlocks` | Gestion du blocage de domaines au niveau utilisateur |
| `reports` | Création de signalements |
| `followRequests` | Gestion des demandes d'abonnement |
| `suggestions` | Suggestions d'abonnement |
| `favourites` | Liste des statuts mis en favoris |
| `bookmarks` | Liste des statuts mis en signet |
| `endorsements` | Liste des comptes mis en avant |
| `featuredTags` | Gestion des tags mis en avant |
| `followedTags` | Liste des tags suivis |
| `directory` | Annuaire des profils |
| `preferences` | Préférences utilisateur |
| `markers` | Marqueurs de position de lecture dans les fils |
| `scheduledStatuses` | Gestion des statuts planifiés |
| `health` | Vérification de l'état du serveur |
| `profile` | Gestion des images d'avatar et d'en-tête |
| `groupedNotifications` | Notifications groupées (v2) |
| `adminAccounts` | Gestion des comptes (admin) |
| `adminReports` | Gestion des signalements (admin) |
| `adminDomainBlocks` | Gestion des blocages de domaines (admin) |
| `adminDomainAllows` | Gestion des domaines autorisés (admin) |
| `adminIpBlocks` | Gestion des blocages IP (admin) |
| `adminCanonicalEmailBlocks` | Gestion des blocages d'e-mails canoniques (admin) |
| `adminEmailDomainBlocks` | Gestion des blocages de domaines d'e-mail (admin) |
| `adminTags` | Gestion des tags (admin) |
| `adminTrends` | Gestion des tendances (admin) |
| `adminMeasures` | Mesures quantitatives (admin) |
| `adminDimensions` | Dimensions catégorielles (admin) |
| `adminRetention` | Cohortes de rétention des utilisateurs (admin) |

## Authentification

Mastodon utilise OAuth 2.0. Enregistrez une application, redirigez l'utilisateur pour autorisation, puis échangez le code contre un jeton :

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

## Gestion des erreurs

Toutes les exceptions étendent la classe sealed `MastodonException`, permettant un filtrage par motif exhaustif :

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

## Journalisation

Activez le journaliseur stdout intégré via `enableLog`, ou fournissez une implémentation `Logger` personnalisée :

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

## Documentation

- Référence API : https://librarylibrarian.github.io/mastodon_client/
- Page pub.dev : https://pub.dev/packages/mastodon_client
- GitHub : https://github.com/LibraryLibrarian/mastodon_client

## Licence

Voir [LICENSE](LICENSE).
