import '../models/mastodon_announcement.dart';
import '../models/mastodon_conversation.dart';
import '../models/mastodon_notification.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_streaming_announcement_reaction.dart';

/// A typed event delivered by the Mastodon Streaming API.
sealed class MastodonStreamEvent {
  const MastodonStreamEvent({required this.stream});

  /// Raw `stream` array sent by the server.
  final List<String> stream;
}

/// A newly published status.
final class MastodonUpdateEvent extends MastodonStreamEvent {
  const MastodonUpdateEvent({required super.stream, required this.status});

  final MastodonStatus status;
}

/// An edited status.
final class MastodonStatusUpdateEvent extends MastodonStreamEvent {
  const MastodonStatusUpdateEvent({
    required super.stream,
    required this.status,
  });

  final MastodonStatus status;
}

/// A deleted status identifier.
final class MastodonDeleteEvent extends MastodonStreamEvent {
  const MastodonDeleteEvent({required super.stream, required this.statusId});

  final String statusId;
}

/// A user notification.
final class MastodonNotificationEvent extends MastodonStreamEvent {
  const MastodonNotificationEvent({
    required super.stream,
    required this.notification,
  });

  final MastodonNotification notification;
}

/// A direct conversation update.
final class MastodonConversationEvent extends MastodonStreamEvent {
  const MastodonConversationEvent({
    required super.stream,
    required this.conversation,
  });

  final MastodonConversation conversation;
}

/// An announcement update.
final class MastodonAnnouncementEvent extends MastodonStreamEvent {
  const MastodonAnnouncementEvent({
    required super.stream,
    required this.announcement,
  });

  final MastodonAnnouncement announcement;
}

/// An announcement reaction count update.
final class MastodonAnnouncementReactionEvent extends MastodonStreamEvent {
  const MastodonAnnouncementReactionEvent({
    required super.stream,
    required this.reaction,
  });

  final MastodonStreamingAnnouncementReaction reaction;
}

/// A deleted announcement identifier.
final class MastodonAnnouncementDeleteEvent extends MastodonStreamEvent {
  const MastodonAnnouncementDeleteEvent({
    required super.stream,
    required this.announcementId,
  });

  final String announcementId;
}

/// Notification cleanup completed on the server.
final class MastodonNotificationsMergedEvent extends MastodonStreamEvent {
  const MastodonNotificationsMergedEvent({required super.stream});
}

/// The authenticated user's filters changed.
///
/// Mastodon 4.3 and newer normally discard this payload-free event before it
/// reaches clients. It remains typed for older and compatible servers.
final class MastodonFiltersChangedEvent extends MastodonStreamEvent {
  const MastodonFiltersChangedEvent({required super.stream});
}

/// An unsupported event or an event whose payload could not be decoded.
final class MastodonUnknownStreamEvent extends MastodonStreamEvent {
  const MastodonUnknownStreamEvent({
    required super.stream,
    required this.event,
    required this.rawPayload,
  });

  /// Wire-format event name.
  final String event;

  /// Undecoded payload, when present.
  final String? rawPayload;
}
