---
sidebar_position: 3
---

# ページネーション

Mastodon API はカーソルベースのページネーションを使用します。本ライブラリでは `MastodonPage<T>` でこれを抽象化しています。

## MastodonPage の構造

```dart
class MastodonPage<T> {
  final List<T> items;      // ページ内のアイテム一覧
  final String? nextMaxId;  // 次ページ用カーソル（古い方向）
  final String? prevMinId;  // 前ページ用カーソル（新しい方向）
}
```

## 基本的な使い方

### 最初のページを取得

```dart
final page = await client.notifications.fetch(limit: 20);

for (final notification in page.items) {
  print(notification.type);
}
```

### 次のページを取得（古い方向）

`nextMaxId` を `maxId` パラメータに渡します。

```dart
if (page.nextMaxId != null) {
  final nextPage = await client.notifications.fetch(
    limit: 20,
    maxId: page.nextMaxId,
  );
}
```

### 前のページを取得（新しい方向）

`prevMinId` を `minId` パラメータに渡します。

```dart
if (page.prevMinId != null) {
  final prevPage = await client.notifications.fetch(
    limit: 20,
    minId: page.prevMinId,
  );
}
```

## ページネーションパラメータ

| パラメータ | 方向 | 説明 |
|-----------|------|------|
| `maxId` | 古い方向 | この ID より前の結果を返す |
| `sinceId` | 新しい方向 | この ID より後の結果を返す（ギャップあり） |
| `minId` | 新しい方向 | この ID の直後から結果を返す（即時ページ送り） |
| `limit` | - | 最大取得件数（省略時はサーバーデフォルト） |

### `sinceId` と `minId` の違い

- `sinceId`: 指定 ID より新しい結果を **最新から** `limit` 件返す（間がスキップされる可能性あり）
- `minId`: 指定 ID の **直後から** `limit` 件返す（ギャップなしの前方ページ送り）

リアルタイムの更新チェックには `sinceId`、順次ページ送りには `minId` が適しています。

## すべてのページを巡回する例

```dart
Future<List<MastodonNotification>> fetchAll() async {
  final all = <MastodonNotification>[];
  String? maxId;

  while (true) {
    final page = await client.notifications.fetch(
      limit: 40,
      maxId: maxId,
    );
    all.addAll(page.items);

    if (page.nextMaxId == null) break;
    maxId = page.nextMaxId;
  }

  return all;
}
```

:::caution
大量のデータを一度に取得するとサーバーに負荷がかかります。レート制限にも注意してください。
:::

## 対応 API

ページネーションを返す主な API：

- `client.notifications.fetch()` — 通知一覧
- `client.accounts.fetchFollowers()` — フォロワー一覧
- `client.accounts.fetchFollowing()` — フォロー一覧
- `client.accounts.fetchStatuses()` — アカウントの投稿一覧
- `client.timelines.*` — 各種タイムライン
- `client.favourites.fetch()` — お気に入り一覧
- `client.bookmarks.fetch()` — ブックマーク一覧
- `client.blocks.fetch()` — ブロック一覧
- `client.mutes.fetch()` — ミュート一覧
