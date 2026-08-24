import 'dart:async';
import 'dart:convert';
import 'dart:math';

import '../exception/mastodon_exception.dart';
import '../logging/logger.dart';
import '../models/mastodon_instance.dart';
import '../models/mastodon_instance_v1.dart';
import 'internal/streaming_event_decoder.dart';
import 'streaming_config.dart';
import 'streaming_connection_state.dart';
import 'streaming_event.dart';
import 'streaming_message.dart';
import 'streaming_stream.dart';
import 'streaming_subscription.dart';
import 'streaming_url_resolver.dart';
import 'websocket_connector.dart';

/// Called immediately after an automatic streaming reconnection succeeds.
typedef MastodonStreamingReconnectCallback = FutureOr<void> Function();

/// Resolves instance metadata used to discover the streaming endpoint.
typedef MastodonStreamingMetadataProvider =
    Future<({MastodonInstance? instance, MastodonInstanceV1? instanceV1})>
    Function();

/// Verifies whether the access token used by the streaming connection is valid.
typedef MastodonStreamingTokenValidator = Future<bool> Function();

/// Maintains a WebSocket connection to the Mastodon Streaming API.
///
/// A single connection multiplexes every active subscription.
///
/// Events produced while the socket is disconnected are not replayed after
/// reconnection. Applications are responsible for filling gaps through REST
/// endpoints using `since_id` or `min_id`.
class MastodonStreaming {
  /// Creates a Mastodon Streaming API transport.
  factory MastodonStreaming({
    required String baseUrl,
    required String accessToken,
    MastodonStreamingConfig? config,
    Logger? logger,
    bool enableLog = false,
    MastodonStreamingReconnectCallback? onReconnect,
    MastodonStreamingMetadataProvider? metadataProvider,
    MastodonStreamingTokenValidator? tokenValidator,
  }) => MastodonStreaming.withConnector(
    baseUrl: baseUrl,
    accessToken: accessToken,
    connector: createDefaultWebSocketConnector(),
    config: config,
    logger: logger,
    enableLog: enableLog,
    onReconnect: onReconnect,
    metadataProvider: metadataProvider,
    tokenValidator: tokenValidator,
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
    MastodonStreamingMetadataProvider? metadataProvider,
    MastodonStreamingTokenValidator? tokenValidator,
    Future<void> Function(Duration duration)? delay,
    Future<void> Function(Duration duration)? subscriptionDelay,
    double Function()? jitterSource,
    StreamingUrlResolver urlResolver = const StreamingUrlResolver(),
  }) : _baseUrl = baseUrl,
       _accessToken = accessToken,
       _connector = connector,
       config = config ?? MastodonStreamingConfig(),
       _logger = logger ?? const StdoutLogger(),
       _enableLog = enableLog,
       _metadataProvider = metadataProvider,
       _tokenValidator = tokenValidator,
       _delay = delay ?? Future<void>.delayed,
       _subscriptionDelay = subscriptionDelay ?? Future<void>.delayed,
       _jitterSource = jitterSource ?? Random().nextDouble,
       _urlResolver = urlResolver;

  final String _baseUrl;
  final String _accessToken;
  final WebSocketConnector _connector;
  final Logger _logger;
  final bool _enableLog;
  final MastodonStreamingMetadataProvider? _metadataProvider;
  final MastodonStreamingTokenValidator? _tokenValidator;
  final Future<void> Function(Duration duration) _delay;
  final Future<void> Function(Duration duration) _subscriptionDelay;
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
  final StreamController<MastodonStreamingMessage> _messageController =
      StreamController<MastodonStreamingMessage>.broadcast();
  final Map<String, _SubscriptionEntry> _subscriptions = {};

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
  Future<void> _subscriptionQueue = Future<void>.value();
  _PendingSubscriptionOperation? _pendingSubscriptionOperation;
  int _activeSubscriptionCalls = 0;
  Completer<void>? _subscriptionCallsDrained;

  /// Current connection state.
  MastodonStreamingConnectionState get state => _state;

  /// State changes that occur after listening.
  Stream<MastodonStreamingConnectionState> get stateChanges =>
      _stateController.stream;

  /// Connection and closure errors.
  Stream<MastodonStreamingException> get errors => _errorController.stream;

  /// Raw text frames received from the server.
  Stream<String> get rawFrames => _frameController.stream;

  /// Decoded raw message envelopes from all subscribed channels.
  Stream<MastodonStreamingMessage> get messages => _messageController.stream;

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
    if (instance == null && instanceV1 == null && _metadataProvider != null) {
      return _resolveMetadataAndConnect();
    }
    return _beginConnection(reconnecting: false, automaticAttempt: false);
  }

  Future<void> _resolveMetadataAndConnect() {
    final generation = ++_generation;
    _setState(MastodonStreamingConnectionState.connecting);
    late final Future<void> future;
    future = _loadMetadataAndConnect(generation).whenComplete(() {
      if (identical(_connectFuture, future)) {
        _connectFuture = null;
      }
    });
    _connectFuture = future;
    return future;
  }

  Future<void> _loadMetadataAndConnect(int generation) async {
    try {
      final metadata = await _metadataProvider!.call();
      if (!_isCurrentIntent(generation)) {
        return;
      }
      _instance = metadata.instance;
      _instanceV1 = metadata.instanceV1;
    } on Object {
      if (!_isCurrentIntent(generation)) {
        return;
      }
      _logWarn(
        'Could not discover the Streaming API endpoint; using the REST host',
      );
    }
    if (_isCurrentIntent(generation)) {
      await _beginConnection(reconnecting: false, automaticAttempt: false);
    }
  }

  /// Subscribes to an official Mastodon Streaming API channel.
  ///
  /// Repeated subscriptions with the same normalized key share one server
  /// subscription. Each returned handle receives the routed messages until
  /// its own [MastodonStreamingSubscription.cancel] method is called.
  Future<MastodonStreamingSubscription> subscribe(MastodonStream stream) =>
      _subscribeTarget(
        _SubscriptionTarget(
          name: stream.name,
          params: stream.params,
          key: stream.key,
        ),
      );

  /// Subscribes to an unknown or server-specific streaming channel.
  Future<MastodonStreamingSubscription> subscribeRaw(
    String streamName, {
    Map<String, String> params = const {},
  }) {
    final trimmedName = streamName.trim();
    if (trimmedName.isEmpty) {
      throw const MastodonStreamingSubscriptionException(
        message: 'Streaming channel name must not be empty',
      );
    }
    return _subscribeTarget(
      _SubscriptionTarget(
        name: trimmedName,
        params: params,
        key: MastodonStream.keyFor(trimmedName, params),
        isRaw: true,
      ),
    );
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
    final subscriptionHandles = _takeSubscriptionHandles();
    _pendingSubscriptionOperation?.interrupt();
    try {
      await _releaseConnection(connection);
      await _subscriptionQueue;
      await _waitForSubscriptionCalls();
    } finally {
      await Future.wait(subscriptionHandles.map((handle) => handle.close()));
      await _messageController.close();
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
      await _restoreSubscriptions();

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

  Future<MastodonStreamingSubscription> _subscribeTarget(
    _SubscriptionTarget target,
  ) async {
    _ensureNotDisposed();
    _activeSubscriptionCalls++;
    try {
      return await _performSubscribeTarget(target);
    } finally {
      _activeSubscriptionCalls--;
      if (_activeSubscriptionCalls == 0) {
        _subscriptionCallsDrained?.complete();
        _subscriptionCallsDrained = null;
      }
    }
  }

  Future<MastodonStreamingSubscription> _performSubscribeTarget(
    _SubscriptionTarget target,
  ) async {
    final generation = _generation;
    final connection = _connection;
    var entry = _subscriptions[target.key];
    final isNewEntry = entry == null;
    entry ??= _SubscriptionEntry(target);
    _subscriptions[target.key] = entry;

    final handle = _createSubscriptionHandle(entry);
    entry.handles.add(handle);

    final existingSend = entry.initialSendFuture;
    if (!isNewEntry) {
      if (existingSend != null) {
        try {
          await existingSend;
          _ensureSubscriptionCallIsCurrent(generation, connection);
        } on StateError {
          await _discardSubscriptionEntry(entry);
          rethrow;
        }
      }
      return handle.subscription;
    }
    if (!isConnected) {
      return handle.subscription;
    }

    final send = _sendSubscriptionOperation('subscribe', target);
    entry.initialSendFuture = send;
    try {
      await send;
      _ensureSubscriptionCallIsCurrent(generation, connection);
      return handle.subscription;
    } on StateError {
      await _discardSubscriptionEntry(entry);
      rethrow;
    } on MastodonStreamingSubscriptionException catch (error) {
      await _discardSubscriptionEntry(entry);
      _emitError(error);
      rethrow;
    } finally {
      if (identical(entry.initialSendFuture, send)) {
        entry.initialSendFuture = null;
      }
    }
  }

  void _ensureSubscriptionCallIsCurrent(
    int generation,
    _ActiveConnection? connection,
  ) {
    _ensureNotDisposed();
    if (_generation != generation ||
        !isConnected ||
        !identical(_connection, connection)) {
      throw StateError(
        'MastodonStreaming connection changed during subscription',
      );
    }
  }

  Future<void> _discardSubscriptionEntry(_SubscriptionEntry entry) async {
    if (identical(_subscriptions[entry.target.key], entry)) {
      _subscriptions.remove(entry.target.key);
    }
    final handles = List<_SubscriptionHandle>.of(entry.handles);
    entry.handles.clear();
    await Future.wait(handles.map((item) => item.close()));
  }

  Future<void> _waitForSubscriptionCalls() {
    if (_activeSubscriptionCalls == 0) {
      return Future<void>.value();
    }
    return (_subscriptionCallsDrained ??= Completer<void>()).future;
  }

  _SubscriptionHandle _createSubscriptionHandle(_SubscriptionEntry entry) {
    late final _SubscriptionHandle handle;
    handle = _SubscriptionHandle(
      target: entry.target,
      onCancel: () => _cancelSubscriptionHandle(entry, handle),
      onIsActive: () => entry.handles.contains(handle),
    );
    return handle;
  }

  Future<void> _cancelSubscriptionHandle(
    _SubscriptionEntry entry,
    _SubscriptionHandle handle,
  ) async {
    if (!entry.handles.remove(handle)) {
      return;
    }
    await handle.close();
    if (entry.handles.isNotEmpty) {
      return;
    }

    if (identical(_subscriptions[entry.target.key], entry)) {
      _subscriptions.remove(entry.target.key);
    }
    if (!isConnected) {
      return;
    }
    try {
      await _sendSubscriptionOperation('unsubscribe', entry.target);
    } on MastodonStreamingSubscriptionException catch (error) {
      _emitError(error);
      rethrow;
    }
  }

  Future<void> _restoreSubscriptions() async {
    for (final entry in List<_SubscriptionEntry>.of(_subscriptions.values)) {
      if (!identical(_subscriptions[entry.target.key], entry) ||
          entry.handles.isEmpty) {
        continue;
      }
      try {
        await _sendSubscriptionOperation('subscribe', entry.target);
      } on MastodonStreamingSubscriptionException catch (error) {
        _emitError(error);
      }
    }
  }

  Future<void> _sendSubscriptionOperation(
    String type,
    _SubscriptionTarget target,
  ) {
    final operation = _subscriptionQueue.then(
      (_) => _performSubscriptionOperation(type, target),
    );
    _subscriptionQueue = operation.catchError((Object _) {});
    return operation;
  }

  Future<void> _performSubscriptionOperation(
    String type,
    _SubscriptionTarget target,
  ) async {
    if (!isConnected) {
      return;
    }

    final pending = _PendingSubscriptionOperation(type: type, target: target);
    _pendingSubscriptionOperation = pending;
    try {
      try {
        sendText(
          jsonEncode({'type': type, 'stream': target.name, ...target.params}),
        );
      } catch (error) {
        throw MastodonStreamingSubscriptionException(
          message: 'Could not send Streaming $type request',
          raw: error,
        );
      }

      final error = await Future.any<MastodonStreamingSubscriptionException?>([
        _subscriptionDelay(
          config.subscriptionErrorWindow,
        ).then<MastodonStreamingSubscriptionException?>((_) => null),
        pending.error.future,
        pending.interrupted.future.then((_) => null),
      ]);
      if (error != null) {
        throw error;
      }
    } finally {
      if (identical(_pendingSubscriptionOperation, pending)) {
        _pendingSubscriptionOperation = null;
      }
    }
  }

  void _handleProtocolFrame(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic> && decoded['error'] is String) {
        _handleSubscriptionError(decoded);
        return;
      }

      final message = MastodonStreamingMessage.fromRaw(raw);
      _messageController.add(message);
      _routeMessage(message, decodeMastodonStreamEvent(message));
    } on Object {
      _routeMalformedEnvelope(raw);
    }
  }

  void _routeMalformedEnvelope(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return;
      }
      final streamValue = decoded['stream'];
      final eventValue = decoded['event'];
      if (streamValue is! List<dynamic> ||
          streamValue.isEmpty ||
          streamValue.length > 2 ||
          streamValue.any((value) => value is! String) ||
          eventValue is! String ||
          eventValue.isEmpty) {
        return;
      }
      final payloadValue = decoded['payload'];
      final rawPayload = payloadValue == null
          ? null
          : payloadValue is String
          ? payloadValue
          : jsonEncode(payloadValue);
      final message = MastodonStreamingMessage(
        stream: streamValue.cast<String>(),
        event: eventValue,
        payload: rawPayload,
        raw: raw,
      );
      final event = MastodonUnknownStreamEvent(
        stream: message.stream,
        event: message.event,
        rawPayload: message.payload,
      );
      _messageController.add(message);
      _routeMessage(message, event);
    } on Object {
      // ストリームを特定できない不正フレームは次のフレームを待つ。
    }
  }

  void _handleSubscriptionError(Map<String, dynamic> decoded) {
    final pending = _pendingSubscriptionOperation;
    final error = MastodonStreamingSubscriptionException(
      message: decoded['error'] as String,
      status: decoded['status'] is int ? decoded['status'] as int : null,
      raw: pending == null
          ? decoded
          : {
              ...decoded,
              'operation': pending.type,
              'stream': pending.target.name,
            },
    );
    if (pending != null && !pending.error.isCompleted) {
      pending.error.complete(error);
    } else {
      _emitError(error);
    }
  }

  void _routeMessage(
    MastodonStreamingMessage message,
    MastodonStreamEvent event,
  ) {
    for (final entry in List<_SubscriptionEntry>.of(_subscriptions.values)) {
      if (!_matchesStream(entry.target, message.stream)) {
        continue;
      }
      for (final handle in List<_SubscriptionHandle>.of(entry.handles)) {
        handle.add(message, event);
      }
    }
  }

  bool _matchesStream(_SubscriptionTarget target, List<String> stream) {
    if (stream.isEmpty || stream.first != target.name) {
      return false;
    }
    if (target.isRaw && target.params.isEmpty) {
      return true;
    }
    final tag = target.params['tag'];
    if (tag != null) {
      return stream.length == 2 && stream[1].toLowerCase() == tag.toLowerCase();
    }
    final list = target.params['list'];
    if (list != null) {
      return stream.length == 2 && stream[1] == list;
    }
    return stream.length == 1;
  }

  List<_SubscriptionHandle> _takeSubscriptionHandles() {
    final handles = [
      for (final entry in _subscriptions.values) ...entry.handles,
    ];
    for (final entry in _subscriptions.values) {
      entry.handles.clear();
    }
    _subscriptions.clear();
    return handles;
  }

  void _handleFrame(_ActiveConnection connection, Object? data) {
    if (!_isCurrentConnection(connection) || connection.terminationHandled) {
      return;
    }
    if (data is String) {
      _frameController.add(data);
      _handleProtocolFrame(data);
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
    if (code == 1005 && _tokenValidator != null) {
      connection.terminationHandled = true;
      _connection = null;
      _setState(MastodonStreamingConnectionState.disconnected);
      unawaited(_releaseConnection(connection));
      unawaited(_validateTokenAfterMissingCloseStatus(connection, exception));
      return;
    }

    final reconnect = code != 1003 && code != 1005;
    _terminateConnection(connection, exception, reconnect: reconnect);
  }

  Future<void> _validateTokenAfterMissingCloseStatus(
    _ActiveConnection connection,
    MastodonStreamingClosedException exception,
  ) async {
    bool isValid;
    try {
      isValid = await _tokenValidator!.call();
    } catch (_) {
      if (!_isCurrentIntent(connection.generation)) {
        return;
      }
      _wantsConnection = false;
      _emitError(
        MastodonStreamingClosedException(
          closeCode: exception.closeCode,
          closeReason: exception.closeReason,
          endpoint: exception.endpoint,
          message:
              'Streaming connection closed and access token validation failed',
        ),
      );
      return;
    }

    if (!_isCurrentIntent(connection.generation)) {
      return;
    }
    if (!isValid) {
      _wantsConnection = false;
      _emitError(
        MastodonStreamingClosedException(
          closeCode: exception.closeCode,
          closeReason: exception.closeReason,
          endpoint: exception.endpoint,
          message:
              'Streaming connection closed because the access token is invalid',
        ),
      );
      return;
    }

    _emitError(exception);
    _scheduleReconnect();
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

final class _SubscriptionTarget {
  _SubscriptionTarget({
    required this.name,
    required Map<String, String> params,
    required this.key,
    this.isRaw = false,
  }) : params = Map.unmodifiable(params);

  final String name;
  final Map<String, String> params;
  final String key;
  final bool isRaw;
}

final class _SubscriptionEntry {
  _SubscriptionEntry(this.target);

  final _SubscriptionTarget target;
  final Set<_SubscriptionHandle> handles = {};
  Future<void>? initialSendFuture;
}

final class _SubscriptionHandle {
  _SubscriptionHandle({
    required this.target,
    required Future<void> Function() onCancel,
    required bool Function() onIsActive,
  }) {
    subscription = MastodonStreamingSubscription.managed(
      streamName: target.name,
      params: target.params,
      messages: _messageController.stream,
      events: _eventController.stream,
      onCancel: onCancel,
      onIsActive: onIsActive,
    );
  }

  final _SubscriptionTarget target;
  final StreamController<MastodonStreamingMessage> _messageController =
      StreamController<MastodonStreamingMessage>.broadcast();
  final StreamController<MastodonStreamEvent> _eventController =
      StreamController<MastodonStreamEvent>.broadcast();
  late final MastodonStreamingSubscription subscription;
  Future<void>? _closeFuture;

  void add(MastodonStreamingMessage message, MastodonStreamEvent event) {
    if (_messageController.isClosed || _eventController.isClosed) {
      return;
    }
    _messageController.add(message);
    _eventController.add(event);
  }

  Future<void> close() => _closeFuture ??= Future.wait<void>([
    _messageController.close(),
    _eventController.close(),
  ]);
}

final class _PendingSubscriptionOperation {
  _PendingSubscriptionOperation({required this.type, required this.target});

  final String type;
  final _SubscriptionTarget target;
  final Completer<MastodonStreamingSubscriptionException?> error =
      Completer<MastodonStreamingSubscriptionException?>();
  final Completer<void> interrupted = Completer<void>();

  void interrupt() {
    if (!interrupted.isCompleted) {
      interrupted.complete();
    }
  }
}
