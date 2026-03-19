---
sidebar_position: 2
---

# 媒体上传

`client.media` API 处理文件上传，并自动支持异步处理。

## 上传媒体

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

## 上传时附带缩略图

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

## 焦点坐标

焦点坐标决定图片裁剪时哪部分保持可见。两个轴的值范围均为 -1.0 到 1.0：

```dart
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  focus: '0.0,-0.5', // 水平居中，上半部分
);
```

## 异步处理

当服务器返回 HTTP 202（异步处理）时，本库会自动轮询 `GET /api/v1/media/{id}`，直到 `url` 字段变为可用。这对调用方是透明的。

如果处理在轮询限制内（8 次，每次间隔 500ms）未完成，将抛出 `MastodonMediaProcessingTimeoutException`：

```dart
try {
  final attachment = await client.media.upload(bytes, 'large-video.mp4');
} on MastodonMediaProcessingTimeoutException catch (e) {
  // 稍后检查状态
  final attachment = await client.media.fetchById(e.mediaId);
  if (attachment.url != null) {
    print('Processing complete: ${attachment.url}');
  }
}
```

## 更新媒体属性

在附加到帖子之前，可以更新替代文字、缩略图或焦点坐标：

```dart
final updated = await client.media.update(
  attachment.id,
  description: 'Updated alt text',
  focus: '0.5,0.0',
);
```

## 删除未附加的媒体

只有尚未附加到帖子的媒体才能被删除：

```dart
await client.media.delete(attachment.id);
```

## API 版本回退

本库优先使用 `POST /api/v2/media`，当服务器不支持 v2 时（HTTP 404、405 或 501）自动回退到 `POST /api/v1/media`。此过程对调用方透明。

## 附加到帖子

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

每条帖子最多可附加 4 张图片或 1 个视频/音频（取决于服务器配置）。
