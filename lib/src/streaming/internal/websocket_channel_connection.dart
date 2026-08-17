import 'package:web_socket_channel/web_socket_channel.dart';

import 'websocket_types.dart';

/// Adapts a [WebSocketChannel] to [WebSocketConnection].
final class WebSocketChannelConnection implements WebSocketConnection {
  /// Creates an adapter around [channel].
  WebSocketChannelConnection(this.channel);

  /// Wrapped channel.
  final WebSocketChannel channel;

  @override
  Stream<Object?> get messages => channel.stream.cast<Object?>();

  @override
  int? get closeCode => channel.closeCode;

  @override
  String? get closeReason => channel.closeReason;

  @override
  void sendText(String data) => channel.sink.add(data);

  @override
  Future<void> close([int? closeCode, String? closeReason]) async {
    await channel.sink.close(closeCode, closeReason);
  }
}
