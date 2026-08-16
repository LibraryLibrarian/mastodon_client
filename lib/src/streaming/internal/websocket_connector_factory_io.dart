import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'websocket_channel_connection.dart';
import 'websocket_types.dart';

/// Creates the dart:io WebSocket connector.
WebSocketConnector createDefaultWebSocketConnector() => _IoWebSocketConnector();

final class _IoWebSocketConnector implements WebSocketConnector {
  @override
  Future<WebSocketConnection> connect(WebSocketConnectOptions options) async {
    final channel = IOWebSocketChannel.connect(
      options.uri,
      protocols: options.protocols.isEmpty ? null : options.protocols,
      headers: options.headers.isEmpty ? null : options.headers,
      pingInterval: options.pingInterval,
      connectTimeout: options.connectTimeout,
    );
    try {
      await channel.ready;
      return WebSocketChannelConnection(channel);
    } catch (error) {
      try {
        await channel.sink.close();
      } catch (_) {
        // 接続失敗の原因を close 側の例外で上書きしない。
      }
      throw WebSocketConnectorException(
        message: 'WebSocket handshake failed',
        statusCode: _statusCodeOf(error),
        cause: error,
      );
    }
  }

  int? _statusCodeOf(Object error) {
    final inner = error is WebSocketChannelException ? error.inner : error;
    return inner is WebSocketException ? inner.httpStatusCode : null;
  }
}
