---
sidebar_position: 7
---

# リスト（Lists）

`client.lists` API はリストの作成・管理、アカウントの追加・削除を提供します。

## リストの取得

### すべてのリスト

```dart
final lists = await client.lists.fetch();
for (final list in lists) {
  print('${list.id}: ${list.title}');
}
```

認証ユーザーが所有するすべてのリストを `List<MastodonList>` で返します。

### 単一のリスト

```dart
final list = await client.lists.fetchById('42');
print(list.title);
print(list.repliesPolicy); // "followed" | "list" | "none"
print(list.exclusive);     // true の場合、ホームタイムラインからリストメンバーを除外
```

## リストの作成

```dart
final list = await client.lists.create(
  title: '開発者フレンド',
  repliesPolicy: 'list',   // リストメンバー同士の返信を表示
  exclusive: false,
);
print(list.id);
```

`repliesPolicy` に指定できる値：
- `followed` — フォローしているユーザーへの返信を表示
- `list` — リストメンバーへの返信を表示
- `none` — 返信をすべて非表示

`exclusive` を `true` にすると、リストメンバーの投稿がホームタイムラインから除外されます。

## リストの更新

```dart
final updated = await client.lists.update(
  '42',
  title: '親しい友人',
  repliesPolicy: 'followed',
  exclusive: true,
);
```

## リストの削除

```dart
await client.lists.delete('42');
```

## アカウントの管理

### リスト内のアカウント取得

```dart
final page = await client.lists.fetchAccounts(
  '42',
  limit: 40,
);

for (final account in page.items) {
  print(account.acct);
}
```

`MastodonPage<MastodonAccount>` を返します。`nextMaxId` と `prevMinId` でページネーションできます：

```dart
MastodonPage<MastodonAccount>? page = await client.lists.fetchAccounts('42');

while (page != null && page.nextMaxId != null) {
  page = await client.lists.fetchAccounts(
    '42',
    maxId: page.nextMaxId,
  );
  for (final account in page.items) {
    print(account.acct);
  }
}
```

ページネーションパラメータ：

| パラメータ | 説明 |
|-----------|------|
| `limit`   | 最大取得件数（デフォルト: 40、上限: 80。`0` で全件取得） |
| `maxId`   | 指定 ID より古い結果を返す |
| `sinceId` | 指定 ID より新しい結果を返す |
| `minId`   | 指定 ID の直後から前方向にページネーション |

### アカウントの追加

追加するアカウントは認証ユーザーがフォローしている必要があります。

```dart
await client.lists.addAccounts(
  '42',
  accountIds: ['100', '101', '102'],
);
```

### アカウントの削除

```dart
await client.lists.removeAccounts(
  '42',
  accountIds: ['101'],
);
```

## MastodonList モデル

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `id` | `String` | リストの内部 ID |
| `title` | `String` | リストのタイトル |
| `repliesPolicy` | `String` | 返信の表示ポリシー（`followed` / `list` / `none`） |
| `exclusive` | `bool` | ホームタイムラインからリストメンバーを除外するか |
