[English](README.md) | [简体中文](README.zh-Hans.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [한국어](README.ko.md)

# mastodon_client

pure Dart で実装された [Mastodon](https://joinmastodon.org/) APIクライアントライブラリ。  
主要なAPIカテゴリへの型付きアクセスを提供、OAuth サポート、カーソルベースのページネーション、構造化されたエラーハンドリングを組み込み。

> **ベータ版**: API実装は完了していますが、テストカバレッジは最小限です。テスト結果に基づき、レスポンスモデルやメソッドシグネチャが変更される可能性があります。詳細は [CHANGELOG](CHANGELOG.md) を参照してください。

## 機能

- Mastodonの主要APIカテゴリをカバー（アカウント、投稿、タイムライン、通知、メディアなど）
- OAuth 2.0 トークン管理（取得、失効、PKCE サポート）
- `MastodonPage<T>` によるカーソルベースのページネーション
- 網羅的なエラーハンドリングのための sealed 例外階層
- 自動的な v2/v1 フォールバックと処理ポーリングを備えた非同期メディアアップロード
- 交換可能な `Logger` インターフェースによる設定可能なロギング
- pure Dart — Flutter への依存は不要

## インストール

`pubspec.yaml` にパッケージを追加してください:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.1
```

次のコマンドを実行してください:

```
dart pub get
```

## クイックスタート

```dart
import 'package:mastodon_client/mastodon_client.dart';

void main() async {
  final client = MastodonClient(
    baseUrl: 'https://mastodon.social',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  // Fetch the authenticated user
  final me = await client.accounts.verifyCredentials();
  print(me.displayName);

  // Post a status
  await client.statuses.create(
    MastodonStatusCreateRequest(
      status: 'Hello from mastodon_client!',
      visibility: MastodonVisibility.public,
    ),
  );

  // Paginated home timeline
  final page = await client.timelines.fetchHome(limit: 20);
  for (final status in page.items) {
    print(status.content);
  }
}
```

## API 概要

`MastodonClient` は以下のプロパティを公開しており、それぞれが Mastodon API の異なる領域をカバーしています:

| プロパティ | 説明 |
|---|---|
| `accounts` | アカウント情報、検索、フォロー、ブロック、ミュート、プロフィール更新 |
| `statuses` | 投稿の作成・編集・削除、ブースト、お気に入り、ブックマーク、ピン留め、翻訳 |
| `timelines` | ホーム、ローカル、連合、ハッシュタグ、リストのタイムライン |
| `notifications` | 通知、ポリシー、リクエスト（v1 + グループ化 v2） |
| `media` | アップロード（v2/v1 フォールバック）、非同期処理、更新、削除 |
| `search` | アカウント、投稿、ハッシュタグ（オフセット＋カーソルページネーション） |
| `filters` | キーワードと投稿エントリを含む v2 CRUD（+ v1 非推奨） |
| `lists` | リストの CRUD とアカウント管理 |
| `oauth` | トークンの取得・失効、サーバーメタデータ、ユーザー情報 |
| `apps` | アプリケーションの登録と確認 |
| `instance` | サーバー情報（v1/v2）、ピア、アクティビティ、ルール、ドメインブロック |
| `customEmojis` | カスタム絵文字の一覧 |
| `announcements` | サーバーアナウンスとリアクション |
| `conversations` | ダイレクトメッセージの会話 |
| `polls` | 投票の取得と投票操作 |
| `push` | Web Push サブスクリプション管理 |
| `tags` | ハッシュタグ情報、フォロー・アンフォロー |
| `trends` | トレンドのタグ、投稿、リンク |
| `blocks` | ブロックしたアカウントの一覧 |
| `mutes` | ミュートしたアカウントの一覧 |
| `domainBlocks` | ユーザーレベルのドメインブロック管理 |
| `reports` | 通報の作成 |
| `followRequests` | フォローリクエスト管理 |
| `suggestions` | フォロー候補 |
| `favourites` | お気に入り登録した投稿の一覧 |
| `bookmarks` | ブックマークした投稿の一覧 |
| `endorsements` | おすすめアカウントの一覧 |
| `featuredTags` | 注目タグの管理 |
| `followedTags` | フォロー中のタグの一覧 |
| `directory` | プロフィールディレクトリ |
| `preferences` | ユーザー設定 |
| `markers` | タイムラインの既読位置マーカー |
| `scheduledStatuses` | 予約投稿の管理 |
| `health` | サーバーのヘルスチェック |
| `profile` | アバター・ヘッダー画像の管理 |
| `groupedNotifications` | グループ化された通知（v2） |
| `adminAccounts` | 管理者用アカウント管理 |
| `adminReports` | 管理者用通報管理 |
| `adminDomainBlocks` | 管理者用ドメインブロック管理 |
| `adminDomainAllows` | 管理者用ドメイン許可管理 |
| `adminIpBlocks` | 管理者用 IP ブロック管理 |
| `adminCanonicalEmailBlocks` | 管理者用正規メールブロック管理 |
| `adminEmailDomainBlocks` | 管理者用メールドメインブロック管理 |
| `adminTags` | 管理者用タグ管理 |
| `adminTrends` | 管理者用トレンド管理 |
| `adminMeasures` | 管理者用定量的指標 |
| `adminDimensions` | 管理者用カテゴリ別ディメンション |
| `adminRetention` | 管理者用ユーザー継続率コホート |

## 認証

Mastodon は OAuth 2.0 を使用しています。アプリケーションを登録し、ユーザーを認証ページにリダイレクトして、コードをトークンに交換してください:

```dart
// 1. Register your app
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

// 2. Direct the user to the authorization URL (platform-dependent)

// 3. Exchange the authorization code for a token
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: app.clientId!,
  clientSecret: app.clientSecret!,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode,
);

// 4. Create a new client with the token
final authedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## エラーハンドリング

すべての例外は sealed クラス `MastodonException` を継承しており、網羅的なパターンマッチングが可能です:

```dart
try {
  final user = await client.accounts.fetchById('abc123');
} on MastodonUnauthorizedException {
  // 401 — token invalid or expired
} on MastodonForbiddenException {
  // 403 — operation not permitted
} on MastodonNotFoundException {
  // 404 — resource not found
} on MastodonRateLimitException catch (e) {
  // 429 — rate limited; check e.retryAfter
} on MastodonValidationException {
  // 422 — invalid request body
} on MastodonServerException {
  // 5xx — server-side error
} on MastodonNetworkException {
  // Timeout, connection refused, etc.
}
```

## ロギング

`enableLog` で組み込みの stdout ロガーを有効にするか、カスタムの `Logger` 実装を提供してください:

```dart
class MyLogger implements Logger {
  @override void debug(String message) { /* ... */ }
  @override void info(String message)  { /* ... */ }
  @override void warn(String message)  { /* ... */ }
  @override void error(String message, [Object? error, StackTrace? stackTrace]) { /* ... */ }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  logger: MyLogger(),
);
```

## ドキュメント

- API リファレンス: https://librarylibrarian.github.io/mastodon_client/
- pub.dev ページ: https://pub.dev/packages/mastodon_client
- GitHub: https://github.com/LibraryLibrarian/mastodon_client

## ライセンス

[LICENSE](LICENSE) を参照してください。
