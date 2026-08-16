import 'dart:async';
import 'dart:math';

import '../exception/mastodon_exception.dart';
import '../logging/logger.dart';
import '../models/mastodon_instance.dart';
import '../models/mastodon_instance_v1.dart';
import 'streaming_config.dart';
import 'streaming_connection_state.dart';
import 'streaming_url_resolver.dart';
import 'websocket_connector.dart';

/// Called immediately after an automatic streaming reconnection succeeds.
typedef MastodonStreamingReconnectCallback = FutureOr<void> Function();

/// Maintains a WebSocket connection to the Mastodon Streaming API.
///
/// This transport exposes raw text frames. Subscription management and event
/// decoding are layered on top of it by the higher-level streaming API.
class MastodonStreaming {
  /// Creates a Mastodon Streaming API transport.
  factory MastodonStreaming({
    required String baseUrl,
    required String accessToken,
    MastodonStreamingConfig? config,
    Logger? logger,
    bool enableLog = false,
    MastodonStreamingReconnectCallback? onReconnect,
  }) => MastodonStreaming.withConnector(
    baseUrl: baseUrl,
    accessToken: accessToken,
    connector: createDefaultWebSocketConnector(),
    config: config,
    logger: logger,
    enableLog: enableLog,
    onReconnect: onReconnect,
  );

  /// Creates a transport with an injectable WebSocket connector.
  ///
  /// Package tests can also inject [delay] and [jitterSource] to observe
  /// reconnection timing without waiting for wall-clock timers.
  MastodonStreaming.withConnector({
    required String baseUrl,
    required String accessToken,
    required WebSocketConnector connector,
    MastodonStreamingConfig? config,
    Logger? logger,
    bool enableLog = false,
    this.onReconnect,
    Future<void> Function(Duration duration)? delay,
    double Function()? jitterSource,
    StreamingUrlResolver urlResolver = const StreamingUrlResolver(),
  }) : _baseUrl = baseUrl,
       _accessToken = accessToken,
       _connector = connector,
       config = config ?? MastodonStreamingConfig(),
       _logger = logger ?? const StdoutLogger(),
       _enableLog = enableLog,
       _delay = delay ?? Future<void>.delayed,
       _jitterSource = jitterSource ?? Random().nextDouble,
       _urlResolver = urlResolver;

  final String _baseUrl;
  final String _accessToken;
  final WebSocketConnector _connector;
  final Logger _logger;
  final bool _enableLog;
  final Future<void> Function(Duration duration) _delay;
  final double Function() _jitterSource;
  final StreamingUrlResolver _urlResolver;

  /// Connection and reconnection settings.
  final MastodonStreamingConfig config;

  /// Hook invoked after an automatic reconnection becomes usable.
  ///
  /// A subscription layer can replace this callback and resend every active
  /// subscription because server-side subscription state is connection-bound.
  MastodonStreamingReconnectCallback? onReconnect;

  final StreamController<MastodonStreamingConnectionState> _stateController =
      StreamController<MastodonStreamingConnectionState>.broadcast();
  final StreamController<MastodonStreamingException> _errorController =
      StreamController<MastodonStreamingException>.broadcast();
  final StreamController<String> _frameController =
      StreamController<String>.broadcast();

  MastodonStreamingConnectionState _state =
      MastodonStreamingConnectionState.disconnected;
  MastodonStreamingAuthMode? _successfulAuthMode;
  MastodonInstance? _instance;
  MastodonInstanceV1? _instanceV1;
  _ActiveConnection? _connection;
  Future<void>? _connectFuture;
  int _generation = 0;
  int _reconnectAttempts = 0;
  bool _wantsConnection = false;
  bool _isSuspended = false;
  bool _isDisposed = false;
  bool _reconnectScheduled = false;

  /// Current connection state.
  MastodonStreamingConnectionState get state => _state;

  /// State changes that occur after listening.
  Stream<MastodonStreamingConnectionState> get stateChanges =>
      _stateController.stream;

  /// Connection and closure errors.
  Stream<MastodonStreamingException> get errors => _errorController.stream;

  /// Raw text frames received from the server.
  Stream<String> get rawFrames => _frameController.stream;

  /// Authentication mode that most recently connected successfully.
  MastodonStreamingAuthMode? get successfulAuthMode => _successfulAuthMode;

  /// Whether the WebSocket is open and ready to send text frames.
  bool get isConnected => _state == MastodonStreamingConnectionState.connected;

