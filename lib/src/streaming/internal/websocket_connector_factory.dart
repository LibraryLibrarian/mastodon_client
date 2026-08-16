import 'package:web_socket_channel/web_socket_channel.dart';

import 'websocket_channel_connection.dart';
import 'websocket_types.dart';

/// Creates the platform-default connector.
WebSocketConnector createDefaultWebSocketConnector() =>
    _DefaultWebSocketConnector();

final class _DefaultWebSocketConnector implements WebSocketConnector {
  @override
  Future<WebSocketConnection> connect(WebSocketConnectOptions options) async {
    if (options.headers.isNotEmpty) {
      throw const WebSocketConnectorException(
        message: 'WebSocket handshake headers are unsupported on this platform',
      );
    }

    final channel = WebSocketChannel.connect(
      options.uri,
      protocols: options.protocols.isEmpty ? null : options.protocols,
    );
    try {
      final ready = channel.ready;
      if (options.connectTimeout case final timeout?) {
        await ready.timeout(timeout);
      } else {
        await ready;
      }
      return WebSocketChannelConnection(channel);
    } catch (error) {
      try {
        await channel.sink.close();
      } catch (_) {
        // 接続失敗の原因を close 側の例外で上書きしない。
      }
      throw WebSocketConnectorException(
        message: 'WebSocket handshake failed',
        cause: error,
      );
    }
  }
}
