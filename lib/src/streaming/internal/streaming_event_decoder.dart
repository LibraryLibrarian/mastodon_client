import 'dart:convert';

import '../../models/mastodon_announcement.dart';
import '../../models/mastodon_conversation.dart';
import '../../models/mastodon_notification.dart';
import '../../models/mastodon_status.dart';
import '../../models/mastodon_streaming_announcement_reaction.dart';
import '../streaming_event.dart';
import '../streaming_message.dart';

/// Decodes one raw Streaming API message into a typed event.
MastodonStreamEvent decodeMastodonStreamEvent(
  MastodonStreamingMessage message,
) {
  try {
    return switch (message.event) {
      'update' => MastodonUpdateEvent(
        stream: message.stream,
        status: MastodonStatus.fromJson(_decodeObject(message.payload)),
      ),
      'status.update' => MastodonStatusUpdateEvent(
        stream: message.stream,
        status: MastodonStatus.fromJson(_decodeObject(message.payload)),
      ),
      'delete' => MastodonDeleteEvent(
        stream: message.stream,
        statusId: _requirePayload(message.payload),
      ),
      'notification' => MastodonNotificationEvent(
        stream: message.stream,
        notification: MastodonNotification.fromJson(
          _decodeObject(message.payload),
        ),
      ),
      'conversation' => MastodonConversationEvent(
        stream: message.stream,
        conversation: MastodonConversation.fromJson(
          _decodeObject(message.payload),
        ),
      ),
      'announcement' => MastodonAnnouncementEvent(
        stream: message.stream,
        announcement: MastodonAnnouncement.fromJson(
          _decodeObject(message.payload),
        ),
      ),
      'announcement.reaction' => MastodonAnnouncementReactionEvent(
        stream: message.stream,
        reaction: MastodonStreamingAnnouncementReaction.fromJson(
          _decodeObject(message.payload),
        ),
      ),
      'announcement.delete' => MastodonAnnouncementDeleteEvent(
        stream: message.stream,
        announcementId: _requirePayload(message.payload),
      ),
      'notifications_merged' => MastodonNotificationsMergedEvent(
        stream: message.stream,
      ),
      'filters_changed' => MastodonFiltersChangedEvent(stream: message.stream),
      _ => _unknown(message),
    };
  } on Object {
    return _unknown(message);
  }
}

MastodonUnknownStreamEvent _unknown(MastodonStreamingMessage message) =>
    MastodonUnknownStreamEvent(
      stream: message.stream,
      event: message.event,
      rawPayload: message.payload,
    );

Map<String, dynamic> _decodeObject(String? rawPayload) {
  final decoded = jsonDecode(_requirePayload(rawPayload));
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Streaming event payload must be an object');
  }
  return decoded;
}

String _requirePayload(String? rawPayload) {
  if (rawPayload == null) {
    throw const FormatException('Streaming event payload is required');
  }
  return rawPayload;
}
