---
sidebar_position: 2
---

# Media Upload

The `client.media` API handles file uploads with automatic async processing support.

## Uploading media

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

## Upload with thumbnail

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

## Focal point

The focal point determines which part of the image remains visible when cropped. Values range from -1.0 to 1.0 for both axes:

```dart
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  focus: '0.0,-0.5', // Center horizontally, upper half
);
```

## Async processing

When the server returns HTTP 202 (async processing), the library automatically polls `GET /api/v1/media/{id}` until the `url` field becomes available. This is transparent to the caller.

If processing does not complete within the polling limit (8 attempts, 500ms apart), a `MastodonMediaProcessingTimeoutException` is thrown:

```dart
try {
  final attachment = await client.media.upload(bytes, 'large-video.mp4');
} on MastodonMediaProcessingTimeoutException catch (e) {
  // Check status later
  final attachment = await client.media.fetchById(e.mediaId);
  if (attachment.url != null) {
    print('Processing complete: ${attachment.url}');
  }
}
```

## Updating media attributes

Update alt text, thumbnail, or focal point before attaching to a status:

```dart
final updated = await client.media.update(
  attachment.id,
  description: 'Updated alt text',
  focus: '0.5,0.0',
);
```

## Deleting unattached media

Only media not yet attached to a status can be deleted:

```dart
await client.media.delete(attachment.id);
```

## API version fallback

The library prefers `POST /api/v2/media` and automatically falls back to `POST /api/v1/media` for servers that do not support v2 (HTTP 404, 405, or 501). This is handled transparently.

## Attaching to a status

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

Up to 4 images or 1 video/audio can be attached per status (server-dependent).
