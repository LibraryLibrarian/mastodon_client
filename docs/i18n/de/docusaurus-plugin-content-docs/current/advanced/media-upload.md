---
sidebar_position: 2
---

# Medien-Upload

Die `client.media`-API verarbeitet Datei-Uploads und gibt den asynchronen
Verarbeitungsstatus des Servers ohne clientseitiges Zeitlimit weiter.

## Medien hochladen

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

## Upload mit Vorschaubild

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

## Fokuspunkt

Der Fokuspunkt bestimmt, welcher Teil des Bildes beim Zuschneiden sichtbar bleibt. Die Werte liegen für beide Achsen zwischen -1.0 und 1.0:

```dart
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  focus: '0.0,-0.5', // Center horizontally, upper half
);
```

## Asynchrone Verarbeitung

Bei HTTP 202 gibt `upload()` den Anhang sofort mit `url: null` zurück. Rufe
`fetchById()` auf, wenn die Anwendung den Status prüfen muss. HTTP 206 bedeutet,
dass die Verarbeitung noch läuft; HTTP 200 liefert den aktuellen Anhang. Die
Bibliothek fragt nicht automatisch ab und setzt kein Verarbeitungszeitlimit.

Meldet Mastodon HTTP 422, gibt `fetchById()` den Verarbeitungsfehler über die
normale Fehlerumwandlung als `MastodonValidationException` weiter.

```dart
final attachment = await client.media.upload(bytes, 'large-video.mp4');
if (attachment.url == null) {
  // Später gemäß der Richtlinie der Anwendung prüfen.
  final current = await client.media.fetchById(attachment.id);
  print(current.url == null ? 'Wird verarbeitet' : current.url);
}
```

## Medienattribute aktualisieren

Alt-Text, Vorschaubild oder Fokuspunkt vor dem Anhängen an einen Status aktualisieren:

```dart
final updated = await client.media.update(
  attachment.id,
  description: 'Updated alt text',
  focus: '0.5,0.0',
);
```

## Nicht angehängte Medien löschen

Nur Medien, die noch nicht an einen Status angehängt sind, können gelöscht werden:

```dart
await client.media.delete(attachment.id);
```

## API-Versions-Fallback

Die Bibliothek bevorzugt `POST /api/v2/media` und greift automatisch auf `POST /api/v1/media` zurück, wenn der Server v2 nicht unterstützt (HTTP 404, 405 oder 501). Dies wird transparent gehandhabt.

## An einen Status anhängen

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

Pro Status können bis zu 4 Bilder oder 1 Video/Audio angehängt werden (serverabhängig).
