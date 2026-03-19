import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_featured_tag.g.dart';

/// Hashtag featured on an account's profile.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFeaturedTag {
  /// Creates a [MastodonFeaturedTag] with the given fields.
  const MastodonFeaturedTag({
    required this.id,
    required this.name,
    required this.url,
    required this.statusesCount,
    this.lastStatusAt,
  });

  /// Creates a [MastodonFeaturedTag] from a JSON map.
  factory MastodonFeaturedTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonFeaturedTagFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFeaturedTagToJson(this);

  /// Internal ID of the featured tag.
  final String id;

  /// Name of the featured hashtag.
  final String name;

  /// URL to the list of statuses containing this hashtag.
  @JsonKey(defaultValue: '')
  final String url;

  /// Number of statuses containing this hashtag.
  @JsonKey(fromJson: parseIntFromString)
  final int statusesCount;

  /// Date of the most recent status containing this hashtag.
  @SafeDateTimeConverter()
  final DateTime? lastStatusAt;
}
