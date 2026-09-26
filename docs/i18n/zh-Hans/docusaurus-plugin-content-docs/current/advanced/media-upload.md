---
sidebar_position: 2
---

# 媒体上传

`client.media` API 处理文件上传，并在不添加客户端等待期限的情况下公开服务器的异步处理状态。

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

当服务器返回 HTTP 202 时，`upload()` 会立即返回 `url` 为 `null` 的附件。
应用需要检查状态时可调用 `fetchById()`。HTTP 206 表示仍在处理中，HTTP 200 表示已获取
最新附件状态。本库不会自动轮询，也不会设置处理期限。

如果 Mastodon 返回 HTTP 422，`fetchById()` 会通过标准错误转换流程将处理失败转换为
`MastodonValidationException`。

```dart
final attachment = await client.media.upload(bytes, 'large-video.mp4');
if (attachment.url == null) {
  // 根据应用自身策略稍后检查。
  final current = await client.media.fetchById(attachment.id);
  print(current.url == null ? '仍在处理中' : current.url);
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
