import 'dart:async';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonStreaming authentication', () {
    test(
      'falls back across auth modes and remembers the successful mode',
      () async {
        final firstSocket = _FakeWebSocketConnection();
        final replacementSocket = _FakeWebSocketConnection();
        final connector = _FakeWebSocketConnector([
          const WebSocketConnectorException(message: 'subprotocol rejected'),
          const WebSocketConnectorException(message: 'header rejected'),
          firstSocket,
          replacementSocket,
        ]);
        var reconnects = 0;
        final streaming = _streaming(
          connector,
          onReconnect: () => reconnects++,
        );

        await streaming.connect();

        expect(connector.options, hasLength(3));
        expect(connector.options[0].protocols, ['secret-token']);
        expect(connector.options[0].headers, isEmpty);
        expect(connector.options[0].pingInterval, const Duration(seconds: 30));
        expect(connector.options[1].protocols, isEmpty);
        expect(
          connector.options[1].headers['Authorization'],
          'Bearer secret-token',
        );
        expect(
          connector.options[2].uri.queryParameters['access_token'],
          'secret-token',
        );
        expect(
          streaming.successfulAuthMode,
          MastodonStreamingAuthMode.queryParameter,
        );

        await firstSocket.closeFromServer(1011);
        await _waitUntil(() => connector.options.length == 4);

        expect(
          connector.options[3].uri.queryParameters['access_token'],
          'secret-token',
        );
        expect(connector.options[3].protocols, isEmpty);
        expect(reconnects, 1);

        await streaming.dispose();
      },
    );

    test('an HTTP 401 aborts fallback and automatic retries', () async {
      final connector = _FakeWebSocketConnector([
        const WebSocketConnectorException(
          message: 'unauthorized',
          statusCode: 401,
        ),
      ]);
      final streaming = _streaming(connector);
      final observedError = streaming.errors.first;

      await expectLater(
        streaming.connect(),
        throwsA(
          isA<MastodonStreamingConnectionException>().having(
            (error) => error.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
      expect(
        await observedError,
        isA<MastodonStreamingConnectionException>().having(
          (error) => error.statusCode,
          'statusCode',
          401,
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(connector.options, hasLength(1));
      expect(streaming.state, MastodonStreamingConnectionState.disconnected);

      await streaming.dispose();
    });
  });

  group('MastodonStreaming close handling', () {
    for (final testCase in [
      (code: 1000, reconnect: false, emitsError: false),
      (code: 1005, reconnect: false, emitsError: true),
      (code: 1003, reconnect: false, emitsError: true),
      (code: 1011, reconnect: true, emitsError: true),
    ]) {
      test('handles close code ${testCase.code}', () async {
        final socket = _FakeWebSocketConnection();
        final replacement = _FakeWebSocketConnection();
        final connector = _FakeWebSocketConnector([socket, replacement]);
        final streaming = _streaming(connector);
        final errors = <MastodonStreamingException>[];
        final errorSubscription = streaming.errors.listen(errors.add);
        await streaming.connect();

        await socket.closeFromServer(testCase.code);
        if (testCase.reconnect) {
          await _waitUntil(() => connector.options.length == 2);
          expect(streaming.state, MastodonStreamingConnectionState.connected);
        } else {
          await Future<void>.delayed(Duration.zero);
          expect(connector.options, hasLength(1));
          expect(
            streaming.state,
            MastodonStreamingConnectionState.disconnected,
          );
        }

        if (testCase.emitsError) {
          expect(
            errors,
            contains(
              isA<MastodonStreamingClosedException>().having(
                (error) => error.closeCode,
                'closeCode',
                testCase.code,
              ),
            ),
          );
        } else {
          expect(errors, isEmpty);
        }

        await errorSubscription.cancel();
        await streaming.dispose();
      });
    }
  });

  test('reconnect backoff grows, includes jitter, and stays capped', () async {
    final socket = _FakeWebSocketConnection();
    final connector = _FakeWebSocketConnector([socket]);
    final delays = <Duration>[];
    final streaming = _streaming(
      connector,
      config: MastodonStreamingConfig(
        reconnectInitialDelay: const Duration(seconds: 1),
        reconnectMaxDelay: const Duration(seconds: 4),
        reconnectJitter: 0.5,
        maxReconnectAttempts: 4,
      ),
      jitterSource: () => 1,
      delay: (duration) async {
        delays.add(duration);
      },
    );
    await streaming.connect();

    await socket.closeFromServer(1011);
    await _waitUntil(() => delays.length == 4);

    expect(delays, [
      const Duration(milliseconds: 1500),
      const Duration(seconds: 3),
      const Duration(seconds: 4),
      const Duration(seconds: 4),
    ]);

    await streaming.dispose();
  });

  test('logs redact query authentication tokens', () async {
    final connector = _FakeWebSocketConnector([_FakeWebSocketConnection()]);
    final messages = <String>[];
    final streaming = _streaming(
      connector,
      config: MastodonStreamingConfig(
        authMode: MastodonStreamingAuthMode.queryParameter,
        enableAuthFallback: false,
      ),
      logger: FunctionLogger((level, message) => messages.add(message)),
      enableLog: true,
    );

    await streaming.connect();

    expect(messages.join('\n'), isNot(contains('secret-token')));
    expect(messages.join('\n'), contains('access_token'));
    expect(messages.join('\n'), contains('REDACTED'));

    await streaming.dispose();
  });

  test('suspend closes the socket and resume reconnects immediately', () async {
    final firstSocket = _FakeWebSocketConnection();
    final secondSocket = _FakeWebSocketConnection();
    final connector = _FakeWebSocketConnector([firstSocket, secondSocket]);
    var reconnects = 0;
    final streaming = _streaming(connector, onReconnect: () => reconnects++);
    await streaming.connect();

    await streaming.suspend();

    expect(streaming.state, MastodonStreamingConnectionState.suspended);
    expect(firstSocket.closedByClient, isTrue);
    expect(connector.options, hasLength(1));

    await streaming.resume();

    expect(connector.options, hasLength(2));
    expect(streaming.state, MastodonStreamingConnectionState.connected);
    expect(reconnects, 1);

    await streaming.dispose();
  });

  test('exposes raw text frames and a text-only send seam', () async {
    final socket = _FakeWebSocketConnection();
    final streaming = _streaming(_FakeWebSocketConnector([socket]));
    await streaming.connect();
    final received = streaming.rawFrames.first;

    socket.addFromServer('{"event":"update"}');
    streaming.sendText('{"type":"subscribe"}');

    expect(await received, '{"event":"update"}');
    expect(socket.sent, ['{"type":"subscribe"}']);

    await streaming.dispose();
  });
}

MastodonStreaming _streaming(
  WebSocketConnector connector, {
  MastodonStreamingConfig? config,
  Logger? logger,
  bool enableLog = false,
  MastodonStreamingReconnectCallback? onReconnect,
  Future<void> Function(Duration duration)? delay,
  double Function()? jitterSource,
}) => MastodonStreaming.withConnector(
  baseUrl: 'https://mastodon.example',
  accessToken: 'secret-token',
  connector: connector,
  config: config,
  logger: logger,
  enableLog: enableLog,
  onReconnect: onReconnect,
  delay: delay ?? (_) async {},
  jitterSource: jitterSource ?? () => 0.5,
);

Future<void> _waitUntil(bool Function() condition) async {
  for (var attempt = 0; attempt < 100; attempt++) {
    if (condition()) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
  fail('Condition was not met before the test timeout');
}

final class _FakeWebSocketConnector implements WebSocketConnector {
  _FakeWebSocketConnector(this._outcomes);

  final List<Object> _outcomes;
  final List<WebSocketConnectOptions> options = [];
  var _nextOutcome = 0;

  @override
  Future<WebSocketConnection> connect(WebSocketConnectOptions options) async {
    this.options.add(options);
    if (_nextOutcome >= _outcomes.length) {
      throw const WebSocketConnectorException(message: 'connection failed');
    }
    final outcome = _outcomes[_nextOutcome++];
    if (outcome is WebSocketConnection) {
      return outcome;
    }
    throw outcome;
  }
}

final class _FakeWebSocketConnection implements WebSocketConnection {
  final StreamController<Object?> _controller = StreamController<Object?>();
  final List<String> sent = [];
  int? _closeCode;
  String? _closeReason;
  bool closedByClient = false;

  @override
  Stream<Object?> get messages => _controller.stream;

  @override
  int? get closeCode => _closeCode;

  @override
  String? get closeReason => _closeReason;

  @override
  void sendText(String data) => sent.add(data);

  void addFromServer(String data) => _controller.add(data);

  Future<void> closeFromServer(int? code, [String? reason]) async {
    _closeCode = code;
    _closeReason = reason;
    await _controller.close();
  }

  @override
  Future<void> close([int? closeCode, String? closeReason]) async {
    closedByClient = true;
    _closeCode ??= closeCode;
    _closeReason ??= closeReason;
    if (!_controller.isClosed) {
      await _controller.close();
    }
  }
}
