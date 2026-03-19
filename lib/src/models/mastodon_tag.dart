import 'package:json_annotation/json_annotation.dart';

part 'mastodon_tag.g.dart';

/// Hashtag information model.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTag {
  /// Creates a [MastodonTag] with the given fields.
  const MastodonTag({
    required this.id,
    required this.name,
    required this.url,
    this.history = const [],
    this.following,
    this.featuring,
  });

  /// Creates a [MastodonTag] from a JSON map.
  factory MastodonTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonTagFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTagToJson(this);

  /// Database ID of the tag.
  @JsonKey(defaultValue: '')
  final String id;

  /// Name of the hashtag without the `#` symbol.
  final String name;

  /// URL to the hashtag on the instance.
  @JsonKey(defaultValue: '')
  final String url;

  /// Recent daily usage statistics.
  @JsonKey(defaultValue: [])
  final List<MastodonTagHistory> history;

  /// Whether the authenticated user is following this tag (authenticated only).
  final bool? following;

  /// Whether the authenticated user is featuring this tag on their profile
  /// (authenticated only).
  final bool? featuring;
}

/// Daily usage statistics for a hashtag.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTagHistory {
  /// Creates a [MastodonTagHistory] with the given fields.
  const MastodonTagHistory({
    required this.day,
    required this.uses,
    required this.accounts,
  });

  /// Creates a [MastodonTagHistory] from a JSON map.
  factory MastodonTagHistory.fromJson(Map<String, dynamic> json) =>
      _$MastodonTagHistoryFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTagHistoryToJson(this);

  /// UNIX timestamp at midnight of the day (string).
  final String day;

  /// Number of times the tag was used on that day (string).
  final String uses;

  /// Number of accounts that used the tag on that day (string).
  final String accounts;
}
