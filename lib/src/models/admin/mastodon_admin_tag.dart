import 'package:freezed_annotation/freezed_annotation.dart';
import '../mastodon_tag.dart';

part 'mastodon_admin_tag.freezed.dart';
part 'mastodon_admin_tag.g.dart';

/// Admin-level hashtag information.
///
/// Extends the standard [MastodonTag] with admin-specific trend management
/// fields.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminTag with _$MastodonAdminTag {
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
  @override
  final String id;

  /// Name of the hashtag without the `#` symbol.
  @override
  final String name;

  /// URL to the hashtag on the instance.
  @JsonKey(defaultValue: '')
  @override
  final String url;

  /// Recent daily usage statistics.
  @JsonKey(defaultValue: [])
  @override
  final List<MastodonTagHistory> history;

  /// Whether the tag is approved to appear as a trend.
  @override
  final bool? trendable;

  /// Whether automatic linking is enabled.
  @override
  final bool? usable;

  /// Whether review is required.
  @override
  final bool? requiresReview;

  /// Whether the tag can be listed.
  @override
  final bool? listable;
}