  /// Establishes a WebSocket connection.
  ///
  /// The optional instance metadata is used by [StreamingUrlResolver]. A failed
  /// explicit connection is reported to the caller and is not auto-retried.
  Future<void> connect({
    MastodonInstance? instance,
    MastodonInstanceV1? instanceV1,
  }) {
    _ensureNotDisposed();
    if (isConnected) {
      return Future<void>.value();
    }
    final current = _connectFuture;
    if (current != null &&
        (_state == MastodonStreamingConnectionState.connecting ||
            _state == MastodonStreamingConnectionState.reconnecting)) {
      return current;
    }

    _instance = instance;
    _instanceV1 = instanceV1;
    _isSuspended = false;
    _wantsConnection = true;
    _reconnectAttempts = 0;
    _reconnectScheduled = false;
    return _beginConnection(reconnecting: false, automaticAttempt: false);
  }

  /// Sends one text frame on the active WebSocket.
  void sendText(String frame) {
    _ensureNotDisposed();
    final connection = _connection;
    if (!isConnected || connection == null) {
      throw StateError('MastodonStreaming is not connected');
    }
    connection.socket.sendText(frame);
  }

  /// Stops the connection until [connect] is called again.
  Future<void> disconnect() async {
    if (_isDisposed) {
      return;
    }
    _wantsConnection = false;
    _isSuspended = false;
    _reconnectScheduled = false;
    _generation++;
    _connectFuture = null;
    final connection = _takeConnection();
    _setState(MastodonStreamingConnectionState.disconnected);
    await _releaseConnection(connection);
  }

  /// Pauses the socket while preserving the intent to reconnect on [resume].
  Future<void> suspend() async {
    _ensureNotDisposed();
    if (_isSuspended) {
      return;
    }
    _isSuspended = true;
    _reconnectScheduled = false;
    _generation++;
    _connectFuture = null;
    final connection = _takeConnection();
    _setState(MastodonStreamingConnectionState.suspended);
    await _releaseConnection(connection);
  }

  /// Restores a socket that was paused by [suspend].
  Future<void> resume() {
    _ensureNotDisposed();
    if (!_isSuspended) {
      return Future<void>.value();
    }
    _isSuspended = false;
    if (!_wantsConnection) {
      _setState(MastodonStreamingConnectionState.disconnected);
      return Future<void>.value();
    }
    return _beginConnection(reconnecting: true, automaticAttempt: true);
  }

