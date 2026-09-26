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
│   │   ├── retryAfter                //   リトライ推奨待機時間
│   │   ├── limit                     //   制限期間内のリクエスト上限
│   │   ├── remaining                 //   残りリクエスト数
│   │   └── resetAt                   //   制限がリセットされる時刻
│   ├── MastodonValidationException   // 422 - バリデーションエラー
│   │   ├── serverMessage             //   サーバーからの詳細メッセージ
│   │   ├── details                   //   リクエスト項目ごとのエラー
│   │   └── MastodonAlreadyVotedException // 投票済みエラー
│   └── MastodonServerException       // 5xx - サーバーエラー
├── MastodonNetworkException          // ネットワーク接続エラー
└── MastodonAuthException (sealed)    // OAuth 認証フローエラー
    ├── MastodonAuthCancelledException    // ユーザーによるキャンセル
    ├── MastodonAuthStateMismatchException // CSRF 検出
    └── MastodonAuthTokenException        // トークン取得失敗
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
  await client.accounts.create(request);
} on MastodonValidationException catch (e) {
  print('バリデーションエラー: ${e.serverMessage}');
  final details = e.details;
  if (details != null) {
    for (final entry in details.entries) {
      for (final detail in entry.value) {
        print('${entry.key}: ${detail.code} - ${detail.description ?? ''}');
      }
    }
  }
}
```

`details` はリクエスト項目をキーとする Map です。各
`MastodonValidationErrorDetail` からサーバーのエラーコードと任意の説明を
取得できます。未知のコードも将来互換性のため文字列のまま保持されます。
エンドポイントが Mastodon の既知のバリデーション詳細形式を返さない場合、
`details` は `null` です。

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

## レート制限への対応

`MastodonRateLimitException` は Mastodon の `X-RateLimit-*` ヘッダーを公開します。
推奨待機時間には、サーバーまたはプロキシが `Retry-After` を返した場合はその値を使い、
返さない場合は `X-RateLimit-Reset` のタイムスタンプを使います。

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
    print('残り ${e.remaining}/${e.limit} 件。${e.resetAt} にリセット');
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
