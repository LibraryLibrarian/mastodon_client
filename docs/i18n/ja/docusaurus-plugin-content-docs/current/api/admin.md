---
sidebar_position: 14
---

# Admin

Admin API はサーバー管理機能を提供します。すべてのエンドポイントには高い OAuth スコープ（通常 `admin:read:*` または `admin:write:*`）が必要です。適切なサーバー権限を持つアカウントでのみ使用してください。

## アカウント管理

`client.adminAccounts` は管理者向けのアカウント管理機能を提供します。

### アカウント一覧の取得

2 つのバージョンのエンドポイントが利用できます。

**v1** — boolean フィルターフラグ:

```dart
final page = await client.adminAccounts.fetch(
  pending: true,  // 承認待ちのアカウントのみ
  limit: 100,
);
for (final account in page.items) {
  print('${account.account?.acct} — ${account.email}');
}
```

利用可能なフィルター: `local`、`remote`、`active`、`pending`、`disabled`、`silenced`、`suspended`、`sensitized`、`staff`。検索パラメータ: `username`、`displayName`、`email`、`ip`、`byDomain`。ページネーション: `maxId`、`sinceId`、`minId`。デフォルト件数 100、最大 200。

**v2** — 構造化フィルターパラメータ（新規コードでの推奨）:

```dart
final page = await client.adminAccounts.fetchV2(
  origin: 'local',
  status: 'pending',
  limit: 50,
);
```

`origin` は `local` または `remote`。`status` は `active`、`pending`、`disabled`、`silenced`、`suspended` のいずれか。`permissions` に `staff` を渡すとスタッフアカウントのみに絞り込めます。`roleIds` でロール ID によるフィルタリング、`invitedBy` で招待者のアカウント ID によるフィルタリングが可能です。

### 単一アカウントの取得

```dart
final account = await client.adminAccounts.fetchById('12345');
print(account.ip);
print(account.confirmed);
```

### 保留中アカウントの承認・拒否

```dart
await client.adminAccounts.approve('12345');
await client.adminAccounts.reject('12345');
```

### モデレーションアクションの実行

```dart
await client.adminAccounts.performAction(
  '12345',
  MastodonAdminAccountActionRequest(
    type: 'suspend',
    reportId: '999',
    text: 'コミュニティガイドラインへの違反。',
    sendEmailNotification: true,
  ),
);
```

関連する未解決のレポートは自動的に解決されます。「ユーザーの管理」と「レポートの管理」権限が必要です。

### その他のモデレーション操作

```dart
await client.adminAccounts.enable('12345');       // 無効化されたアカウントを再有効化
await client.adminAccounts.unsilence('12345');    // サイレンスを解除
await client.adminAccounts.unsuspend('12345');    // サスペンドを解除
await client.adminAccounts.unsensitive('12345'); // センシティブフラグを解除
```

### アカウントデータの削除

```dart
await client.adminAccounts.delete('12345');
```

サスペンドされたアカウントのデータを完全に削除します。「ユーザーデータの削除」権限が必要です。

## レポート管理

`client.adminReports` はユーザーが送信した通報を管理します。

### レポート一覧の取得

```dart
final page = await client.adminReports.fetch(
  resolved: false,  // 未解決のレポートのみ
  limit: 100,
);
```

`accountId`（通報者）や `targetAccountId`（通報対象）でフィルタリングできます。`resolved: true` で解決済みのレポートのみを表示します。ページネーションは `maxId`、`sinceId`、`minId` で行います。

### レポートの取得・更新

```dart
final report = await client.adminReports.fetchById('42');

final updated = await client.adminReports.update(
  '42',
  MastodonAdminReportUpdateRequest(assignedAccountId: 'moderator-id'),
);
```

### 担当者の割り当てと解決

```dart
await client.adminReports.assignToSelf('42');  // 自分に割り当て
await client.adminReports.unassign('42');       // 割り当て解除
await client.adminReports.resolve('42');        // 解決済みにする
await client.adminReports.reopen('42');         // 解決済みを再オープン
```

## ドメイン管理

### ドメイン許可リスト

許可リストモードで動作するサーバーでは、`client.adminDomainAllows` でフェデレーションを許可するリモートドメインを管理します。

```dart
// 許可済みドメインの一覧
final page = await client.adminDomainAllows.fetch();

// ドメインを許可
final entry = await client.adminDomainAllows.create(domain: 'example.social');

// 許可済みドメインを削除
await client.adminDomainAllows.delete(entry.id);
```

### ドメインブロックリスト

`client.adminDomainBlocks` でリモートドメインのフェデレーションブロックを管理します。

```dart
// ブロック済みドメインの一覧
final page = await client.adminDomainBlocks.fetch();

// ドメインをブロック
final block = await client.adminDomainBlocks.create(
  MastodonAdminDomainBlockRequest(
    domain: 'spam.example',
    severity: 'suspend',
    rejectMedia: true,
    rejectReports: true,
    privateComment: '既知のスパムインスタンス',
    publicComment: 'スパム行為のためサスペンド。',
  ),
);

// ブロックを更新
await client.adminDomainBlocks.update(block.id, updatedRequest);

// ブロックを削除
await client.adminDomainBlocks.delete(block.id);
```

