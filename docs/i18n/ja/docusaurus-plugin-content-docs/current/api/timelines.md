---
sidebar_position: 4
---

# タイムライン（Timelines）

`client.timelines` API は各種ソースから投稿ストリームを取得します。すべてのメソッドは `MastodonPage<MastodonStatus>` を返し、カーソルベースのページネーションに対応しています。

## ホームタイムライン

フォローしているアカウントの投稿を取得します。

```dart
final page = await client.timelines.fetchHome(limit: 20);

for (final status in page.items) {
  print('${status.account.acct}: ${status.content}');
}
```

## パブリックタイムライン

### ローカルタイムライン

同じインスタンスのアカウントによる投稿を取得します。

```dart
final page = await client.timelines.fetchLocal(limit: 20);
```

`onlyMedia: true` を指定すると、メディア添付のある投稿のみに絞り込めます。

```dart
final page = await client.timelines.fetchLocal(onlyMedia: true);
```

### 連合タイムライン

インスタンスが収集した、連合ネットワーク全体の公開投稿を取得します。

```dart
final page = await client.timelines.fetchFederated(limit: 20);
```

任意パラメータ:

- `onlyMedia` — メディア添付のある投稿のみ表示
- `remoteOnly` — ローカルアカウントの投稿を除外

```dart
final page = await client.timelines.fetchFederated(
  remoteOnly: true,
  onlyMedia: true,
);
```

## ハッシュタグタイムライン

指定したハッシュタグを含む投稿を取得します。`#` を除いたタグ名を渡します。

```dart
final page = await client.timelines.fetchHashtag('mastodon', limit: 20);
```

追加のタグフィルタで結果を広げたり絞り込んだりできます。

- `any` — これらのタグのいずれかを含む投稿も対象に含める
- `all` — これらのタグをすべて含む投稿のみ対象にする
- `none` — これらのタグのいずれかを含む投稿を除外する

```dart
final page = await client.timelines.fetchHashtag(
  'dart',
  any: ['flutter'],
  none: ['spam'],
);
```

`localOnly` または `remoteOnly` でローカル・リモートに絞り込むこともできます。

## リストタイムライン

特定のリストに含まれるアカウントの投稿を取得します。リストの ID を指定します。

```dart
final page = await client.timelines.fetchList('42', limit: 20);
```

## リンクタイムライン

特定の URL に関連する投稿を取得します（サーバーのサポートが必要です）。

```dart
final page = await client.timelines.fetchLink(
  'https://example.com/article',
  limit: 20,
);
```

## ページネーション

すべてのタイムラインメソッドは `MastodonPage<MastodonStatus>` を返します。古いページ・新しいページへのカーソルが含まれています。

### 次のページ（古い投稿）を取得する

```dart
var page = await client.timelines.fetchHome(limit: 20);

while (page.nextMaxId != null) {
  page = await client.timelines.fetchHome(
    limit: 20,
    maxId: page.nextMaxId,
  );
  for (final status in page.items) {
    print(status.content);
  }
}
```

### 新着投稿をポーリングする

`sinceId` を使うと、最後に取得した ID より新しい投稿を確認できます。

```dart
String? latestId = page.items.firstOrNull?.id;

final newPage = await client.timelines.fetchHome(
  sinceId: latestId,
);
```

### `minId` による順方向ページネーション

`minId` は指定した ID の直後から隙間なく結果を返します。順方向の連続取得に適しています。

```dart
final nextPage = await client.timelines.fetchHome(
  minId: page.prevMinId,
);
```

カーソルパラメータの詳細は[ページネーション](../pagination.md)ガイドを参照してください。

## 非推奨: ダイレクトメッセージタイムライン

`fetchDirect()` は Mastodon 3.0.0 で削除されました。代わりに Conversations API を使用してください。
