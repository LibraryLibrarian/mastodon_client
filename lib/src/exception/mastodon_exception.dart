/// Mastodon API クライアントが送出する例外の基底クラス
sealed class MastodonException implements Exception {
  const MastodonException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

// ---------------------------------------------------------------------------
// API エラー（HTTP レスポンスエラー）
// ---------------------------------------------------------------------------

/// HTTP レスポンスエラーを表す例外
///
/// [statusCode] に HTTP ステータスコード、[message] にサーバーから返されたメッセージを持つ。
class MastodonApiException extends MastodonException {
  const MastodonApiException({
    required this.statusCode,
    required String message,
  }) : super(message);

  final int statusCode;

  @override
  String toString() => '$runtimeType($statusCode): $message';
}

/// 認証エラー（HTTP 401）
///
/// アクセストークンが無効または期限切れ
class MastodonUnauthorizedException extends MastodonApiException {
  const MastodonUnauthorizedException({super.message = 'Unauthorized'})
    : super(statusCode: 401);
}

/// 権限エラー（HTTP 403）
///
/// 操作が許可されていない
class MastodonForbiddenException extends MastodonApiException {
  const MastodonForbiddenException({super.message = 'Forbidden'})
    : super(statusCode: 403);
}

/// リソースが見つからない（HTTP 404）
class MastodonNotFoundException extends MastodonApiException {
  const MastodonNotFoundException({super.message = 'Not found'})
    : super(statusCode: 404);
}

/// バリデーションエラー（HTTP 422）
///
/// リクエストの内容が不正
///
/// [serverMessage] にサーバーが返したエラー詳細を保持する
class MastodonValidationException extends MastodonApiException {
  const MastodonValidationException({
    super.message = 'Unprocessable entity',
    this.serverMessage,
  }) : super(statusCode: 422);

  /// サーバーから返された生のエラーメッセージ
  final String? serverMessage;
}

/// サーバーエラー（HTTP 5xx）
class MastodonServerException extends MastodonApiException {
  const MastodonServerException({
    required super.statusCode,
    super.message = 'Server error',
  });
}

// ---------------------------------------------------------------------------
// ネットワークエラー
// ---------------------------------------------------------------------------

/// ネットワーク接続エラー（タイムアウト・接続不可など）
class MastodonNetworkException extends MastodonException {
  const MastodonNetworkException({
    String message = 'Network error',
    this.cause,
  }) : super(message);

  /// 元となった例外
  final Object? cause;
}

// ---------------------------------------------------------------------------
// 認証フローエラー
// ---------------------------------------------------------------------------

/// OAuth 認証フロー中のエラーの基底クラス
sealed class MastodonAuthException extends MastodonException {
  const MastodonAuthException(super.message);
}

/// ユーザーが認証をキャンセルした
class MastodonAuthCancelledException extends MastodonAuthException {
  const MastodonAuthCancelledException()
    : super('Authentication was cancelled by the user');
}

/// OAuth の state パラメーターが一致しなかった（CSRF 検出）
class MastodonAuthStateMismatchException extends MastodonAuthException {
  const MastodonAuthStateMismatchException()
    : super('OAuth state parameter mismatch');
}

/// アクセストークンの取得に失敗した
class MastodonAuthTokenException extends MastodonAuthException {
  const MastodonAuthTokenException(super.message);
}

// ---------------------------------------------------------------------------
// メディア処理エラー
// ---------------------------------------------------------------------------

/// メディアの非同期処理がタイムアウト
///
/// サーバーがHTTP202を返した後、[MastodonMediaProcessingTimeoutException.mediaId]
/// のメディアがポーリング制限内に完了しなかった場合にthrowを実施
class MastodonMediaProcessingTimeoutException extends MastodonException {
  MastodonMediaProcessingTimeoutException({required this.mediaId})
    : super('メディア処理がタイムアウトしました (id: $mediaId)');

  /// 処理待ちだったメディアのID
  final String mediaId;
}
