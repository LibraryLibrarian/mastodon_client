---
sidebar_position: 2
---

# Téléversement de médias

L'API `client.media` gère les téléversements et expose l'état du traitement
asynchrone du serveur sans ajouter de délai d'attente côté client.

## Téléverser un média

```dart
import 'dart:io';

final bytes = await File('photo.jpg').readAsBytes();
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  description: 'Alt text for accessibility',
);

print(attachment.id);
print(attachment.url);
```

## Téléverser avec une vignette

```dart
final thumbnailBytes = await File('thumb.jpg').readAsBytes();

final attachment = await client.media.upload(
  videoBytes,
  'video.mp4',
  description: 'A short clip',
  thumbnail: thumbnailBytes,
  thumbnailFilename: 'thumb.jpg',
);
```

## Point focal

Le point focal détermine quelle partie de l'image reste visible lors du recadrage. Les valeurs vont de -1.0 à 1.0 pour les deux axes :

```dart
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  focus: '0.0,-0.5', // Center horizontally, upper half
);
```

## Traitement asynchrone

Lorsque le serveur retourne HTTP 202, `upload()` renvoie immédiatement la pièce
jointe avec une `url` nulle. Appelez `fetchById()` lorsque l'application doit
vérifier son état. HTTP 206 indique que le traitement continue, tandis que HTTP
200 fournit l'état actuel. La bibliothèque n'effectue aucune scrutation et
n'impose aucun délai de traitement.

Si Mastodon renvoie HTTP 422, `fetchById()` expose l'échec du traitement sous
forme de `MastodonValidationException` via la conversion d'erreur standard.

```dart
final attachment = await client.media.upload(bytes, 'large-video.mp4');
if (attachment.url == null) {
  // Vérifier plus tard selon la politique de l'application.
  final current = await client.media.fetchById(attachment.id);
  print(current.url == null ? 'Traitement en cours' : current.url);
}
```

## Mettre à jour les attributs d'un média

Mettez à jour le texte alternatif, la vignette ou le point focal avant d'attacher le média à un statut :

```dart
final updated = await client.media.update(
  attachment.id,
  description: 'Updated alt text',
  focus: '0.5,0.0',
);
```

## Supprimer un média non attaché

Seuls les médias non encore attachés à un statut peuvent être supprimés :

```dart
await client.media.delete(attachment.id);
```

## Repli de version d'API

La bibliothèque préfère `POST /api/v2/media` et bascule automatiquement vers `POST /api/v1/media` pour les serveurs ne supportant pas v2 (HTTP 404, 405 ou 501). Cela est géré de manière transparente.

## Attacher à un statut

```dart
final attachment = await client.media.upload(bytes, 'photo.jpg',
  description: 'A scenic view',
);

final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Check out this view!',
    mediaIds: [attachment.id],
  ),
);
```

On peut attacher jusqu'à 4 images ou 1 vidéo/audio par statut (selon la configuration du serveur).
