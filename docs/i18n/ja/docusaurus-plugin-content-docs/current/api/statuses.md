---
sidebar_position: 2
---

# 投稿（Statuses）

`client.statuses` API は投稿の作成・取得・操作を提供します。

## 投稿の取得

### 単一の投稿

```dart
final status = await client.statuses.fetch('12345');
print(status.content);
```

### 複数の投稿

```dart
final statuses = await client.statuses.fetchMultiple(['1', '2', '3']);
```

存在しない、またはアクセスできない ID は結果から除外されます。

### スレッドコンテキスト

```dart
final context = await client.statuses.fetchContext('12345');
print('${context.ancestors.length} 件の先祖');
print('${context.descendants.length} 件の子孫');
```

### 編集履歴

```dart
final history = await client.statuses.fetchHistory('12345');
for (final edit in history) {
  print(edit.content);
}
```

### ソース（編集用）

```dart
final source = await client.statuses.fetchSource('12345');
print(source.text);        // プレーンテキスト
print(source.spoilerText); // CW テキスト
```

## 投稿の作成

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Hello, Mastodon!',
    visibility: MastodonVisibility.public,
  ),
);

// result は MastodonStatusCreated または MastodonStatusScheduled
if (result case MastodonStatusCreated(:final status)) {
  print('投稿完了: ${status.url}');
}
```

### メディア付き

```dart
final attachment = await client.media.upload(imageBytes, 'photo.jpg',
  description: '美しい夕焼け',
);

final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'これを見てください！',
    mediaIds: [attachment.id],
  ),
);
```

### アンケート付き

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'どちらが好きですか？',
    poll: MastodonPollCreateRequest(
      options: ['選択肢A', '選択肢B', '選択肢C'],
      expiresIn: 86400, // 24時間
      multiple: false,
    ),
  ),
);
```

### 予約投稿

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'これは後で投稿されます',
    scheduledAt: '2025-12-31T00:00:00.000Z',
  ),
);

if (result case MastodonStatusScheduled(:final scheduledStatus)) {
  print('予約日時: ${scheduledStatus.scheduledAt}');
}
```

### 冪等性

```dart
final result = await client.statuses.create(
  request,
  idempotencyKey: 'unique-key-123',
);
```

同じキーでのリクエストは同一の結果を返します。

## 投稿の編集

```dart
final updated = await client.statuses.edit(
  '12345',
  MastodonStatusEditRequest(
    status: '更新されたコンテンツ',
  ),
);
```

## 投稿の削除

```dart
final deleted = await client.statuses.delete('12345');
// 再投稿用にソース情報を含むスナップショットが返される
print(deleted.text);
```

## インタラクション

### ブースト / ブースト解除

```dart
final boosted = await client.statuses.boost('12345');
// ラッパーステータスが返される。元の投稿は boosted.reblog に格納

final unboosted = await client.statuses.unboost('12345');
// 元の投稿が直接返される
```

### お気に入り / お気に入り解除

```dart
await client.statuses.favourite('12345');
await client.statuses.unfavourite('12345');
```

### ブックマーク / ブックマーク解除

```dart
await client.statuses.bookmark('12345');
await client.statuses.unbookmark('12345');
```

### 会話のミュート / ミュート解除

```dart
await client.statuses.mute('12345');   // スレッド通知を停止
await client.statuses.unmute('12345');
```

### ピン留め / ピン留め解除

```dart
await client.statuses.pin('12345');
await client.statuses.unpin('12345');
```

## ブースト / お気に入りしたユーザー

```dart
final boosters = await client.statuses.fetchRebloggedBy('12345', limit: 40);
final favouriters = await client.statuses.fetchFavouritedBy('12345', limit: 40);
```

どちらもページネーション対応の `MastodonPage<MastodonAccount>` を返します。

## 翻訳

```dart
final translation = await client.statuses.translate('12345', lang: 'en');
print(translation.content);
```

公開または未収載の投稿のみ翻訳可能です。
