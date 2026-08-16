import 'package:json_annotation/json_annotation.dart';

part 'mastodon_streaming_announcement_reaction.g.dart';

/// Reaction update delivered by the `announcement.reaction` streaming event.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStreamingAnnouncementReaction {
  const MastodonStreamingAnnouncementReaction({
    required this.name,
    required this.count,
    required this.announcementId,
  });

  factory MastodonStreamingAnnouncementReaction.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonStreamingAnnouncementReactionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonStreamingAnnouncementReactionToJson(this);

  /// Emoji name (Unicode emoji or custom emoji shortcode).
  final String name;

  /// Total count of this reaction.
  final int count;

  /// ID of the announcement whose reaction count changed.
  final String announcementId;
}
