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
    this.limit,
    this.remaining,
    this.resetAt,
  }) : super(statusCode: 429);

  /// Recommended wait duration indicated by the server.
  final Duration? retryAfter;

  /// Maximum number of requests allowed in the current rate-limit window.
  final int? limit;

  /// Number of requests remaining in the current rate-limit window.
  final int? remaining;

  /// Time when the current rate-limit window resets.
  final DateTime? resetAt;
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

/// Base class for errors from the Mastodon Streaming API.
sealed class MastodonStreamingException extends MastodonException {
  const MastodonStreamingException(super.message);
}

/// A failure while establishing or restoring a streaming connection.
class MastodonStreamingConnectionException extends MastodonStreamingException {
  /// Creates a streaming connection failure.
  const MastodonStreamingConnectionException({
    String message = 'Streaming connection failed',
    this.statusCode,
    this.endpoint,
    this.raw,
  }) : super(message);

  /// HTTP status returned by the WebSocket handshake, when available.
  final int? statusCode;

  /// Credential-free Streaming API endpoint.
  final String? endpoint;

  /// Original exception or error object, when safe to expose.
  final Object? raw;
}

/// A server-reported subscription or unsubscription failure.
class MastodonStreamingSubscriptionException
    extends MastodonStreamingException {
  /// Creates a streaming subscription failure.
  const MastodonStreamingSubscriptionException({
    String message = 'Streaming subscription failed',
    this.status,
    this.endpoint,
    this.raw,
  }) : super(message);

  /// Status value returned by a subscription response, when present.
  final int? status;

  /// Credential-free Streaming API endpoint.
  final String? endpoint;

  /// Original response or error object.
  final Object? raw;
}

/// An unexpected or non-recoverable streaming connection closure.
class MastodonStreamingClosedException extends MastodonStreamingException {
  /// Creates a streaming closure failure.
  const MastodonStreamingClosedException({
    required this.closeCode,
    this.closeReason,
    this.endpoint,
    String message = 'Streaming connection closed',
  }) : super(message);

  /// WebSocket close code. A value of 1005 means no status was received.
  final int closeCode;

  /// WebSocket close reason, when supplied by the server.
  final String? closeReason;

  /// Credential-free Streaming API endpoint.
  final String? endpoint;
}
