import '../models/mastodon_status.dart';
import 'streaming_event.dart';
import 'streaming_message.dart';

/// A reference-counted Mastodon Streaming API subscription handle.
class MastodonStreamingSubscription {
  /// Creates a subscription handle managed by [MastodonStreaming].
  MastodonStreamingSubscription.managed({
    required this.streamName,
    required Map<String, String> params,
    required Stream<MastodonStreamingMessage> messages,
    required Stream<MastodonStreamEvent> events,
    required Future<void> Function() onCancel,
    required bool Function() onIsActive,
  }) : params = Map.unmodifiable(params),
       _messages = messages,
       _events = events,
       _statuses = events
           .where(
             (event) =>
                 event is MastodonUpdateEvent ||
                 event is MastodonStatusUpdateEvent,
           )
           .map(
             (event) => switch (event) {
               MastodonUpdateEvent(:final status) => status,
               MastodonStatusUpdateEvent(:final status) => status,
               _ => throw StateError('Unexpected status event'),
             },
           ),
       _onCancel = onCancel,
       _onIsActive = onIsActive;

  /// Raw wire-format channel name.
  final String streamName;

  /// Parameters sent alongside the channel name.
  final Map<String, String> params;

  final Stream<MastodonStreamingMessage> _messages;
  final Stream<MastodonStreamEvent> _events;
  final Stream<MastodonStatus> _statuses;
  final Future<void> Function() _onCancel;
  final bool Function() _onIsActive;
  Future<void>? _cancelFuture;

  /// Raw messages routed to this subscription.
  Stream<MastodonStreamingMessage> get messages => _messages;

  /// Typed events decoded from [messages].
  Stream<MastodonStreamEvent> get events => _events;

  /// Statuses from `update` and `status.update` events.
  Stream<MastodonStatus> get statuses => _statuses;

  /// Whether this handle still contributes to the reference count.
  bool get isActive => _onIsActive();

  /// Releases this handle.
  ///
  /// The server receives `unsubscribe` only when the final handle for the
  /// normalized stream key is released. The first call reports an unsubscribe
  /// failure, while later calls are safe and complete without repeating it.
  Future<void> cancel() {
    final pending = _cancelFuture;
    if (pending != null) {
      return pending;
    }
    if (!isActive) {
      return Future<void>.value();
    }

    final future = _onCancel();
    _cancelFuture = future;
    return future.whenComplete(() {
      if (identical(_cancelFuture, future)) {
        _cancelFuture = null;
      }
    });
  }

  /// Alias for [cancel].
  Future<void> unsubscribe() => cancel();
}
