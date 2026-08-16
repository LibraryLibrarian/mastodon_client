import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

    test('uses lazily resolved instance metadata for the endpoint', () async {
      final connector = _FakeWebSocketConnector([_FakeWebSocketConnection()]);
      final streaming = MastodonStreaming.withConnector(
        baseUrl: 'https://rest.example',
        accessToken: 'secret-token',
        connector: connector,
        metadataProvider: () async =>
            (instance: null, instanceV1: _instanceV1('wss://stream.example')),
      );

      await streaming.connect();

      expect(
        connector.options.single.uri,
        Uri.parse('wss://stream.example/api/v1/streaming'),
      );
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

  group('MastodonStreaming subscriptions', () {
    test('reference counts duplicate subscriptions', () async {
      final socket = _FakeWebSocketConnection();
      final streaming = _streaming(_FakeWebSocketConnector([socket]));
      await streaming.connect();

      final first = await streaming.subscribe(const MastodonStream.user());
      final second = await streaming.subscribe(const MastodonStream.user());

      expect(_sentFrames(socket, 'subscribe'), hasLength(1));
      await first.cancel();
      expect(_sentFrames(socket, 'unsubscribe'), isEmpty);
      await second.cancel();
      expect(_sentFrames(socket, 'unsubscribe'), hasLength(1));

      await streaming.dispose();
    });

    test('normalizes hashtag keys and inbound matching', () async {
      final socket = _FakeWebSocketConnection();
      final streaming = _streaming(_FakeWebSocketConnector([socket]));
      await streaming.connect();

      final upper = await streaming.subscribe(
        const MastodonStream.hashtag('Dart'),
      );
      final lower = await streaming.subscribe(
        const MastodonStream.hashtag('dart'),
      );
      final upperEvent = upper.events.first;
      final lowerEvent = lower.events.first;

      socket.addFromServer(
        jsonEncode({
          'stream': ['hashtag', 'DART'],
          'event': 'delete',
          'payload': '999888777',
        }),
      );

      expect(_sentFrames(socket, 'subscribe'), hasLength(1));
      expect(await upperEvent, isA<MastodonDeleteEvent>());
      expect(await lowerEvent, isA<MastodonDeleteEvent>());

      await upper.cancel();
      await lower.cancel();
      await streaming.dispose();
    });

    test('matches one- and two-element stream arrays', () async {
      final socket = _FakeWebSocketConnection();
      final streaming = _streaming(_FakeWebSocketConnector([socket]));
      await streaming.connect();
      final user = await streaming.subscribe(const MastodonStream.user());
      final list = await streaming.subscribe(const MastodonStream.list('42'));
      final userMessage = user.messages.first;
      final listMessage = list.messages.first;

      socket
        ..addFromServer(
          jsonEncode({
            'stream': ['user'],
            'event': 'delete',
            'payload': '1',
          }),
        )
        ..addFromServer(
          jsonEncode({
            'stream': ['list', '42'],
            'event': 'delete',
            'payload': '2',
          }),
        );

      expect((await userMessage).stream, ['user']);
      expect((await listMessage).stream, ['list', '42']);

      await user.cancel();
      await list.cancel();
      await streaming.dispose();
    });

    test('restores every active subscription after reconnecting', () async {
      final firstSocket = _FakeWebSocketConnection();
      final secondSocket = _FakeWebSocketConnection();
      final streaming = _streaming(
        _FakeWebSocketConnector([firstSocket, secondSocket]),
      );
      await streaming.connect();
      final user = await streaming.subscribe(const MastodonStream.user());
      final list = await streaming.subscribe(const MastodonStream.list('42'));

      await firstSocket.closeFromServer(1011);
      await _waitUntil(
        () => _sentFrames(secondSocket, 'subscribe').length == 2,
      );

      expect(
        _sentFrames(secondSocket, 'subscribe').map((frame) => frame['stream']),
        containsAll(['user', 'list']),
      );

      await user.cancel();
      await list.cancel();
      await streaming.dispose();
    });

    test('associates an immediate server error with subscribe', () async {
      final socket = _FakeWebSocketConnection();
      final errorWindow = Completer<void>();
      final streaming = _streaming(
        _FakeWebSocketConnector([socket]),
        subscriptionDelay: (_) => errorWindow.future,
      );
      await streaming.connect();

      final subscription = streaming.subscribeRaw('bogus');
      await _waitUntil(() => socket.sent.isNotEmpty);
      socket.addFromServer(
        jsonEncode({'error': 'Unknown stream type', 'status': 400}),
      );

      await expectLater(
        subscription,
        throwsA(
          isA<MastodonStreamingSubscriptionException>().having(
            (error) => error.status,
            'status',
            400,
          ),
        ),
      );

      await streaming.dispose();
    });

    test('serializes subscription frames during the error window', () async {
      final socket = _FakeWebSocketConnection();
      final firstWindow = Completer<void>();
      final secondWindow = Completer<void>();
      final windows = [firstWindow, secondWindow];
      var nextWindow = 0;
      final streaming = _streaming(
        _FakeWebSocketConnector([socket]),
        subscriptionDelay: (_) => windows[nextWindow++].future,
      );
      await streaming.connect();

      final user = streaming.subscribe(const MastodonStream.user());
      await _waitUntil(() => socket.sent.length == 1);
      final list = streaming.subscribe(const MastodonStream.list('42'));
      await Future<void>.delayed(Duration.zero);
      expect(socket.sent, hasLength(1));

      firstWindow.complete();
      await user;
      await _waitUntil(() => socket.sent.length == 2);
      secondWindow.complete();
      await list;

      expect(_sentFrames(socket, 'subscribe'), hasLength(2));
      await streaming.dispose();
    });

    test('exposes statuses filtered from typed events', () async {
      final socket = _FakeWebSocketConnection();
      final streaming = _streaming(_FakeWebSocketConnector([socket]));
      await streaming.connect();
      final subscription = await streaming.subscribe(
        const MastodonStream.public(),
      );
      final status =
          jsonDecode(File('test/fixtures/status.json').readAsStringSync())
              as Map<String, dynamic>;
      final received = subscription.statuses.first;

      socket.addFromServer(
        jsonEncode({
          'stream': ['public'],
          'event': 'status.update',
          'payload': jsonEncode(status),
        }),
      );

      expect((await received).id, status['id']);
      await subscription.cancel();
      await streaming.dispose();
    });

    test(
      'turns malformed payloads into Unknown without ending streams',
      () async {
        final socket = _FakeWebSocketConnection();
        final streaming = _streaming(_FakeWebSocketConnector([socket]));
        await streaming.connect();
        final user = await streaming.subscribe(const MastodonStream.user());
        final events = <MastodonStreamEvent>[];
        final eventSubscription = user.events.listen(events.add);

        socket
          ..addFromServer(
            jsonEncode({
              'stream': ['user'],
              'event': 'update',
              'payload': '{bad json',
            }),
          )
          ..addFromServer(
            jsonEncode({
              'stream': ['user'],
              'event': 'delete',
              'payload': '999888777',
            }),
          );
        await _waitUntil(() => events.length == 2);

        expect(events[0], isA<MastodonUnknownStreamEvent>());
        expect(
          events[1],
          isA<MastodonDeleteEvent>().having(
            (event) => event.statusId,
            'statusId',
            '999888777',
          ),
        );

        await eventSubscription.cancel();
        await user.cancel();
        await streaming.dispose();
      },
    );
  });
}

MastodonStreaming _streaming(
  WebSocketConnector connector, {
  MastodonStreamingConfig? config,
  Logger? logger,
  bool enableLog = false,
  MastodonStreamingReconnectCallback? onReconnect,
  Future<void> Function(Duration duration)? delay,
  Future<void> Function(Duration duration)? subscriptionDelay,
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
  subscriptionDelay: subscriptionDelay ?? (_) async {},
  jitterSource: jitterSource ?? () => 0.5,
);

List<Map<String, dynamic>> _sentFrames(
  _FakeWebSocketConnection socket,
  String type,
) => socket.sent
    .map((frame) => jsonDecode(frame) as Map<String, dynamic>)
    .where((frame) => frame['type'] == type)
    .toList();

MastodonInstanceV1 _instanceV1(String streamingUrl) => MastodonInstanceV1(
  uri: 'rest.example',
  title: 'Test',
  version: '3.5.0',
  rules: const [],
  urls: MastodonInstanceV1Urls(streamingApi: streamingUrl),
  registrations: false,
  approvalRequired: false,
  invitesEnabled: false,
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
