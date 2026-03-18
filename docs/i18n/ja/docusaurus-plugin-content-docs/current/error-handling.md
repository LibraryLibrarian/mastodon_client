---
sidebar_position: 4
---

# エラーハンドリング

本ライブラリは Mastodon API のエラーを `MastodonException` の sealed class 階層にマッピングします。

## 例外階層

```
MastodonException (sealed)
├── MastodonApiException              // HTTP レスポンスエラー全般
│   ├── MastodonUnauthorizedException // 401 - 認証エラー
│   ├── MastodonForbiddenException    // 403 - 権限エラー
│   ├── MastodonNotFoundException     // 404 - リソース不在
│   ├── MastodonRateLimitException    // 429 - レート制限
│   │   └── retryAfter                //   リトライ推奨待機時間
│   ├── MastodonValidationException   // 422 - バリデーションエラー
│   │   ├── serverMessage             //   サーバーからの詳細メッセージ
│   │   └── MastodonAlreadyVotedException // 投票済みエラー
│   └── MastodonServerException       // 5xx - サーバーエラー
├── MastodonNetworkException          // ネットワーク接続エラー
├── MastodonAuthException (sealed)    // OAuth 認証フローエラー
│   ├── MastodonAuthCancelledException    // ユーザーによるキャンセル
│   ├── MastodonAuthStateMismatchException // CSRF 検出
│   └── MastodonAuthTokenException        // トークン取得失敗
└── MastodonMediaProcessingTimeoutException // メディア処理タイムアウト
```

## 基本的な catch パターン

### すべてのエラーをまとめて処理

```dart
try {
  final status = await client.statuses.fetch(id);
} on MastodonException catch (e) {
  print('エラー: $e');
}
```

### HTTP ステータス別の処理

```dart
try {
  final account = await client.accounts.fetchById(accountId);
} on MastodonNotFoundException {
  print('アカウントが見つかりません');
} on MastodonUnauthorizedException {
  print('トークンが無効です。再認証してください');
} on MastodonRateLimitException catch (e) {
  print('レート制限。${e.retryAfter} 後にリトライ');
} on MastodonApiException catch (e) {
  print('API エラー (${e.statusCode}): ${e.message}');
} on MastodonNetworkException {
  print('ネットワーク接続を確認してください');
}
```

### バリデーションエラーの詳細取得

```dart
try {
  await client.statuses.create(request);
} on MastodonValidationException catch (e) {
  print('バリデーションエラー: ${e.serverMessage}');
}
```

## 特殊な例外

### MastodonAlreadyVotedException

投票済みのアンケートに再度投票した場合にスローされます。

```dart
try {
  await client.polls.vote(pollId, [0]);
} on MastodonAlreadyVotedException {
  print('このアンケートには既に投票済みです');
}
```

### MastodonMediaProcessingTimeoutException

メディアアップロード後の非同期処理がタイムアウトした場合にスローされます。

```dart
try {
  final attachment = await client.media.upload(bytes, 'photo.jpg');
} on MastodonMediaProcessingTimeoutException catch (e) {
  print('メディア ${e.mediaId} の処理がタイムアウトしました');
  // 後で client.media.fetchById(e.mediaId) で状態を確認可能
}
```

## レート制限への対応

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
    final wait = e.retryAfter ?? const Duration(seconds: 60);
    await Future<void>.delayed(wait);
    return action();
  }
}

// 使用例
final timeline = await withRetry(
  () => client.timelines.fetchHome(limit: 20),
);
```
