---
sidebar_position: 5
---

# 検索（Search）

`client.search` API は、アカウント・投稿・ハッシュタグを一度のリクエストで横断検索します。

## 基本的な検索

```dart
final result = await client.search.search('mastodon');

print('アカウント: ${result.accounts.length}件');
print('投稿: ${result.statuses.length}件');
print('ハッシュタグ: ${result.hashtags.length}件');
```

返り値は `MastodonSearchResult` で、以下の3つのリストを持ちます。

- `accounts` — `List<MastodonAccount>`
- `statuses` — `List<MastodonStatus>`
- `hashtags` — `List<MastodonTag>`

## 種類を絞り込む

`type` を指定すると、結果を1カテゴリに絞り込めます。指定できる値は `'accounts'`、`'statuses'`、`'hashtags'` です。

```dart
// アカウントのみ
final result = await client.search.search('alice', type: 'accounts');

// 投稿のみ
final result = await client.search.search('hello world', type: 'statuses');

// ハッシュタグのみ
final result = await client.search.search('dart', type: 'hashtags');
```

## リモートアカウントの解決

`resolve: true` を指定すると、ローカルに結果が見つからない場合に WebFinger を通じてリモートアカウントを検索します。ユーザートークンが必要です。

```dart
final result = await client.search.search(
  'alice@example.social',
  resolve: true,
);
```

## フォロー中のアカウントに絞る

`following: true` を指定すると、自分がフォローしているアカウントのみが返されます。ユーザートークンが必要です。

```dart
final result = await client.search.search(
  'alice',
  type: 'accounts',
  following: true,
);
```

## 特定のアカウントの投稿に絞る

`accountId` を指定すると、投稿の検索結果を特定のアカウントに絞り込めます。

```dart
final result = await client.search.search(
  'hello',
  type: 'statuses',
  accountId: '109876543210',
);
```

## 未レビューハッシュタグを除外する

`excludeUnreviewed: true` を指定すると、モデレーターが未レビューのハッシュタグを除外します（Mastodon 3.0.0 以降）。

```dart
final result = await client.search.search(
  'dart',
  type: 'hashtags',
  excludeUnreviewed: true,
);
```

## ページネーション

検索 API は `type` を指定した場合のオフセットベースのページネーションと、`minId` / `maxId` によるカーソルベースのページネーションの両方に対応しています。

### オフセットベースのページネーション

`offset` を使って結果の先頭からスキップできます。`limit` と固定の `type` と組み合わせて使用します。ユーザートークンが必要です。

```dart
final page1 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 0,
);

final page2 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 20,
);
```

### カーソルベースのページネーション

タイムラインと同様に `maxId` と `minId` でカーソルナビゲーションが行えます。

```dart
final result = await client.search.search(
  'mastodon',
  type: 'statuses',
  maxId: '109876543210',
);
```

`limit` のデフォルトはカテゴリごとに20件で、最大40件まで指定できます。

## 非推奨: v1 検索

`searchV1()` は Mastodon 3.0.0 で削除されました。2.x 系インスタンスとの互換性のためにのみ提供されています。新しい実装では必ず `search()` を使用してください。

v2 との主な違い:

- `hashtags` は `List<MastodonTag>` ではなく `List<String>`（タグ名のみ）を返す
- `following` および `excludeUnreviewed` パラメータは使用不可
