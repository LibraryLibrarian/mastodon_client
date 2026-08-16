/// Lifecycle state of a Mastodon Streaming API connection.
enum MastodonStreamingConnectionState {
  /// No WebSocket connection is active.
  disconnected,

  /// The initial WebSocket connection is being established.
  connecting,

  /// The WebSocket connection is open and ready for messages.
  connected,

  /// An automatic replacement connection is being established.
  reconnecting,

  /// The connection is paused until the application resumes.
  suspended,

  /// The streaming client has released its resources and cannot be reused.
  disposed,
}
