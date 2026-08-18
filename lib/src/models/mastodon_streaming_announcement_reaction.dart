import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_streaming_announcement_reaction.freezed.dart';
part 'mastodon_streaming_announcement_reaction.g.dart';

/// Reaction update delivered by the `announcement.reaction` streaming event.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStreamingAnnouncementReaction
    with _$MastodonStreamingAnnouncementReaction {
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
  @override
  final String name;

  /// Total count of this reaction.
  @override
  final int count;

  /// ID of the announcement whose reaction count changed.
  @override
  final String announcementId;
}
