---
sidebar_position: 8
---

# プッシュ通知（Push Notifications）

`client.push` API は Web Push サブスクリプションを管理します。[Web Push プロトコル](https://www.rfc-editor.org/rfc/rfc8030)に準拠しており、アプリケーションがバックグラウンドで通知を受け取れるようにします。

## サブスクリプションの作成

プッシュエンドポイントと VAPID キーを指定して、新しい Web Push サブスクリプションを作成します：

```dart
final subscription = await client.push.create(
  MastodonPushSubscriptionRequest(
    endpoint: 'https://push.example.com/subscription/abc123',
    p256dh: '<Base64url エンコードされた P-256 ECDH 公開鍵>',
    auth: '<Base64url エンコードされた認証シークレット>',
    standard: true,
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: true,
      reblog: true,
      favourite: true,
      poll: true,
    ),
    policy: 'followed', // all | followed | follower | none
  ),
);

print(subscription.id);
print(subscription.serverKey); // プッシュメッセージの検証に使用
```

### 通知タイプ

`MastodonPushAlertSettings` には以下のフィールドを任意の組み合わせで指定できます。`null` のフィールドはリクエストから除外され、変更されません。

| フィールド | 説明 |
|-----------|------|
| `mention` | 投稿でメンションされた |
| `quote` | 投稿が引用された |
| `status` | フォローしているユーザーが新規投稿した |
| `reblog` | 投稿がブーストされた |
| `follow` | 新しいフォロワーが増えた |
| `followRequest` | フォローリクエストが届いた |
| `favourite` | 投稿がお気に入りされた |
| `poll` | 投票したまたは作成したアンケートが終了した |
| `update` | 操作した投稿が編集された |
| `quotedUpdate` | 引用した投稿が編集された |
| `adminSignUp` | 新規ユーザーが登録した（管理者専用） |
| `adminReport` | 新しい通報が届いた（管理者専用） |

### ポリシー値

| 値 | 説明 |
|----|------|
| `all` | すべてのユーザーからの通知を受け取る |
| `followed` | フォローしているユーザーからの通知のみ受け取る |
| `follower` | フォロワーからの通知のみ受け取る |
| `none` | プッシュ通知をすべて無効にする |

## 現在のサブスクリプションの取得

```dart
final subscription = await client.push.fetch();
print(subscription.endpoint);
print(subscription.alerts.mention);
print(subscription.policy);
```

## 通知設定の更新

サブスクリプションを再作成せずに通知設定やポリシーを変更するには `update` を使います。変更できるのは `data` 部分（alerts と policy）のみです。

```dart
final updated = await client.push.update(
  MastodonPushSubscriptionUpdateRequest(
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: false,
    ),
    policy: 'all',
  ),
);
```

## サブスクリプションの解除

```dart
await client.push.delete();
```

現在の Web Push サブスクリプションを削除します。解除後に `fetch` を呼び出すと `MastodonNotFoundException` がスローされます。

## MastodonWebPushSubscription モデル

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `id` | `String` | サブスクリプション ID |
| `endpoint` | `String` | プッシュエンドポイント URL |
| `serverKey` | `String` | プッシュメッセージ検証用のサーバー公開鍵 |
| `alerts` | `MastodonPushAlerts` | 有効な通知設定 |
| `policy` | `String` | 通知ポリシー |
| `standard` | `bool?` | 標準化された Web Push 仕様に準拠しているか（Mastodon 4.4 以降） |
