import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_status.dart';

part 'mastodon_announcement.g.dart';

/// Reaction to an announcement.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAnnouncementReaction {
  const MastodonAnnouncementReaction({
    required this.name,
    required this.count,
    required this.me,
    this.url,
    this.staticUrl,
  });

  factory MastodonAnnouncementReaction.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnouncementReactionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAnnouncementReactionToJson(this);

  /// Emoji name (Unicode emoji or custom emoji shortcode).
  final String name;

  /// Total count of this reaction.
  @JsonKey(defaultValue: 0)
  final int count;

  /// Whether the authenticated user has added this reaction.
  @JsonKey(defaultValue: false)
  final bool me;

  /// Image URL if this is a custom emoji.
  final String? url;

  /// Static image URL if this is a custom emoji.
  final String? staticUrl;
}

/// Server announcement.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAnnouncement {
  const MastodonAnnouncement({
    required this.id,
    required this.content,
    required this.allDay,
    required this.read,
    required this.emojis,
    required this.reactions,
    required this.tags,
    required this.mentions,
    required this.statuses,
    this.startsAt,
    this.endsAt,
    this.publishedAt,
    this.updatedAt,
  });

  factory MastodonAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnouncementFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAnnouncementToJson(this);

  /// Internal ID of the announcement.
  final String id;

  /// Body of the announcement (HTML).
  @JsonKey(defaultValue: '')
  final String content;

  /// Start timestamp.
  @SafeDateTimeConverter()
  final DateTime? startsAt;

  /// End timestamp.
  @SafeDateTimeConverter()
  final DateTime? endsAt;

  /// Whether this is an all-day event.
  @JsonKey(defaultValue: false)
  final bool allDay;

  /// Timestamp when published.
  @SafeDateTimeConverter()
  final DateTime? publishedAt;

  /// Timestamp when last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// Whether the announcement has been read.
  @JsonKey(defaultValue: false)
  final bool read;

  /// Custom emojis in the body.
  @JsonKey(defaultValue: [])
  final List<MastodonCustomEmoji> emojis;

  /// List of reactions.
  @JsonKey(defaultValue: [])
  final List<MastodonAnnouncementReaction> reactions;

  /// Hashtags in the body.
  @JsonKey(defaultValue: [])
  final List<MastodonTag> tags;

  /// Mentions in the body.
  @JsonKey(defaultValue: [])
  final List<MastodonMention> mentions;

  /// Statuses referenced in the body.
  @JsonKey(defaultValue: [])
  final List<MastodonAnnouncementStatus> statuses;
}

/// Status referenced in an announcement body.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAnnouncementStatus {
  const MastodonAnnouncementStatus({
    required this.id,
    required this.url,
  });

  factory MastodonAnnouncementStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnouncementStatusFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAnnouncementStatusToJson(this);

  /// Status ID.
  final String id;

  /// Status URL.
  @JsonKey(defaultValue: '')
  final String url;
}
