/// Authentication methods supported by the Mastodon Streaming API.
enum MastodonStreamingAuthMode {
  /// Sends the access token as the only WebSocket subprotocol.
  subprotocol,

  /// Sends the access token in an `Authorization` request header.
  header,

  /// Sends the access token in the `access_token` query parameter.
  queryParameter,
}

/// Configuration for the Mastodon Streaming API connection.
class MastodonStreamingConfig {
  /// Creates Streaming API connection settings.
  MastodonStreamingConfig({
    this.authMode = MastodonStreamingAuthMode.subprotocol,
    this.enableAuthFallback = true,
    this.pingInterval = const Duration(seconds: 30),
    this.connectTimeout = const Duration(seconds: 15),
    this.enableAutoReconnect = true,
    this.reconnectInitialDelay = const Duration(seconds: 1),
    this.reconnectMaxDelay = const Duration(seconds: 30),
    this.reconnectJitter = 0.2,
    this.maxReconnectAttempts,
  }) {
    _requirePositive(pingInterval, 'pingInterval');
    _requirePositive(connectTimeout, 'connectTimeout');
    _requirePositive(reconnectInitialDelay, 'reconnectInitialDelay');
    _requirePositive(reconnectMaxDelay, 'reconnectMaxDelay');
    if (reconnectInitialDelay > reconnectMaxDelay) {
      throw ArgumentError.value(
        reconnectInitialDelay,
        'reconnectInitialDelay',
        'must not be greater than reconnectMaxDelay',
      );
    }
    if (reconnectJitter < 0 || reconnectJitter > 1) {
      throw ArgumentError.value(
        reconnectJitter,
        'reconnectJitter',
        'must be between 0 and 1',
      );
    }
    if (maxReconnectAttempts != null && maxReconnectAttempts! < 0) {
      throw ArgumentError.value(
        maxReconnectAttempts,
        'maxReconnectAttempts',
        'must be null or non-negative',
      );
    }
  }

  static void _requirePositive(Duration value, String name) {
    if (value <= Duration.zero) {
      throw ArgumentError.value(value, name, 'must be positive');
    }
  }

  /// Authentication mode attempted first.
  final MastodonStreamingAuthMode authMode;

  /// Whether remaining authentication modes are tried after a failure.
  final bool enableAuthFallback;

  /// Interval used for transport-level ping frames.
  final Duration pingInterval;

  /// Maximum time allowed for the WebSocket handshake.
  final Duration connectTimeout;

  /// Whether unexpected disconnections trigger reconnection.
  final bool enableAutoReconnect;

  /// Delay before the first automatic reconnection attempt.
  final Duration reconnectInitialDelay;

  /// Upper bound for automatic reconnection delays, including jitter.
  final Duration reconnectMaxDelay;

  /// Symmetric jitter ratio applied to reconnection delays.
  final double reconnectJitter;

  /// Maximum number of automatic reconnection attempts.
  ///
  /// A value of `null` allows unlimited attempts. A value of zero disables
  /// automatic attempts after an unexpected disconnection.
  final int? maxReconnectAttempts;
}
