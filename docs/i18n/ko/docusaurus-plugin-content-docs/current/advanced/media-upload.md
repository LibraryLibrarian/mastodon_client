---
sidebar_position: 2
---

# 미디어 업로드

`client.media` API는 비동기 처리 자동 지원을 포함한 파일 업로드를 처리합니다.

## 미디어 업로드

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

## 썸네일과 함께 업로드

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

## 초점

초점은 이미지가 잘릴 때 어느 부분이 보이는지를 결정합니다. 두 축 모두 -1.0에서 1.0 사이의 값을 사용합니다:

```dart
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  focus: '0.0,-0.5', // Center horizontally, upper half
);
```

## 비동기 처리

서버가 HTTP 202(비동기 처리 중)를 반환하면, 라이브러리는 `url` 필드가 채워질 때까지 자동으로 `GET /api/v1/media/{id}`를 폴링합니다. 이 과정은 호출자에게 투명하게 처리됩니다.

폴링 제한(8회, 500ms 간격) 내에 처리가 완료되지 않으면 `MastodonMediaProcessingTimeoutException`이 발생합니다:

```dart
try {
  final attachment = await client.media.upload(bytes, 'large-video.mp4');
} on MastodonMediaProcessingTimeoutException catch (e) {
  // 나중에 상태 확인
  final attachment = await client.media.fetchById(e.mediaId);
  if (attachment.url != null) {
    print('Processing complete: ${attachment.url}');
  }
}
```

## 미디어 속성 업데이트

포스트에 첨부하기 전에 대체 텍스트, 썸네일, 초점을 업데이트합니다:

```dart
final updated = await client.media.update(
  attachment.id,
  description: 'Updated alt text',
  focus: '0.5,0.0',
);
```

## 첨부되지 않은 미디어 삭제

아직 포스트에 첨부되지 않은 미디어만 삭제할 수 있습니다:

```dart
await client.media.delete(attachment.id);
```

## API 버전 폴백

라이브러리는 `POST /api/v2/media`를 우선 시도하며, v2를 지원하지 않는 서버(HTTP 404, 405, 501 응답)의 경우 자동으로 `POST /api/v1/media`로 폴백합니다. 이 과정은 투명하게 처리됩니다.

## 포스트에 첨부

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

포스트당 최대 이미지 4개 또는 동영상/오디오 1개를 첨부할 수 있습니다 (서버 설정에 따라 다름).
