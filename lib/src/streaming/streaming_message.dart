import 'dart:convert';

/// A raw message envelope received from the Mastodon Streaming API.
class MastodonStreamingMessage {
  /// Creates a decoded raw message.
  MastodonStreamingMessage({
    required List<String> stream,
    required this.event,
    required this.payload,
    required this.raw,
  }) : stream = List.unmodifiable(stream);

  /// Decodes one WebSocket text frame.
  factory MastodonStreamingMessage.fromRaw(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Streaming message must be a JSON object');
    }

    final streamValue = decoded['stream'];
    if (streamValue is! List<dynamic> ||
        streamValue.isEmpty ||
        streamValue.length > 2 ||
        streamValue.any((value) => value is! String)) {
      throw const FormatException(
        'Streaming message stream must contain one or two strings',
      );
    }
    final event = decoded['event'];
    if (event is! String || event.isEmpty) {
      throw const FormatException(
        'Streaming message event must be a non-empty string',
      );
    }
    final payload = decoded['payload'];
    if (payload != null && payload is! String) {
      throw const FormatException(
        'Streaming message payload must be a string or null',
      );
    }

    return MastodonStreamingMessage(
      stream: streamValue.cast<String>(),
      event: event,
      payload: payload as String?,
      raw: raw,
    );
  }

  /// Raw `stream` array sent by the server.
  final List<String> stream;

  /// Wire-format event name.
  final String event;

  /// Undecoded payload string.
  final String? payload;

  /// Complete WebSocket text frame.
  final String raw;
}
