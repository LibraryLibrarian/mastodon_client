---
sidebar_position: 13
---

# その他の API

このページでは、予約投稿、トレンド、プロフィール画像管理、アプリ登録、メール確認、非同期リフレッシュを説明します。

## 予約投稿

`client.scheduledStatuses` を使って、将来の公開が予約された投稿を管理します。予約投稿を作成するには、`client.statuses.create` に `scheduledAt` を渡します。

### 予約投稿の一覧

```dart
final page = await client.scheduledStatuses.fetch(limit: 20);
for (final s in page.items) {
  print('${s.id} は ${s.scheduledAt} に予約されています');
}

// ページネーション
if (page.nextMaxId != null) {
  final next = await client.scheduledStatuses.fetch(maxId: page.nextMaxId);
}
```

`MastodonPage<MastodonScheduledStatus>` を返します。デフォルトの取得件数は 20 件で、最大は 40 件です。

### 単一の予約投稿を取得

```dart
final s = await client.scheduledStatuses.fetchById('9876');
```

### 予約日時の変更

新しい日時は現在時刻から 5 分以上先である必要があります。ISO 8601 形式で指定します:

```dart
final updated = await client.scheduledStatuses.update(
  '9876',
  scheduledAt: '2025-12-31T23:59:00.000Z',
);
```

### 予約の取り消し

```dart
await client.scheduledStatuses.delete('9876');
```

## トレンド

トレンド系エンドポイントはすべて公開情報であり、認証不要です。`client.trends` を使用します。

### トレンドのタグ

```dart
final tags = await client.trends.fetchTags(limit: 10);
for (final tag in tags) {
  print('#${tag.name}');
}
```

過去 1 週間で使用数が増加しているタグを、内部のトレンドスコア順に返します。デフォルトの取得件数は 10 件で、最大は 20 件です。ページネーションには `offset` を使用します。

### トレンドの投稿

```dart
final statuses = await client.trends.fetchStatuses(limit: 20);
```

通常より多くのインタラクションを受けている投稿を返します。デフォルトの取得件数は 20 件で、最大は 40 件です。

### トレンドのリンク

```dart
final links = await client.trends.fetchLinks(limit: 10);
for (final link in links) {
  print(link.url);
}
```

ネットワーク上で頻繁にシェアされているリンクを返します。デフォルトの取得件数は 10 件で、最大は 20 件です。

3 つのメソッドすべてで `offset` パラメータによるオフセットページネーションが利用できます。

## プロフィール画像管理

`client.profile` を使って、プロフィールのアバターとヘッダー画像を削除できます。

### アバターの削除

```dart
final account = await client.profile.deleteAvatar();
```

### ヘッダーの削除

```dart
final account = await client.profile.deleteHeader();
```

どちらも更新後の `MastodonCredentialAccount` を返します。画像が設定されていない場合でも正常終了します。`write:accounts` OAuth スコープが必要です。

新しいアバターやヘッダーをアップロードするには `client.accounts.updateCredentials` を使用してください。

## アプリ登録

`client.apps` を使って OAuth アプリケーションの登録とトークン検証を行います。

### アプリケーションの登録

```dart
final app = await client.apps.create(
  clientName: 'My Mastodon App',
  redirectUris: ['myapp://oauth/callback'],
  scopes: 'read write push',
  website: 'https://example.com',
);
print(app.clientId);
print(app.clientSecret);
```

`redirectUris` は必須パラメータです。OOB（Out-of-Band）フローを使用する場合は `['urn:ietf:wg:oauth:2.0:oob']` を渡します。`scopes` を省略した場合は `read` がデフォルトになります。`MastodonCredentialApplication` を返します。

### アプリ認証情報の確認

```dart
final app = await client.apps.verifyCredentials();
print(app.name);
```

`MastodonApplication` を返します。トークンが無効な場合は認証エラーが発生します。

## メール確認

`client.emails` は新規登録アカウントの確認メール再送を扱います。

### 確認メールの再送

```dart
await client.emails.resendConfirmation();

// メールアドレスを変更しながら再送することも可能
await client.emails.resendConfirmation(email: 'new@example.com');
```

`email` を指定した場合、確認メールを送る前に未確認のメールアドレスが更新されます。

### 確認状態のチェック

```dart
await client.emails.checkConfirmation();
```

どちらのメソッドも、未確認アカウントを作成したクライアントから取得したトークンが必要です。

## 非同期リフレッシュ

`client.asyncRefreshes` を使って、バックグラウンドリフレッシュジョブの進行状況を確認できます。Mastodon 4.4.0 で追加された実験的な API です。

他の API レスポンスに `Mastodon-Async-Refresh` ヘッダーが含まれている場合、その値がポーリングに使用する ID です:

```dart
final refresh = await client.asyncRefreshes.fetch('ヘッダーから取得した ID');
print(refresh.complete); // 完了したら true
```

`MastodonAsyncRefresh` を返します。`read` OAuth スコープが必要です。
