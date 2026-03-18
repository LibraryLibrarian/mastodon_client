---
sidebar_position: 11
---

# モデレーション

ブロック中のアカウント、ミュート中のアカウント、ドメインブロック、通報を管理する API を説明します。

リスト系のメソッドはすべて `MastodonPage<T>` を返します。`Link` レスポンスヘッダーから解析された `nextMaxId` と `prevMinId` カーソルが含まれます。詳細は[ページネーション](../pagination.md)のガイドを参照してください。

---

## ブロック中のアカウント

### ブロック一覧の取得

```dart
final page = await client.blocks.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// 次のページ
if (page.nextMaxId != null) {
  final next = await client.blocks.fetch(maxId: page.nextMaxId);
}
```

パラメーター:

| パラメーター | デフォルト | 最大値 | 説明 |
|-------------|-----------|-------|------|
| `limit`     | 40        | 80    | 取得件数 |
| `maxId`     | —         | —     | このID より古い結果を返す |
| `sinceId`   | —         | —     | このID より新しい結果を返す |
| `minId`     | —         | —     | このID の後から最古順に返す（逆方向ページネーション） |

アカウントのブロック・ブロック解除は `client.accounts.block()` および `client.accounts.unblock()` を使用してください。

---

## ミュート中のアカウント

### ミュート一覧の取得

```dart
final page = await client.mutes.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// 次のページ
if (page.nextMaxId != null) {
  final next = await client.mutes.fetch(maxId: page.nextMaxId);
}
```

パラメーター:

| パラメーター | デフォルト | 最大値 | 説明 |
|-------------|-----------|-------|------|
| `limit`     | 40        | 80    | 取得件数 |
| `maxId`     | —         | —     | このID より古い結果を返す |
| `sinceId`   | —         | —     | このID より新しい結果を返す |

アカウントのミュート・ミュート解除は `client.accounts.mute()` および `client.accounts.unmute()` を使用してください。

---

## ドメインブロック

ユーザーレベルのドメインブロックは、指定ドメインからの投稿と通知をすべて非表示にします。インスタンスレベルのドメインブロック（`client.instance.fetchDomainBlocks()`）とは別のものです。

### ブロック中のドメイン一覧

```dart
final page = await client.domainBlocks.fetch(limit: 100);
for (final domain in page.items) {
  print(domain);
}
```

パラメーター:

| パラメーター | デフォルト | 最大値 | 説明 |
|-------------|-----------|-------|------|
| `limit`     | 100       | 200   | 取得件数 |
| `maxId`     | —         | —     | このID より古い結果を返す |
| `sinceId`   | —         | —     | このID より新しい結果を返す |
| `minId`     | —         | —     | このID の後から最古順に返す（逆方向ページネーション） |

### ドメインをブロックする

```dart
await client.domainBlocks.block('spam.example.com');
```

ドメインをブロックすると、そのドメインのアカウントからの公開投稿と通知がすべて非表示になり、既存のフォロワーが削除され、そのドメインへの新規フォローもできなくなります。

### ドメインブロックを解除する

```dart
await client.domainBlocks.unblock('spam.example.com');
```

---

## 通報

### アカウントを通報する

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    comment: 'スパム投稿を繰り返しています。',
    category: 'spam',
  ),
);
print(report.id);
```

### 特定の投稿を証拠として添付する

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    statusIds: ['111', '222'],
    comment: 'これらの投稿はルールに違反しています。',
    category: 'violation',
    ruleIds: ['1', '3'],
  ),
);
```

### リモート管理者への転送

`forward: true` を設定すると、通報内容が報告対象アカウントのホームサーバーの管理者にも送信されます。

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '67890',
    comment: 'リモートアカウントからの嫌がらせです。',
    forward: true,
  ),
);
```

### リクエストフィールド一覧

| フィールド   | 必須 | 説明 |
|------------|------|------|
| `accountId`  | Yes | 通報対象アカウントの ID |
| `statusIds`  | No  | 証拠として添付する投稿の ID リスト |
| `comment`    | No  | 通報理由（最大 1000 文字） |
| `forward`    | No  | リモートサーバーの管理者に転送する |
| `category`   | No  | `spam`・`legal`・`violation`・`other` のいずれか |
| `ruleIds`    | No  | 違反したルールの ID（`violation` カテゴリーで使用） |