  /// Permanently releases the socket and stream controllers.
  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    _wantsConnection = false;
    _isSuspended = false;
    _reconnectScheduled = false;
    _generation++;
    _connectFuture = null;
    final connection = _takeConnection();
    _setState(MastodonStreamingConnectionState.disposed);
    try {
      await _releaseConnection(connection);
    } finally {
      await _frameController.close();
      await _errorController.close();
      await _stateController.close();
    }
  }

  Future<void> _beginConnection({
    required bool reconnecting,
    required bool automaticAttempt,
  }) {
    final generation = ++_generation;
    _setState(
      reconnecting
          ? MastodonStreamingConnectionState.reconnecting
          : MastodonStreamingConnectionState.connecting,
    );
    late final Future<void> future;
    future =
        _openConnection(
          generation,
          reconnecting: reconnecting,
          automaticAttempt: automaticAttempt,
        ).whenComplete(() {
          if (identical(_connectFuture, future)) {
            _connectFuture = null;
          }
        });
    _connectFuture = future;
    return future;
  }

  Future<void> _openConnection(
    int generation, {
    required bool reconnecting,
    required bool automaticAttempt,
  }) async {
    final endpoint = _urlResolver.resolve(
      baseUrl: _baseUrl,
      instance: _instance,
      instanceV1: _instanceV1,
    );
    try {
      final result = await _connectWithFallback(endpoint);
      if (!_isCurrentIntent(generation)) {
        await result.connection.close(1000, 'Connection superseded');
        return;
      }

      final active = _ActiveConnection(
        generation: generation,
        socket: result.connection,
      );
      _connection = active;
      active.subscription = result.connection.messages.listen(
        (data) => _handleFrame(active, data),
        onError: (Object error, StackTrace stackTrace) {
          _handleSocketError(active, error, stackTrace);
        },
        onDone: () => _handleSocketDone(active),
        cancelOnError: false,
      );
      _successfulAuthMode = result.authMode;
      _reconnectAttempts = 0;
      _setState(MastodonStreamingConnectionState.connected);
      _logInfo('Connected to Mastodon Streaming API');

      if (reconnecting) {
        try {
          await onReconnect?.call();
        } catch (error) {
          _emitError(
            MastodonStreamingConnectionException(
              message: 'Streaming reconnect hook failed',
              endpoint: _safeUri(endpoint).toString(),
              raw: error,
            ),
          );
        }
      }
    } catch (error) {
      if (!_isCurrentIntent(generation)) {
        return;
      }
      final exception = _toConnectionException(error, endpoint);
      _setState(MastodonStreamingConnectionState.disconnected);
      _emitError(exception);

      if (exception.statusCode == 401) {
        _wantsConnection = false;
        throw exception;
      }
      if (automaticAttempt) {
        _scheduleReconnect();
      } else {
        _wantsConnection = false;
      }
      throw exception;
    }
  }

  Future<_ConnectionResult> _connectWithFallback(Uri endpoint) async {
    Object? lastError;
    for (final mode in _authenticationOrder()) {
      final options = _connectOptions(endpoint, mode);
      _logInfo(
        'Connecting to Mastodon Streaming API at '
        '${_safeUri(options.uri)} using ${mode.name} authentication',
      );
      try {
        final connection = await _connector.connect(options);
        return _ConnectionResult(connection: connection, authMode: mode);
      } on WebSocketConnectorException catch (error) {
        lastError = error;
        if (error.statusCode == 401) {
          rethrow;
        }
        _logWarn('Mastodon Streaming API ${mode.name} authentication failed');
      } catch (error) {
        lastError = error;
        _logWarn('Mastodon Streaming API ${mode.name} authentication failed');
      }
    }
    throw WebSocketConnectorException(
      message: 'All Streaming API authentication modes failed',
      cause: lastError,
    );
  }

  List<MastodonStreamingAuthMode> _authenticationOrder() {
    final preferred = _successfulAuthMode ?? config.authMode;
    if (!config.enableAuthFallback) {
      return [preferred];
    }
    return [
      preferred,
      for (final mode in MastodonStreamingAuthMode.values)
        if (mode != preferred) mode,
    ];
  }

  WebSocketConnectOptions _connectOptions(
    Uri endpoint,
    MastodonStreamingAuthMode mode,
  ) => switch (mode) {
    MastodonStreamingAuthMode.subprotocol => WebSocketConnectOptions(
      uri: endpoint,
      protocols: [_accessToken],
      pingInterval: config.pingInterval,
      connectTimeout: config.connectTimeout,
    ),
    MastodonStreamingAuthMode.header => WebSocketConnectOptions(
      uri: endpoint,
      headers: {'Authorization': 'Bearer $_accessToken'},
      pingInterval: config.pingInterval,
      connectTimeout: config.connectTimeout,
    ),
    MastodonStreamingAuthMode.queryParameter => WebSocketConnectOptions(
      uri: endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'access_token': _accessToken,
        },
      ),
      pingInterval: config.pingInterval,
      connectTimeout: config.connectTimeout,
    ),
  };

  void _handleFrame(_ActiveConnection connection, Object? data) {
    if (!_isCurrentConnection(connection) || connection.terminationHandled) {
      return;
    }
    if (data is String) {
      _frameController.add(data);
      return;
    }

    final exception = MastodonStreamingClosedException(
      closeCode: 1003,
      endpoint: _safeEndpoint,
      message: 'Streaming API sent a non-text frame',
    );
    _terminateConnection(connection, exception, reconnect: false);
  }

  void _handleSocketError(
    _ActiveConnection connection,
    Object error,
    StackTrace stackTrace,
  ) {
    if (!_isCurrentConnection(connection) || connection.terminationHandled) {
      return;
    }
    final exception = MastodonStreamingConnectionException(
      message: 'Streaming transport failed',
      endpoint: _safeEndpoint,
      raw: error,
    );
    _terminateConnection(connection, exception, reconnect: true);
  }

  void _handleSocketDone(_ActiveConnection connection) {
    if (!_isCurrentConnection(connection) || connection.terminationHandled) {
      return;
    }
    final code = connection.socket.closeCode ?? 1005;
    if (code == 1000) {
      connection.terminationHandled = true;
      _connection = null;
      _wantsConnection = false;
      _setState(MastodonStreamingConnectionState.disconnected);
      unawaited(_releaseConnection(connection));
      return;
    }

    final exception = MastodonStreamingClosedException(
      closeCode: code,
      closeReason: connection.socket.closeReason,
      endpoint: _safeEndpoint,
    );
    final reconnect = code != 1003 && code != 1005;
    _terminateConnection(connection, exception, reconnect: reconnect);
  }

  void _terminateConnection(
    _ActiveConnection connection,
    MastodonStreamingException exception, {
    required bool reconnect,
  }) {
    if (!_isCurrentConnection(connection) || connection.terminationHandled) {
      return;
    }
    connection.terminationHandled = true;
    _connection = null;
    _setState(MastodonStreamingConnectionState.disconnected);
    _emitError(exception);
    unawaited(_releaseConnection(connection));

    if (reconnect) {
      _scheduleReconnect();
    } else {
      _wantsConnection = false;
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed ||
        _isSuspended ||
        !_wantsConnection ||
        !config.enableAutoReconnect ||
        _reconnectScheduled) {
      return;
    }

    final attempt = _reconnectAttempts + 1;
    final maximum = config.maxReconnectAttempts;
    if (maximum != null && attempt > maximum) {
      _wantsConnection = false;
      _emitError(
        MastodonStreamingConnectionException(
          message: 'Streaming reconnect limit reached',
          endpoint: _safeEndpoint,
        ),
      );
      return;
    }

    _reconnectAttempts = attempt;
    _reconnectScheduled = true;
    final delay = _computeReconnectDelay(attempt);
    final generation = _generation;
    _setState(MastodonStreamingConnectionState.reconnecting);
    _logInfo(
      'Reconnecting to Mastodon Streaming API in '
      '${delay.inMilliseconds}ms (attempt $attempt)',
    );
    unawaited(
      _delay(delay).then((_) {
        _reconnectScheduled = false;
        if (_isDisposed ||
            _isSuspended ||
            !_wantsConnection ||
            _generation != generation) {
          return;
        }
        final future = _beginConnection(
          reconnecting: true,
          automaticAttempt: true,
        );
        unawaited(future.catchError((Object _) {}));
      }),
    );
  }

  Duration _computeReconnectDelay(int attempt) {
    final initial = config.reconnectInitialDelay.inMicroseconds;
    final maximum = config.reconnectMaxDelay.inMicroseconds;
    var base = initial;
    for (var current = 1; current < attempt && base < maximum; current++) {
      base = base > maximum ~/ 2 ? maximum : base * 2;
    }

    final sample = _jitterSource().clamp(0.0, 1.0);
    final jitter = config.reconnectJitter;
    final factor = (1 - jitter) + (sample * jitter * 2);
    final microseconds = (base * factor).round().clamp(1, maximum);
    return Duration(microseconds: microseconds);
  }

  MastodonStreamingConnectionException _toConnectionException(
    Object error,
    Uri endpoint,
  ) {
    if (error is MastodonStreamingConnectionException) {
      return error;
    }
    final statusCode = error is WebSocketConnectorException
        ? error.statusCode
        : null;
    return MastodonStreamingConnectionException(
      message: statusCode == 401
          ? 'Streaming authentication failed'
          : 'Streaming connection failed',
      statusCode: statusCode,
      endpoint: _safeUri(endpoint).toString(),
    );
  }

  Uri _safeUri(Uri uri) {
    if (!uri.queryParameters.containsKey('access_token')) {
      return uri;
    }
    return uri.replace(
      queryParameters: {...uri.queryParameters, 'access_token': '[REDACTED]'},
    );
  }

  String get _safeEndpoint => _safeUri(
    _urlResolver.resolve(
      baseUrl: _baseUrl,
      instance: _instance,
      instanceV1: _instanceV1,
    ),
  ).toString();

  bool _isCurrentIntent(int generation) =>
      !_isDisposed &&
      !_isSuspended &&
      _wantsConnection &&
      _generation == generation;

  bool _isCurrentConnection(_ActiveConnection connection) =>
      _isCurrentIntent(connection.generation) &&
      identical(_connection, connection);

  _ActiveConnection? _takeConnection() {
    final connection = _connection;
    _connection = null;
    if (connection != null) {
      connection.terminationHandled = true;
    }
    return connection;
  }

  Future<void> _releaseConnection(_ActiveConnection? connection) async {
    if (connection == null) {
      return;
    }
    try {
      await connection.subscription?.cancel();
    } catch (_) {
      _logWarn('Could not cancel the Streaming socket listener');
    }
    try {
      await connection.socket.close(1000, 'Client disconnect');
    } catch (_) {
      _logWarn('Could not close the Streaming socket');
    }
  }

  void _setState(MastodonStreamingConnectionState value) {
    if (_state == value) {
      return;
    }
    _state = value;
    if (!_stateController.isClosed) {
      _stateController.add(value);
    }
  }

  void _emitError(MastodonStreamingException error) {
    if (!_errorController.isClosed) {
      _errorController.add(error);
    }
  }

  void _logInfo(String message) {
    if (_enableLog) {
      _logger.info(message);
    }
  }

  void _logWarn(String message) {
    if (_enableLog) {
      _logger.warn(message);
    }
  }

  void _ensureNotDisposed() {
    if (_isDisposed) {
      throw StateError('MastodonStreaming has been disposed');
    }
  }
}

final class _ConnectionResult {
  const _ConnectionResult({required this.connection, required this.authMode});

  final WebSocketConnection connection;
  final MastodonStreamingAuthMode authMode;
}

final class _ActiveConnection {
  _ActiveConnection({required this.generation, required this.socket});

  final int generation;
  final WebSocketConnection socket;
  StreamSubscription<Object?>? subscription;
  bool terminationHandled = false;
}
