---
sidebar_position: 2
---

# 미디어 업로드

`client.media` API는 파일 업로드를 처리하고 클라이언트 측 대기 제한을 추가하지 않은 채
서버의 비동기 처리 상태를 제공합니다.

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

서버가 HTTP 202를 반환하면 `upload()`는 `url`이 `null`인 첨부 정보를 즉시 반환합니다.
애플리케이션에서 상태 확인이 필요할 때 `fetchById()`를 호출하세요. HTTP 206은 처리 중임을,
HTTP 200은 최신 첨부 상태를 가져왔음을 뜻합니다. 라이브러리는 자동 폴링이나 처리 제한 시간을
설정하지 않습니다.

Mastodon이 HTTP 422를 반환하면 `fetchById()`는 표준 오류 변환 경로를 통해 처리 실패를
`MastodonValidationException`으로 전달합니다.

```dart
final attachment = await client.media.upload(bytes, 'large-video.mp4');
if (attachment.url == null) {
  // 애플리케이션 정책에 따라 나중에 확인합니다.
  final current = await client.media.fetchById(attachment.id);
  print(current.url == null ? '처리 중' : current.url);
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
