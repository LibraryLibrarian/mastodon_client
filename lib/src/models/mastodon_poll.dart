import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_poll.g.dart';

/// Poll option.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPollOption {
  const MastodonPollOption({
    required this.title,
    this.votesCount,
  });

  factory MastodonPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollOptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPollOptionToJson(this);

  /// Text of the option.
  final String title;

  /// Number of votes for this option. Null for non-public polls.
  final int? votesCount;
}

/// Mastodon poll.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPoll {
  const MastodonPoll({
    required this.id,
    required this.expired,
    required this.multiple,
    required this.votesCount,
    required this.options,
    required this.emojis,
    this.expiresAt,
    this.votersCount,
    this.voted,
    this.ownVotes,
  });

  factory MastodonPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPollToJson(this);

  /// Internal ID of the poll.
  final String id;

  /// Expiration timestamp of the poll.
  @SafeDateTimeConverter()
  final DateTime? expiresAt;

  /// Whether the poll has ended.
  @JsonKey(defaultValue: false)
  final bool expired;

  /// Whether multiple choices are allowed.
  @JsonKey(defaultValue: false)
  final bool multiple;

  /// Total number of votes.
  @JsonKey(defaultValue: 0)
  final int votesCount;

  /// Number of unique voters (differs from votesCount for multiple-choice
  /// polls).
  final int? votersCount;

  /// List of options.
  final List<MastodonPollOption> options;

  /// List of custom emojis used in the poll.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// Whether the authenticated user has voted.
  final bool? voted;

  /// List of option indices the authenticated user voted for.
  final List<int>? ownVotes;
}
