/// Base class for exceptions thrown by the Mastodon API client.
sealed class MastodonException implements Exception {
  const MastodonException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Exception representing an HTTP response error.
///
/// Holds the HTTP status code in [statusCode] and the server-returned message
/// in [message].
class MastodonApiException extends MastodonException {
  const MastodonApiException({
    required this.statusCode,
    required String message,
    this.endpoint,
    this.raw,
  }) : super(message);

  final int statusCode;

  /// API endpoint where the error occurred.
  final String? endpoint;

  /// Original exception or error object.
  final Object? raw;

  @override
  String toString() =>
      '$runtimeType($statusCode): $message'
      '${endpoint != null ? ' endpoint=$endpoint' : ''}';
}

/// Authentication error (HTTP 401).
///
/// The access token is invalid or expired.
class MastodonUnauthorizedException extends MastodonApiException {
  const MastodonUnauthorizedException({
    super.message = 'Unauthorized',
    super.endpoint,
    super.raw,
  }) : super(statusCode: 401);
}

/// Permission error (HTTP 403).
///
/// The operation is not allowed.
class MastodonForbiddenException extends MastodonApiException {
  const MastodonForbiddenException({
    super.message = 'Forbidden',
    super.endpoint,
    super.raw,
  }) : super(statusCode: 403);
}

/// Resource not found (HTTP 404).
class MastodonNotFoundException extends MastodonApiException {
  const MastodonNotFoundException({
    super.message = 'Not found',
    super.endpoint,
    super.raw,
  }) : super(statusCode: 404);
}

/// Rate limit error (HTTP 429).
///
/// The request frequency has exceeded the limit.
class MastodonRateLimitException extends MastodonApiException {
  const MastodonRateLimitException({
    super.message = 'Rate limited',
    super.endpoint,
    super.raw,
    this.retryAfter,
  }) : super(statusCode: 429);

  /// Recommended wait duration indicated by the server.
  final Duration? retryAfter;
}

/// Validation error (HTTP 422).
///
/// The request content is invalid.
///
/// Holds the error details returned by the server in [serverMessage].
class MastodonValidationException extends MastodonApiException {
  const MastodonValidationException({
    super.message = 'Unprocessable entity',
    super.endpoint,
    super.raw,
    this.serverMessage,
  }) : super(statusCode: 422);

  /// Raw error message returned by the server.
  final String? serverMessage;
}

/// Server error (HTTP 5xx).
class MastodonServerException extends MastodonApiException {
  const MastodonServerException({
    required super.statusCode,
    super.message = 'Server error',
    super.endpoint,
    super.raw,
  });
}

/// Network connection error (timeout, connection refused, etc.).
class MastodonNetworkException extends MastodonException {
  const MastodonNetworkException({
    String message = 'Network error',
    this.endpoint,
    this.cause,
  }) : super(message);

  /// API endpoint where the error occurred.
  final String? endpoint;

  /// Original cause of the exception.
  final Object? cause;
}

/// Base class for errors during the OAuth authentication flow.
sealed class MastodonAuthException extends MastodonException {
  const MastodonAuthException(super.message);
}

/// The user cancelled the authentication.
class MastodonAuthCancelledException extends MastodonAuthException {
  const MastodonAuthCancelledException()
    : super('Authentication was cancelled by the user');
}

/// OAuth state parameter mismatch (CSRF detected).
class MastodonAuthStateMismatchException extends MastodonAuthException {
  const MastodonAuthStateMismatchException()
    : super('OAuth state parameter mismatch');
}

/// Failed to obtain an access token.
class MastodonAuthTokenException extends MastodonAuthException {
  const MastodonAuthTokenException(super.message);
}

/// Already voted error (HTTP 422 -- already voted).
///
/// Thrown when the authenticated user has already voted on the same poll.
class MastodonAlreadyVotedException extends MastodonValidationException {
  const MastodonAlreadyVotedException()
    : super(message: 'Already voted', serverMessage: 'already voted');
}

/// Media async processing timeout.
///
/// Thrown when the media with [MastodonMediaProcessingTimeoutException.mediaId]
/// did not finish processing within the polling limit after the server
/// returned HTTP 202.
class MastodonMediaProcessingTimeoutException extends MastodonException {
  MastodonMediaProcessingTimeoutException({required this.mediaId})
    : super('Media processing timed out (id: $mediaId)');

  /// ID of the media that was awaiting processing.
  final String mediaId;
}
