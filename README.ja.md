[English](README.md) | [简体中文](README.zh-Hans.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [한국어](README.ko.md)

# mastodon_client

pure Dart で実装された [Mastodon](https://joinmastodon.org/) APIクライアントライブラリ。  
主要なAPIカテゴリへの型付きアクセスを提供、OAuth サポート、カーソルベースのページネーション、構造化されたエラーハンドリングを組み込み。

> **ベータ版**: API実装は完了していますが、テストカバレッジは最小限です。テスト結果に基づき、レスポンスモデルやメソッドシグネチャが変更される可能性があります。詳細は [CHANGELOG](CHANGELOG.md) を参照してください。

## 機能

- Mastodonの主要APIカテゴリをカバー（アカウント、投稿、タイムライン、通知、メディアなど）
- OAuth 2.0 トークン管理（取得、失効、トークン交換時の PKCE `code_verifier` の受け渡し）
- `MastodonPage<T>` によるカーソルベースのページネーション
- 網羅的なエラーハンドリングのための sealed 例外階層
- 自動的な v2/v1 フォールバックと明示的な処理状態確認を備えた非同期メディアアップロード
- 多重化された購読と自動再接続を備えた WebSocket による Streaming API
- 交換可能な `Logger` インターフェースによる設定可能なロギング
- pure Dart — Flutter への依存は不要

## インストール

`pubspec.yaml` にパッケージを追加してください:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.3
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

REST クライアントはライブラリ独自の HTTP タイムアウトを設定しません。ライブラリの
既定値でリクエストを打ち切らず、トランスポートと Mastodon サーバーの動作に従います。

非同期メディアアップロードでは、`upload()` は HTTP 202 の `url` が `null` の添付情報を
直ちに返します。`client.media.fetchById(id)` で明示的に確認してください。HTTP 206 は
処理中、HTTP 200 は現在の添付情報、HTTP 422 は `MastodonValidationException` として
通知される処理失敗を示します。

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
| `streaming` | WebSocket による Streaming API（[ストリーミング](#ストリーミング)を参照） |
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

## サーバー機能の判定

接続先によって利用できる Mastodon API の水準が異なります。バージョン依存機能を
表示する前に対応状況を判定できます。

```dart
final capabilities = await client.instance.detectCapabilities();
final support = capabilities.supportFor(MastodonCapability.collections);

if (support == MastodonCapabilitySupport.supported) {
  // Collections 機能を表示する
}
```

このヘルパーは `api_versions.mastodon` を優先し、無い場合は報告されたバージョン
文字列を使います。v2 instance endpoint が 404 の場合はレガシー v1 へ
フォールバックします。結果はサーバーごと・アプリ起動中に一度キャッシュしてください。
`unknown` は保守的に扱い、実際の API 呼び出しのエラーも必ず処理してください。
フォークや互換実装では、宣言されたバージョンと実装が一致しない場合があります。

API バージョンはリリース番号ではなく API サーフェスの水準です。パッチリリースや
ルート以外の変更でも増加し、複数リリースで同じ値になったり、番号が飛んだりします。
対応機能一覧とフォールバックの詳細は
[インスタンスガイド](https://librarylibrarian.github.io/mastodon_client/ja/api/instance)
を参照してください。

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

## ストリーミング

Streaming API（WebSocket）によるリアルタイム更新です。単一の接続にすべての購読を多重化し、接続先はインスタンス情報から自動的に解決されます。

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();

final home = await client.streaming.subscribe(const MastodonStream.user());
home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonDeleteEvent(:final statusId):
      print('削除: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    default:
      break;
  }
});

// 投稿だけを受け取る（`update` と `status.update`）
home.statuses.listen((status) => print(status.id));

final tag = await client.streaming.subscribe(
  const MastodonStream.hashtag('dart'),
);

await tag.cancel();
await client.dispose();
```

チャンネルは `MastodonStream` で表現します。`user()` / `userNotification()` / `public()`（`local`、`remote`、`onlyMedia` を指定可能）/ `hashtag()`（`local` を指定可能）/ `list()` / `direct()` が利用できます。本ライブラリが型として持たないチャンネルには `subscribeRaw` を使います。

購読は参照カウントで管理されるため、同一チャンネルを二重に購読しても `subscribe` フレームは 1 回しか送られません。再接続は指数バックオフとジッタで自動的に行われ、再接続後はすべての購読が自動的に再送されます。アプリのライフサイクルに合わせて `suspend()` と `resume()` を使い、接続の監視には `stateChanges` と `errors` を利用してください。

### 注意点

- パブリックなチャンネルを含め、ストリーミングには例外なくアクセストークンが必要です。
- `read:statuses` のみのトークンで `user` に繋ぐと、ホームタイムラインは流れますが通知は一切届きません（エラーも出ません）。通知が必要な場合は `read` または `read:notifications` を使ってください。
- `only_media` は WebSocket では無視されます。`MastodonStream.public(onlyMedia: true)` のようにチャンネル名で指定してください。
- `user` と `userNotification` を同時に購読すると、同じ通知が 2 回届きます。`user` だけで十分です。
- パブリックおよびハッシュタグの更新は、言語設定・フィード公開設定・ブロック・ミュートによってサイレントに破棄されることがあります。何も流れてこないことが必ずしも異常とは限りません。
- 切断中に発生したイベントは再接続後も届きません。REST の `since_id` や `min_id` で穴埋めしてください。

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
