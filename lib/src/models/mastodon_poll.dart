import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_poll.freezed.dart';
part 'mastodon_poll.g.dart';

/// Poll option.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPollOption with _$MastodonPollOption {
  const MastodonPollOption({required this.title, this.votesCount});

  factory MastodonPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollOptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPollOptionToJson(this);

  /// Text of the option.
  @override
  final String title;

  /// Number of votes for this option. Null for non-public polls.
  @override
  final int? votesCount;
}

/// Mastodon poll.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPoll with _$MastodonPoll {
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
  @override
  final String id;

  /// Expiration timestamp of the poll.
  @SafeDateTimeConverter()
  @override
  final DateTime? expiresAt;

  /// Whether the poll has ended.
  @JsonKey(defaultValue: false)
  @override
  final bool expired;

  /// Whether multiple choices are allowed.
  @JsonKey(defaultValue: false)
  @override
  final bool multiple;

  /// Total number of votes.
  @JsonKey(defaultValue: 0)
  @override
  final int votesCount;

  /// Number of unique voters (differs from votesCount for multiple-choice
  /// polls).
  @override
  final int? votersCount;

  /// List of options.
  @override
  final List<MastodonPollOption> options;

  /// List of custom emojis used in the poll.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  @override
  final List<MastodonCustomEmoji> emojis;

  /// Whether the authenticated user has voted.
  @override
  final bool? voted;

  /// List of option indices the authenticated user voted for.
  @override
  final List<int>? ownVotes;
}
