---
sidebar_position: 2
---

# メディアアップロード

`client.media` API はファイルアップロードを扱い、クライアント側の待機期限を追加せずに
サーバーの非同期処理状態を公開します。

## メディアのアップロード

```dart
import 'dart:io';

final bytes = await File('photo.jpg').readAsBytes();
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  description: 'アクセシビリティ用の代替テキスト',
);

print(attachment.id);
print(attachment.url);
```

## サムネイル付きアップロード

```dart
final thumbnailBytes = await File('thumb.jpg').readAsBytes();

final attachment = await client.media.upload(
  videoBytes,
  'video.mp4',
  description: '短いクリップ',
  thumbnail: thumbnailBytes,
  thumbnailFilename: 'thumb.jpg',
);
```

## フォーカルポイント

フォーカルポイントは、画像がクロップされた際にどの部分が表示されるかを決定します。両軸とも -1.0 から 1.0 の範囲で指定します。

```dart
final attachment = await client.media.upload(
  bytes,
  'photo.jpg',
  focus: '0.0,-0.5', // 水平方向中央、上半分
);
```

## 非同期処理

サーバーが HTTP 202 を返した場合、`upload()` は `url` が `null` の添付情報を直ちに返します。
アプリケーションで状態確認が必要になった時点で `fetchById()` を呼び出してください。HTTP 206 は
処理中、HTTP 200 は最新の添付情報を取得できたことを示します。ライブラリはポーリングや処理期限の
設定を行いません。

Mastodon が HTTP 422 を返した場合、`fetchById()` は通常の例外変換経路を通じて処理失敗を
`MastodonValidationException` として通知します。

```dart
final attachment = await client.media.upload(bytes, 'large-video.mp4');
if (attachment.url == null) {
  // アプリケーション側の方針に従って後で確認
  final current = await client.media.fetchById(attachment.id);
  print(current.url == null ? '処理中' : current.url);
}
```

## メディア属性の更新

投稿に添付する前に代替テキスト、サムネイル、フォーカルポイントを更新できます。

```dart
final updated = await client.media.update(
  attachment.id,
  description: '更新された代替テキスト',
  focus: '0.5,0.0',
);
```

## 未添付メディアの削除

投稿にまだ添付されていないメディアのみ削除できます。

```dart
await client.media.delete(attachment.id);
```

## API バージョンフォールバック

ライブラリは `POST /api/v2/media` を優先し、v2 をサポートしないサーバー（HTTP 404, 405, 501）では自動的に `POST /api/v1/media` にフォールバックします。これは透過的に処理されます。

## 投稿への添付

```dart
final attachment = await client.media.upload(bytes, 'photo.jpg',
  description: '美しい景色',
);

final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'この景色を見てください！',
    mediaIds: [attachment.id],
  ),
);
```

1つの投稿には最大4枚の画像、または1つの動画/音声を添付できます（サーバー依存）。
