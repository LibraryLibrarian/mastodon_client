import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'mastodon_featured_tag.freezed.dart';
part 'mastodon_featured_tag.g.dart';

/// Hashtag featured on an account's profile.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFeaturedTag with _$MastodonFeaturedTag {
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
  @override
  final String id;

  /// Name of the featured hashtag.
  @override
  final String name;

  /// URL to the list of statuses containing this hashtag.
  @JsonKey(defaultValue: '')
  @override
  final String url;

  /// Number of statuses containing this hashtag.
  @JsonKey(fromJson: parseIntFromString)
  @override
  final int statusesCount;

  /// Date of the most recent status containing this hashtag.
  @SafeDateTimeConverter()
  @override
  final DateTime? lastStatusAt;
}
