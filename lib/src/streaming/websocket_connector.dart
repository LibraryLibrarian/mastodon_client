import 'internal/websocket_connector_factory.dart'
    if (dart.library.io) 'internal/websocket_connector_factory_io.dart'
    as platform;
import 'internal/websocket_types.dart';

export 'internal/websocket_types.dart';

/// Creates the package's platform-default WebSocket connector.
WebSocketConnector createDefaultWebSocketConnector() =>
    platform.createDefaultWebSocketConnector();
