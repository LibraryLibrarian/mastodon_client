import 'package:json_annotation/json_annotation.dart';
import '../mastodon_tag.dart';

part 'mastodon_admin_tag.g.dart';

/// Admin-level hashtag information.
///
/// Extends the standard [MastodonTag] with admin-specific trend management
/// fields.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminTag {
  const MastodonAdminTag({
    required this.id,
    required this.name,
    required this.url,
    this.history = const [],
    this.trendable,
    this.usable,
    this.requiresReview,
    this.listable,
  });

  factory MastodonAdminTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminTagFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminTagToJson(this);

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

  /// Whether the tag is approved to appear as a trend.
  final bool? trendable;

  /// Whether automatic linking is enabled.
  final bool? usable;

  /// Whether review is required.
  final bool? requiresReview;

  /// Whether the tag can be listed.
  final bool? listable;
}
