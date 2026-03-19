---
sidebar_position: 1
slug: /
---

# Démarrage rapide

:::warning Bêta

Cette bibliothèque est actuellement en **bêta**. L'implémentation de l'API est complète, mais la couverture de tests est minimale. Les modèles de réponse et les signatures de méthodes peuvent évoluer suite aux résultats des tests.

Si vous constatez des modèles de réponse incorrects ou un comportement inattendu, veuillez le signaler via [GitHub Issues](https://github.com/LibraryLibrarian/mastodon_client/issues) ou soumettre une [Pull Request](https://github.com/LibraryLibrarian/mastodon_client/pulls).

:::

mastodon_client est une bibliothèque cliente Mastodon API écrite en Dart pur.
Elle fonctionne dans tout environnement où Dart est disponible : Flutter, Dart côté serveur, outils CLI, et bien d'autres.

## Installation

Ajoutez la dépendance dans votre `pubspec.yaml` :

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.1
```

Puis récupérez-la :

```bash
dart pub get
```

## Utilisation de base

### Initialiser le client

```dart
import 'package:mastodon_client/mastodon_client.dart';

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_access_token',
);
```

`baseUrl` doit inclure le schéma (ex. `https://`).
`accessToken` peut être omis si vous utilisez uniquement des endpoints ne nécessitant pas d'authentification.

### Votre premier appel API

Récupérer les informations du serveur (sans authentification) :

```dart
final instance = await client.instance.fetch();
print(instance.title);       // Server name
print(instance.description); // Server description
```

Récupérer le compte de l'utilisateur authentifié :

```dart
final me = await client.accounts.verifyCredentials();
print(me.displayName); // Display name
print(me.acct);        // Username
```

### Structure de l'API

Chaque API est exposée sous forme de propriété sur `MastodonClient`, jouant le rôle de namespace :

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

### Contrôler la sortie des logs

Les logs de requêtes/réponses HTTP sont affichés sur stdout par défaut.

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

Consultez [Logging](./advanced/logging.md) pour plus de détails.

## Prochaines étapes

- [Authentification](./authentication.md) — Obtenir des tokens d'accès via OAuth
- [Pagination](./pagination.md) — Pagination par curseur
- [Gestion des erreurs](./error-handling.md) — Hiérarchie des exceptions et modèles de capture
