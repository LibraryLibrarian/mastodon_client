---
sidebar_position: 1
---

# Logging

mastodon_client enregistre les requêtes et réponses HTTP sur stdout par défaut. Vous pouvez désactiver ou rediriger cette sortie.

## Désactiver les logs

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);
```

## Logger personnalisé avec FunctionLogger

`FunctionLogger` adapte un simple callback à l'interface `Logger` :

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // level is one of: 'debug', 'info', 'warn', 'error'
    myLogger.log(level, message);
  }),
);
```

## Implémenter un Logger personnalisé

Pour un contrôle total, implémentez l'interface `Logger` :

```dart
class MyLogger implements Logger {
  @override
  void debug(String message) { /* ... */ }

  @override
  void info(String message) { /* ... */ }

  @override
  void warn(String message) { /* ... */ }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    // Handle error with optional stack trace
  }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: MyLogger(),
);
```

## Comportement par défaut

Le `StdoutLogger` par défaut utilise le package `logger` en interne. En mode debug, tous les niveaux de log (debug et supérieurs) sont affichés. En mode release, seuls les avertissements et niveaux supérieurs sont émis.

Format des logs :

```
[mastodon_client] [LEVEL] 2025-01-01 12:00:00.000000 message
```
