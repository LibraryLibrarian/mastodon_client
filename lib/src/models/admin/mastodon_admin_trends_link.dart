import 'package:json_annotation/json_annotation.dart';

import '../mastodon_preview_card.dart';
import '../mastodon_trends_link.dart';

part 'mastodon_admin_trends_link.g.dart';

/// Admin-level trending link.
///
/// Includes all fields from the standard [MastodonTrendsLink] plus
/// admin-specific [id] and [requiresReview].
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminTrendsLink {
  const MastodonAdminTrendsLink({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.type,
    required this.authorName,
    required this.authorUrl,
    required this.providerName,
    required this.providerUrl,
    required this.html,
    required this.width,
    required this.height,
    required this.embedUrl,
    required this.authors,
    required this.history,
    this.image,
    this.blurhash,
    this.requiresReview,
  });

  factory MastodonAdminTrendsLink.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminTrendsLinkFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminTrendsLinkToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'link';

  /// Database ID of the trending link.
  final String id;

  /// URL of the link target.
  final String url;

  /// Title of the link target.
  @JsonKey(defaultValue: '')
  final String title;

  /// Description of the preview.
  @JsonKey(defaultValue: '')
  final String description;

  /// Type of the preview card.
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonPreviewCardType.link,
  )
  final MastodonPreviewCardType type;

  /// Name of the content author.
  @JsonKey(defaultValue: '')
  final String authorName;

  /// URL of the content author.
  @JsonKey(defaultValue: '')
  final String authorUrl;

  /// Name of the content provider.
  @JsonKey(defaultValue: '')
  final String providerName;

  /// URL of the content provider.
  @JsonKey(defaultValue: '')
  final String providerUrl;

  /// HTML for generating the preview.
  @JsonKey(defaultValue: '')
  final String html;

  /// Width of the preview in pixels.
  @JsonKey(defaultValue: 0)
  final int width;

  /// Height of the preview in pixels.
  @JsonKey(defaultValue: 0)
  final int height;

  /// URL of the preview thumbnail.
  final String? image;

  /// URL for embedding photos.
  @JsonKey(defaultValue: '')
  final String embedUrl;

  /// Blurhash string for the thumbnail.
  final String? blurhash;

  /// List of content authors (Mastodon 4.3.0+).
  @JsonKey(defaultValue: <MastodonPreviewCardAuthor>[])
  final List<MastodonPreviewCardAuthor> authors;

  /// History of daily usage statistics.
  @JsonKey(defaultValue: <MastodonTrendsLinkHistory>[])
  final List<MastodonTrendsLinkHistory> history;

  /// Whether moderator review is required.
  final bool? requiresReview;
}
