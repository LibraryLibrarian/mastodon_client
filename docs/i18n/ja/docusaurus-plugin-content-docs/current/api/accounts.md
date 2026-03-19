---
sidebar_position: 1
---

# アカウント

`client.accounts` API はアカウント情報の取得・管理操作を提供します。

## アカウントの取得

### ID で取得

```dart
final account = await client.accounts.fetchById('12345');
print(account.displayName);
print(account.followersCount);
```

### ユーザー名（acct）で取得

```dart
final account = await client.accounts.lookup('user@mastodon.social');
```

サーバーが lookup エンドポイントをサポートしていない場合、ライブラリが自動的に検索ベースのフォールバックを行います。

### 認証ユーザー

```dart
final me = await client.accounts.verifyCredentials();
print(me.source); // 認証ユーザーのみ利用可能な追加フィールド
```

### 複数アカウント

```dart
final accounts = await client.accounts.fetchMultiple(['1', '2', '3']);
```

### 検索

```dart
final results = await client.accounts.search(
  'keyword',
  limit: 10,
  resolve: true, // WebFinger でリモートアカウントを解決
);
```

## ソーシャルグラフ

### フォロワーとフォロー

どちらもページネーション対応の `MastodonPage<MastodonAccount>` を返します。

```dart
final followers = await client.accounts.fetchFollowers('12345', limit: 40);
final following = await client.accounts.fetchFollowing('12345', limit: 40);
```

非公開アカウントの場合、エラーではなく空のページが返されます。

### リレーションシップ

```dart
final rels = await client.accounts.fetchRelationships(['12345', '67890']);
for (final rel in rels) {
  print('${rel.id}: following=${rel.following}, followedBy=${rel.followedBy}');
}
```

### 共通フォロー

```dart
final familiar = await client.accounts.fetchFamiliarFollowers(['12345']);
```

## フォロー / アンフォロー

```dart
// オプション付きフォロー
final rel = await client.accounts.follow(
  '12345',
  reblogs: true,        // ホームタイムラインにブーストを表示
  notify: true,         // 新規投稿時に通知を受け取る
  languages: ['en'],    // これらの言語の投稿のみ表示
);

// アンフォロー
await client.accounts.unfollow('12345');
```

## ブロック / ミュート

```dart
// ブロック
await client.accounts.block('12345');
await client.accounts.unblock('12345');

// 期間付きミュート
await client.accounts.mute('12345', duration: 3600); // 1時間
await client.accounts.unmute('12345');
```

## プロフィール操作

### プロフィール更新

```dart
final updated = await client.accounts.updateCredentials(
  MastodonCredentialAccountUpdateRequest(
    displayName: 'New Name',
    note: 'Updated bio',
  ),
);
```

### おすすめユーザー（プロフィールに表示）

```dart
await client.accounts.endorse('12345');   // プロフィールに表示
await client.accounts.unendorse('12345'); // プロフィールから削除
```

### プライベートメモ

```dart
await client.accounts.setNote('12345', comment: 'カンファレンスで会った');
```

## アカウントの投稿一覧

```dart
final page = await client.accounts.fetchStatuses(
  '12345',
  limit: 20,
  excludeReplies: true,
  excludeReblogs: true,
);
```

利用可能なフィルター: `excludeReplies`, `excludeReblogs`, `onlyMedia`, `pinned`, `tagged`
