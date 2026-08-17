---
sidebar_position: 15
---

# Diffusion

L'API `client.streaming` fournit des mises à jour en temps réel via l'API de diffusion de Mastodon (WebSocket). Une seule connexion multiplexe tous les abonnements : s'abonner à plusieurs canaux n'ouvre donc pas plusieurs sockets.

Accéder à `client.streaming` n'ouvre pas de connexion. Le socket n'est ouvert qu'à l'appel de `connect()`, si bien qu'une application purement REST ne touche jamais au réseau via cette API.

## Connexion

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();
```

Le point de terminaison est résolu automatiquement. Le client lit `configuration.urls.streaming` depuis `GET /api/v2/instance`, se rabat sur `urls.streaming_api` de `GET /api/v1/instance`, puis réutilise l'hôte REST. La valeur obtenue est normalisée : `http` devient `ws`, `https` devient `wss`, le port est conservé, et `/api/v1/streaming` est ajouté s'il manque.

La diffusion exige un jeton d'accès dans tous les cas, y compris pour les canaux publics. L'accès anonyme a été supprimé dans Mastodon v4.2.0.

## Abonnement

```dart
final home = await client.streaming.subscribe(const MastodonStream.user());

home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonStatusUpdateEvent(:final status):
      print('modifié : ${status.id}');
    case MastodonDeleteEvent(:final statusId):
      print('supprimé : $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    case MastodonUnknownStreamEvent(:final event):
      print('événement inconnu : $event');
    default:
      break;
  }
});

await home.cancel();
```

Chaque descripteur d'abonnement expose trois couches :

| Propriété | Type | Contenu |
|---|---|---|
| `events` | `Stream<MastodonStreamEvent>` | Événements typés et sealed |
| `statuses` | `Stream<MastodonStatus>` | Statuts issus de `update` et `status.update` |
| `messages` | `Stream<MastodonStreamingMessage>` | Enveloppes brutes à charge utile non décodée |

## Canaux

Les canaux sont décrits par le type sealed `MastodonStream`.

| Fabrique | Nom protocolaire |
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

`local` et `remote` ne peuvent pas être vrais simultanément : aucun canal de ce type n'existe côté serveur, et la combinaison est rejetée par une assertion.

Pour les canaux que cette bibliothèque ne modélise pas, comme ceux ajoutés par les forks de Mastodon, utilisez `subscribeRaw` :

```dart
final raw = await client.streaming.subscribeRaw('someCustomStream');
raw.messages.listen((message) => print(message.payload));
```

## Comptage de références

Mastodon ignore silencieusement un second `subscribe` pour un canal déjà actif ; le client tient donc un compteur de références. La trame `subscribe` est envoyée lorsque le compteur passe de zéro à un, et `unsubscribe` lorsqu'il revient à zéro.

Les clés de mots-clics sont normalisées en minuscules à cette fin. Sans normalisation, `Dart` et `dart` entreraient en collision côté serveur et le second abonné ne recevrait aucun événement.

```dart
final a = await client.streaming.subscribe(const MastodonStream.hashtag('Dart'));
final b = await client.streaming.subscribe(const MastodonStream.hashtag('dart'));

await a.cancel(); // Pas encore d'unsubscribe : b reste actif.
await b.cancel(); // L'unsubscribe est envoyé maintenant.
```

## Erreurs

Un abonnement réussi ne produit aucun accusé de réception, et les erreurs du serveur ne portent ni nom de canal ni identifiant de corrélation. Les trames d'abonnement sont donc sérialisées, et une erreur reçue pendant la fenêtre de silence qui suit est attribuée à la dernière requête.

```dart
try {
  await client.streaming.subscribe(const MastodonStream.list('999'));
} on MastodonStreamingSubscriptionException catch (e) {
  print('${e.message} (${e.status})');
}
```

`MastodonStreamingSubscriptionException.status` est nullable car le serveur omet `status` dans les erreurs d'`unsubscribe`.

Les échecs au niveau de la connexion apparaissent comme `MastodonStreamingConnectionException`, et les fermetures inattendues comme `MastodonStreamingClosedException`. Les deux sont également émis sur `client.streaming.errors` pour les applications qui préfèrent observer plutôt que capturer.

## Reconnexion et cycle de vie

La reconnexion est automatique, avec un repli exponentiel et de la gigue, plafonnée par `MastodonStreamingConfig.reconnectMaxDelay`. L'état des abonnements étant lié à la connexion, chaque abonnement actif est renvoyé dès que la connexion de remplacement est utilisable.

Les codes de fermeture sont traités différemment :

| Code de fermeture | Comportement |
|---|---|
| `1000` | Fermeture normale. Pas de reconnexion. |
| `1003` | Le serveur a rejeté une trame binaire. Signalé comme erreur sans nouvelle tentative. |
| `1005` | Aucune trame de fermeture. Peut indiquer un jeton révoqué ; pas de nouvelle tentative aveugle. |
| Autres | Reconnexion avec repli. |

Un HTTP 401 pendant la poignée de main est levé immédiatement au lieu d'entrer dans la boucle de reprise, car réessayer avec un jeton invalide ne peut pas aboutir.

Utilisez `suspend()` et `resume()` lorsque l'application passe en arrière-plan et en revient, puis libérez tout avec `dispose()` :

```dart
await client.streaming.suspend();
await client.streaming.resume();

await client.dispose();
```

`MastodonClient.dispose()` ferme la connexion de diffusion et le transport HTTP. Il ne crée pas de client de diffusion si aucun n'a jamais été utilisé.

## Configuration

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

Trois modes d'authentification sont pris en charge. Le mode par défaut, `subprotocol`, envoie le jeton comme unique sous-protocole WebSocket ; il fonctionne sur toutes les plateformes, y compris le web, et évite que le jeton apparaisse dans les journaux d'accès. `header` nécessite `dart:io`, et `queryParameter` est un mode hérité qui expose le jeton dans l'URL. Si `enableAuthFallback` reste activé, les modes restants sont essayés après un échec, et le mode ayant réussi est privilégié lors des reconnexions suivantes. Les jetons sont toujours masqués dans les journaux.

## À savoir

Les comportements suivants proviennent du serveur de diffusion de Mastodon lui-même et ressemblent souvent à des bogues du client.

- Un jeton limité à `read:statuses` reçoit les statuts du fil principal sur `user`, mais ne reçoit aucune notification — sans aucune erreur. Les notifications exigent `read` ou `read:notifications`.
- `only_media` est ignoré via WebSocket. Le comportement « médias uniquement » doit être choisi par le nom du canal.
- S'abonner à la fois à `user` et à `user:notification` livre chaque notification en double, car le serveur les traite comme des ensembles de canaux distincts. `user` seul suffit.
- `update` et `status.update` sur les canaux publics et de mots-clics peuvent être écartés silencieusement par les préférences de langue, les réglages d'accès aux fils (Mastodon v4.5 et ultérieur), les blocages, les masquages et les blocages de domaine. Un flux public silencieux n'est pas nécessairement défaillant.
- `filters_changed` est défini comme type d'événement mais n'est pas livré aux clients à partir de Mastodon v4.3, car le serveur écarte les messages sans charge utile.
- Les événements produits pendant une déconnexion ne sont pas rejoués après la reconnexion. Comblez le manque via les points de terminaison REST avec `since_id` ou `min_id`.

## Vérification de l'état

Le processus de diffusion expose son propre point de terminaison d'état, qui renvoie du texte brut plutôt que du JSON :

```dart
final healthy = await client.health.checkStreaming();
```
