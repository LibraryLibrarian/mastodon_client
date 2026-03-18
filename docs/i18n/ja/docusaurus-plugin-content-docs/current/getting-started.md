---
sidebar_position: 1
slug: /
---

# はじめに

mastodon_client は pure Dart で実装された Mastodon API クライアントライブラリです。
Flutter・Dart サーバーサイド・CLI ツールなど、Dart が動作するあらゆる環境で使用できます。

## インストール

`pubspec.yaml` に依存関係を追加します。

```yaml
dependencies:
  mastodon_client: ^0.0.1
```

その後、依存関係を取得します。

```bash
dart pub get
```

## 基本的な使い方

### クライアントの初期化

```dart
import 'package:mastodon_client/mastodon_client.dart';

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_access_token',
);
```

`baseUrl` にはスキームを含む Mastodon サーバーの URL を指定します。
`accessToken` は認証が不要なエンドポイントのみを使用する場合は省略できます。

### 最初の API 呼び出し

サーバー情報を取得する例です。認証不要で動作します。

```dart
final instance = await client.instance.fetch();
print(instance.title);       // サーバー名
print(instance.description); // サーバーの説明
```

認証済みユーザーの情報を取得する例です。

```dart
final me = await client.accounts.verifyCredentials();
print(me.displayName); // 表示名
print(me.acct);        // ユーザー名
```

### API の構造

すべての API は `MastodonClient` のプロパティとして公開されており、名前空間として機能します。

```dart
client.accounts     // アカウント操作
client.statuses     // 投稿操作
client.timelines    // タイムライン取得
client.notifications // 通知操作
client.media        // メディアアップロード
client.search       // 検索
client.oauth        // OAuth トークン操作
// ... その他多数
```

### ログ出力の制御

デフォルトで HTTP リクエスト/レスポンスのログが標準出力に出力されます。

```dart
// ログを無効化
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);

// カスタムロガーを使用
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // 独自のログ処理
  }),
);
```

詳細は [ロギング](./advanced/logging.md) を参照してください。

## 次のステップ

- [認証](./authentication.md) — OAuth フローによるアクセストークンの取得
- [ページネーション](./pagination.md) — カーソルベースのページ送り
- [エラーハンドリング](./error-handling.md) — 例外階層と catch パターン
