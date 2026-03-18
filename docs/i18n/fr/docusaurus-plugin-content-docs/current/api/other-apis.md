---
sidebar_position: 13
---

# Autres APIs

Cette page couvre les statuts planifiés, les tendances, la gestion des images de profil, l'enregistrement d'applications, la confirmation d'e-mail et le statut de rafraîchissement asynchrone.

## Statuts planifiés

Utilisez `client.scheduledStatuses` pour gérer les statuts mis en file d'attente pour publication ultérieure. Pour créer un statut planifié, passez `scheduledAt` lors de l'appel à `client.statuses.create`.

### Lister les statuts planifiés

```dart
final page = await client.scheduledStatuses.fetch(limit: 20);
for (final s in page.items) {
  print('${s.id} scheduled for ${s.scheduledAt}');
}

// Paginate
if (page.nextMaxId != null) {
  final next = await client.scheduledStatuses.fetch(maxId: page.nextMaxId);
}
```

Retourne `MastodonPage<MastodonScheduledStatus>`. La limite par défaut est 20 et le maximum est 40.

### Récupérer un statut planifié unique

```dart
final s = await client.scheduledStatuses.fetchById('9876');
```

### Replanifier

Le nouvel horaire doit être au moins 5 minutes dans le futur et doit être fourni au format ISO 8601 :

```dart
final updated = await client.scheduledStatuses.update(
  '9876',
  scheduledAt: '2025-12-31T23:59:00.000Z',
);
```

### Annuler

```dart
await client.scheduledStatuses.delete('9876');
```

## Tendances

Tous les endpoints de tendances sont publics et ne nécessitent pas d'authentification. Utilisez `client.trends`.

### Tags tendance

```dart
final tags = await client.trends.fetchTags(limit: 10);
for (final tag in tags) {
  print('#${tag.name}');
}
```

Retourne les tags dont l'utilisation augmente depuis la semaine passée, triés par score de tendance interne. La limite par défaut est 10 et le maximum est 20. Utilisez `offset` pour la pagination.

### Statuts tendance

```dart
final statuses = await client.trends.fetchStatuses(limit: 20);
```

Retourne les statuts ayant reçu significativement plus d'interactions que d'habitude. La limite par défaut est 20 et le maximum est 40.

### Liens tendance

```dart
final links = await client.trends.fetchLinks(limit: 10);
for (final link in links) {
  print(link.url);
}
```

Retourne les liens fréquemment partagés sur le réseau. La limite par défaut est 10 et le maximum est 20.

Ces trois méthodes acceptent un paramètre `offset` pour la pagination par décalage.

## Gestion des images de profil

`client.profile` permet la suppression des images d'avatar et de bannière du profil.

### Supprimer l'avatar

```dart
final account = await client.profile.deleteAvatar();
```

### Supprimer la bannière

```dart
final account = await client.profile.deleteHeader();
```

Les deux méthodes retournent le `MastodonCredentialAccount` mis à jour et réussissent même si aucune image n'est actuellement définie. Elles nécessitent le scope OAuth `write:accounts`.

Pour téléverser un nouvel avatar ou une nouvelle bannière, utilisez `client.accounts.updateCredentials`.

## Enregistrement d'application

Utilisez `client.apps` pour l'enregistrement d'applications OAuth et la vérification de token.

### Enregistrer une application

```dart
final app = await client.apps.create(
  clientName: 'My Mastodon App',
  redirectUris: ['myapp://oauth/callback'],
  scopes: 'read write push',
  website: 'https://example.com',
);
print(app.clientId);
print(app.clientSecret);
```

`redirectUris` est obligatoire. Pour le flux out-of-band, passez `['urn:ietf:wg:oauth:2.0:oob']`. `scopes` vaut `read` par défaut si omis. Retourne `MastodonCredentialApplication`.

### Vérifier les identifiants de l'application

```dart
final app = await client.apps.verifyCredentials();
print(app.name);
```

Retourne `MastodonApplication`. Lève une erreur d'authentification si le token est invalide.

## Confirmation d'e-mail

`client.emails` gère le renvoi d'e-mails de confirmation pour les comptes nouvellement enregistrés.

### Renvoyer l'e-mail de confirmation

```dart
await client.emails.resendConfirmation();

// Optionally update the email address at the same time
await client.emails.resendConfirmation(email: 'new@example.com');
```

Quand `email` est fourni, l'adresse e-mail non confirmée est mise à jour avant l'envoi de la confirmation.

### Vérifier le statut de confirmation

```dart
await client.emails.checkConfirmation();
```

Les deux méthodes nécessitent un token obtenu depuis le client qui a créé le compte non confirmé.

## Rafraîchissements asynchrones

`client.asyncRefreshes` permet de vérifier la progression des tâches de rafraîchissement en arrière-plan. Il s'agit d'une API expérimentale ajoutée dans Mastodon 4.4.0.

Lorsqu'une réponse inclut un en-tête `Mastodon-Async-Refresh`, la valeur est un ID qui peut être interrogé jusqu'à la fin de l'opération :

```dart
final refresh = await client.asyncRefreshes.fetch('refresh-id-from-header');
print(refresh.complete); // true when done
```

Retourne `MastodonAsyncRefresh`. Nécessite le scope OAuth `read`.
