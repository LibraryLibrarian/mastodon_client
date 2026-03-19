---
sidebar_position: 8
---

# Notifications push

L'API `client.push` gère les abonnements Web Push. Elle suit le [protocole Web Push](https://www.rfc-editor.org/rfc/rfc8030) et permet à votre application de recevoir des notifications en arrière-plan.

## S'abonner

Créez un nouvel abonnement Web Push en fournissant votre endpoint push et vos clés VAPID :

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

### Types d'alertes

`MastodonPushAlertSettings` accepte toute combinaison des champs suivants. Les champs définis à `null` sont omis de la requête et restent inchangés.

| Champ | Description |
|-------|-------------|
| `mention` | Mentionné dans un statut |
| `quote` | Statut cité |
| `status` | Nouvelle publication d'un utilisateur suivi |
| `reblog` | Statut boosté |
| `follow` | Nouvel abonné |
| `followRequest` | Nouvelle demande d'abonnement |
| `favourite` | Statut ajouté aux favoris |
| `poll` | Un sondage auquel vous avez voté ou créé s'est terminé |
| `update` | Un statut avec lequel vous avez interagi a été modifié |
| `quotedUpdate` | Un statut cité a été modifié |
| `adminSignUp` | Nouvelle inscription d'utilisateur (admin uniquement) |
| `adminReport` | Nouveau signalement (admin uniquement) |

### Valeurs de politique

| Valeur | Description |
|--------|-------------|
| `all` | Recevoir des notifications de tous les utilisateurs |
| `followed` | Recevoir uniquement les notifications des utilisateurs que vous suivez |
| `follower` | Recevoir uniquement les notifications de vos abonnés |
| `none` | Désactiver toutes les notifications push |

## Récupérer l'abonnement actuel

```dart
final subscription = await client.push.fetch();
print(subscription.endpoint);
print(subscription.alerts.mention);
print(subscription.policy);
```

## Mettre à jour les paramètres d'alerte

Utilisez `update` pour modifier les paramètres d'alerte ou la politique sans recréer l'abonnement. Seule la partie `data` (alertes et politique) peut être modifiée.

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

## Se désabonner

```dart
await client.push.delete();
```

Supprime l'abonnement Web Push actuel. Les appels suivants à `fetch` lèveront une `MastodonNotFoundException`.

## Le modèle MastodonWebPushSubscription

| Champ | Type | Description |
|-------|------|-------------|
| `id` | `String` | ID d'abonnement |
| `endpoint` | `String` | URL de l'endpoint push |
| `serverKey` | `String` | Clé publique du serveur pour vérifier les messages push |
| `alerts` | `MastodonPushAlerts` | Paramètres d'alerte actifs |
| `policy` | `String` | Politique de notification |
| `standard` | `bool?` | Indique si l'abonnement est conforme à la spec Web Push standardisée (Mastodon 4.4+) |
