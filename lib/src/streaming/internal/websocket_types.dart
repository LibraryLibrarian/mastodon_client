/// Options used when opening a Streaming API WebSocket.
class WebSocketConnectOptions {
  /// Creates WebSocket connection options.
  const WebSocketConnectOptions({
    required this.uri,
    this.protocols = const [],
    this.headers = const {},
    this.pingInterval,
    this.connectTimeout,
  });

  /// WebSocket endpoint.
  final Uri uri;

  /// Requested WebSocket subprotocols.
  final List<String> protocols;

  /// HTTP headers sent during the WebSocket handshake.
  final Map<String, String> headers;

  /// Interval used for transport-level ping frames.
  final Duration? pingInterval;

  /// Maximum time allowed for the WebSocket handshake.
  final Duration? connectTimeout;
}

/// A minimal WebSocket connection used by the streaming transport.
abstract interface class WebSocketConnection {
  /// Messages and transport errors received from the server.
  Stream<Object?> get messages;

  /// Close code received from the server, when available.
  int? get closeCode;

  /// Close reason received from the server, when available.
  String? get closeReason;

  /// Sends a text frame.
  void sendText(String data);

  /// Starts closing the WebSocket.
  Future<void> close([int? closeCode, String? closeReason]);
}

/// Opens a WebSocket connection.
abstract interface class WebSocketConnector {
  /// Connects using [options] and completes after the handshake succeeds.
  Future<WebSocketConnection> connect(WebSocketConnectOptions options);
}

/// A transport-level WebSocket connection failure.
class WebSocketConnectorException implements Exception {
  /// Creates a connector failure.
  const WebSocketConnectorException({
    required this.message,
    this.statusCode,
    this.cause,
  });

  /// Human-readable description that must not contain credentials.
  final String message;

  /// HTTP status returned by the WebSocket handshake, when available.
  final int? statusCode;

  /// Original transport error.
  final Object? cause;

  @override
  String toString() => 'WebSocketConnectorException: $message';
}
