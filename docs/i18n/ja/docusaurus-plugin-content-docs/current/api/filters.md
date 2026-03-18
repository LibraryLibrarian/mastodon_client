---
sidebar_position: 6
---

# フィルター（Filters）

`client.filters` API はサーバーサイドのコンテンツフィルターを管理します（Mastodon 4.0 以降）。フィルターは指定したキーワードや個別の投稿 ID にマッチした投稿を非表示にしたり警告を表示したりします。

## フィルターの取得

### 全フィルター

```dart
final filters = await client.filters.fetch();

for (final filter in filters) {
  print('${filter.title}: ${filter.filterAction}');
}
```

### 特定のフィルター

```dart
final filter = await client.filters.fetchById('1');
print(filter.title);
```

## フィルターの作成

`title` と `context` は必須です。`context` はフィルターを適用する配置場所のリストです。

| 値 | 適用場所 |
|---|---|
| `home` | ホームおよびリストタイムライン |
| `notifications` | 通知タイムライン |
| `public` | パブリックタイムライン |
| `thread` | 会話スレッド内 |
| `account` | プロフィール閲覧時 |

```dart
final filter = await client.filters.create(
  title: 'ネタバレを隠す',
  context: ['home', 'public'],
  filterAction: 'warn',
  expiresIn: 86400, // 1日後に期限切れ。期限なしの場合は省略
);
```

`filterAction` には `'warn'`（警告を表示）、`'hide'`（投稿を非表示）、`'blur'` を指定できます。省略するとサーバーのデフォルトが適用されます。

### キーワード付きで作成する

`keywordsAttributes` を指定すると、作成と同時にキーワードを追加できます。

```dart
final filter = await client.filters.create(
  title: '選挙関連',
  context: ['home', 'notifications', 'public'],
  filterAction: 'warn',
  keywordsAttributes: [
    MastodonFilterKeywordParam(keyword: '選挙', wholeWord: true),
    MastodonFilterKeywordParam(keyword: '投票'),
  ],
);
```

## フィルターの更新

すべてのパラメータは任意です。指定したフィールドのみ更新されます。

```dart
final updated = await client.filters.update(
  '1',
  title: '新しいタイトル',
  filterAction: 'hide',
);
```

## フィルターの削除

```dart
await client.filters.delete('1');
```

## フィルターキーワード

キーワードはフィルターが照合するフレーズです。各キーワードはいずれかのフィルターに属します。

### キーワード一覧の取得

```dart
final keywords = await client.filters.fetchKeywords('1');

for (final kw in keywords) {
  print('${kw.keyword}（単語境界: ${kw.wholeWord}）');
}
```

### キーワードの追加

```dart
final keyword = await client.filters.createKeyword(
  '1', // フィルター ID
  keyword: 'ネタバレ',
  wholeWord: true,
);
```

### キーワードの取得

```dart
final keyword = await client.filters.fetchKeywordById('42');
```

### キーワードの更新

```dart
final updated = await client.filters.updateKeyword(
  '42',
  keyword: 'ネタバレ注意',
  wholeWord: false,
);
```

### キーワードの削除

```dart
await client.filters.deleteKeyword('42');
```

### フィルター更新時にキーワードをまとめて変更する

`update()` に `keywordsAttributes` を渡すと、1回のリクエストで複数キーワードの追加・更新・削除ができます。削除する場合は対象エントリに `destroy: true` を設定します。

```dart
await client.filters.update(
  '1',
  keywordsAttributes: [
    MastodonFilterKeywordUpdateParam(keyword: '新キーワード'),           // 追加
    MastodonFilterKeywordUpdateParam(id: '10', keyword: '変更後'),      // 更新
    MastodonFilterKeywordUpdateParam(id: '11', keyword: '', destroy: true), // 削除
  ],
);
```

## フィルター対象投稿

キーワードマッチに加えて、特定の投稿をフィルターに直接追加することもできます。

### フィルター対象投稿の一覧取得

```dart
final statuses = await client.filters.fetchStatuses('1');
```

### 投稿をフィルターに追加する

```dart
final filterStatus = await client.filters.createStatus(
  '1', // フィルター ID
  statusId: '109876543210',
);
```

### 特定のフィルター対象投稿エントリを取得する

```dart
final filterStatus = await client.filters.fetchStatusById('99');
```

### 投稿をフィルターから削除する

```dart
await client.filters.deleteStatus('99');
```

## 非推奨: v1 フィルター

v1 フィルター API は Mastodon 4.0.0 で非推奨になりました。古いインスタンスとの互換性のためにのみ提供されています。

| v1 メソッド | v2 の代替 |
|---|---|
| `fetchV1()` | `fetch()` |
| `fetchByIdV1(id)` | `fetchById(id)` |
| `createV1(phrase:, context:)` | `create(title:, context:)` |
| `updateV1(id, phrase:, context:)` | `update(id)` |
| `deleteV1(id)` | `delete(id)` |

v2 との主な違い:

- v1 はキーワードリストではなく単一の `phrase` 文字列を使用する
- `irreversible: true` を設定すると、マッチした投稿がホームと通知から完全に除去される（クライアント側の警告なし）
- `deleteV1()` は親フィルターではなく `FilterKeyword` レコードのみ削除する
- v1 フィルターはクライアントサイドのみで、サーバーは適用を強制しない