## IP ブロック

`client.adminIpBlocks` で IP アドレス範囲のブロックを管理します。

```dart
// IP ブロック一覧
final page = await client.adminIpBlocks.fetch();

// IP ブロックを作成
final block = await client.adminIpBlocks.create(
  MastodonAdminIpBlockCreateRequest(
    ip: '192.0.2.0/24',
    severity: 'no_access',
    comment: '悪意のあるサブネット',
  ),
);

// 更新
await client.adminIpBlocks.update(
  block.id,
  MastodonAdminIpBlockUpdateRequest(severity: 'sign_up_block'),
);

// 削除
await client.adminIpBlocks.delete(block.id);
```

## メールブロック

### 正規化メールアドレスのブロック

`client.adminCanonicalEmailBlocks` は正規化（canonical）されたメールアドレスをブロックします。アドレスのバリエーションを使った再登録を防ぐために使用します。

```dart
// ブロック一覧
final page = await client.adminCanonicalEmailBlocks.fetch();

// メールアドレスが既存のブロックに一致するかテスト
final matches = await client.adminCanonicalEmailBlocks.test(
  email: 'test@example.com',
);

// メールアドレスでブロック（正規化ハッシュはサーバー側で計算）
final block = await client.adminCanonicalEmailBlocks.create(
  email: 'spammer@example.com',
);

// 事前計算済みハッシュでブロック
await client.adminCanonicalEmailBlocks.create(
  canonicalEmailHash: 'sha256hashvalue',
);

// 削除
await client.adminCanonicalEmailBlocks.delete(block.id);
```

### メールドメインのブロック

`client.adminEmailDomainBlocks` で特定のメールドメインからの新規登録を防止します。

```dart
// ブロック済みメールドメインの一覧
final page = await client.adminEmailDomainBlocks.fetch();

// ドメインをブロック
final block = await client.adminEmailDomainBlocks.create(
  domain: 'disposable-mail.example',
);

// 削除
await client.adminEmailDomainBlocks.delete(block.id);
```

## Admin タグ管理

`client.adminTags` でハッシュタグの管理者向け制御を行います。

### タグの一覧取得と個別取得

```dart
final page = await client.adminTags.fetch(limit: 50);
final tag = await client.adminTags.fetchById('tag-id');
```

### タグの更新

```dart
final updated = await client.adminTags.update(
  'tag-id',
  displayName: 'Dart',
  listable: true,
  trendable: true,
  usable: true,
);
```

すべてのフィールドは省略可能で、指定した値のみ変更されます。`listable` は公開リストへの表示可否、`trendable` はトレンドエンドポイントへの掲載可否、`usable` は投稿での使用可否を制御します。

## Admin トレンド管理

`client.adminTrends` では未審査のトレンドコンテンツを確認し、公開前に承認または拒否できます。

### トレンドリンク

```dart
final links = await client.adminTrends.fetchLinks();
await client.adminTrends.approveLink(id: links.first.id);
await client.adminTrends.rejectLink(id: links.first.id);
```

### リンクのパブリッシャー

```dart
final publishers = await client.adminTrends.fetchPublishers();
await client.adminTrends.approvePublisher(id: publishers.first.id);
await client.adminTrends.rejectPublisher(id: publishers.first.id);
```

### トレンド投稿

```dart
final statuses = await client.adminTrends.fetchStatuses();
await client.adminTrends.approveStatus(id: statuses.first.id);
await client.adminTrends.rejectStatus(id: statuses.first.id);
```

### トレンドタグ

```dart
final tags = await client.adminTrends.fetchTags();
await client.adminTrends.approveTag(id: tags.first.id);
await client.adminTrends.rejectTag(id: tags.first.id);
```

読み取りエンドポイントには `admin:read` スコープ、書き込みエンドポイントには `admin:write` スコープが必要です。

## 統計情報

これらのアナリティクス系エンドポイントはすべて `POST` を使用し、リクエストボディにメトリクスと集計期間を指定します。

### メジャー（定量データ）

```dart
final measures = await client.adminMeasures.fetch(
  MastodonAdminMeasureRequest(
    keys: ['active_users', 'new_users'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
for (final m in measures) {
  print('${m.key}: ${m.total}');
}
```

アクティブユーザー数、新規登録数、インタラクション数などの時系列データを返します。

### ディメンション（定性データ）

```dart
final dimensions = await client.adminDimensions.fetch(
  MastodonAdminDimensionRequest(
    keys: ['languages', 'sources'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
```

言語分布やクライアントソフトウェアのバージョンなどのカテゴリ別集計を返します。

### リテンション（コホートデータ）

```dart
final cohorts = await client.adminRetention.fetch(
  MastodonAdminRetentionRequest(
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 3, 31),
    frequency: 'month',
  ),
);
```

登録時期と以降のアクティビティでグループ化したユーザーリテンションのコホートデータを返します。3 つのアナリティクス系エンドポイントすべてに `admin:read` OAuth スコープが必要です。
