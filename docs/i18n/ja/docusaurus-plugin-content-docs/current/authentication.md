---
sidebar_position: 2
---

# 認証

Mastodon は OAuth 2.0 を採用しています。ほとんどの API エンドポイントにはアクセストークンが必要です。

## 認証フロー概要

```
1. アプリ登録     → client_id / client_secret を取得
2. ユーザー認可   → ブラウザで認可画面を表示 → 認可コード取得
3. トークン取得   → 認可コードをアクセストークンに交換
```

## Step 1: アプリの登録

```dart
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

final clientId = app.clientId!;
final clientSecret = app.clientSecret!;
```

`redirectUris` に `urn:ietf:wg:oauth:2.0:oob` を指定すると、OOB（Out-of-Band）フローとなり、認可コードが画面に表示されます。Web アプリやモバイルアプリでは、コールバック URL を指定します。

## Step 2: ユーザー認可

認可 URL をブラウザで開き、ユーザーに許可を求めます。この部分はプラットフォーム依存のため、本ライブラリのスコープ外です。

```dart
// 認可 URL の組み立て例
final authorizeUrl = Uri.parse('${baseUrl}/oauth/authorize').replace(
  queryParameters: {
    'client_id': clientId,
    'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
    'response_type': 'code',
    'scope': 'read write push',
  },
);
// → この URL をブラウザで開く
```

ユーザーが許可すると、認可コードが返されます。

## Step 3: アクセストークンの取得

```dart
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode, // Step 2 で取得した認可コード
);

print(token.accessToken); // API 呼び出しに使用するトークン
```

取得したトークンで新しいクライアントを初期化します。

```dart
final authenticatedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## トークンの失効

```dart
await client.oauth.revokeToken(
  clientId: clientId,
  clientSecret: clientSecret,
  token: accessToken,
);
```

## クライアントクレデンシャル

ユーザー操作なしでアプリ専用トークンを取得する場合：

```dart
final token = await client.oauth.obtainToken(
  grantType: 'client_credentials',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  scope: 'read',
);
```

このトークンでは公開情報のみアクセスできます。

## サーバーメタデータの取得

サーバーがサポートするスコープやエンドポイント情報を事前に取得できます。

```dart
final metadata = await client.oauth.fetchServerMetadata();
print(metadata.scopesSupported);
```

## スコープ一覧

| スコープ | 説明 |
|---------|------|
| `read` | すべての読み取り操作 |
| `write` | すべての書き込み操作 |
| `push` | Web Push 通知の受信 |
| `follow` | フォロー関係の変更（`read:follows` + `write:follows` のエイリアス） |
| `admin:read` | 管理者向け読み取り操作 |
| `admin:write` | 管理者向け書き込み操作 |

より細かいスコープ（`read:accounts`, `write:statuses` 等）も利用可能です。
詳細は [Mastodon 公式ドキュメント](https://docs.joinmastodon.org/api/oauth-scopes/) を参照してください。
