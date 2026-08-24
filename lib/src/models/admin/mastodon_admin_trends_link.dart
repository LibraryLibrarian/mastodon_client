import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import '../mastodon_preview_card.dart';
import '../mastodon_trends_link.dart';

part 'mastodon_admin_trends_link.freezed.dart';
part 'mastodon_admin_trends_link.g.dart';

/// Admin-level trending link.
///
/// Includes all fields from the standard [MastodonTrendsLink] plus
/// admin-specific [id] and [requiresReview].
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminTrendsLink with _$MastodonAdminTrendsLink {
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
    this.language,
    this.image,
    this.imageDescription = '',
    this.blurhash,
    this.publishedAt,
    this.missingAttribution,
    this.requiresReview,
  });

  factory MastodonAdminTrendsLink.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminTrendsLinkFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminTrendsLinkToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'link';

  /// Database ID of the trending link.
  @override
  final String id;

  /// URL of the link target.
  @override
  final String url;

  /// Title of the link target.
  @JsonKey(defaultValue: '')
  @override
  final String title;

  /// Description of the preview.
  @JsonKey(defaultValue: '')
  @override
  final String description;

  /// ISO 639 language code detected for the linked content.
  @override
  final String? language;

  /// Type of the preview card.
  @JsonKey(readValue: _readType, unknownEnumValue: MastodonPreviewCardType.link)
  @override
  final MastodonPreviewCardType type;

  /// Name of the content author.
  @JsonKey(defaultValue: '')
  @override
  final String authorName;

  /// URL of the content author.
  @JsonKey(defaultValue: '')
  @override
  final String authorUrl;

  /// Name of the content provider.
  @JsonKey(defaultValue: '')
  @override
  final String providerName;

  /// URL of the content provider.
  @JsonKey(defaultValue: '')
  @override
  final String providerUrl;

  /// HTML for generating the preview.
  @JsonKey(defaultValue: '')
  @override
  final String html;

  /// Width of the preview in pixels.
  @JsonKey(defaultValue: 0)
  @override
  final int width;

  /// Height of the preview in pixels.
  @JsonKey(defaultValue: 0)
  @override
  final int height;

  /// URL of the preview thumbnail.
  @override
  final String? image;

  /// Alternative text for the preview image.
  @JsonKey(defaultValue: '')
  @override
  final String imageDescription;

  /// URL for embedding photos.
  @JsonKey(defaultValue: '')
  @override
  final String embedUrl;

  /// Blurhash string for the thumbnail.
  @override
  final String? blurhash;

  /// Publication timestamp of the linked content.
  @SafeDateTimeConverter()
  @override
  final DateTime? publishedAt;

  /// Whether the current user is an author whose attribution is missing.
  @override
  final bool? missingAttribution;

  /// List of content authors (Mastodon 4.3.0+).
  @JsonKey(defaultValue: <MastodonPreviewCardAuthor>[])
  @override
  final List<MastodonPreviewCardAuthor> authors;

  /// History of daily usage statistics.
  @JsonKey(defaultValue: <MastodonTrendsLinkHistory>[])
  @override
  final List<MastodonTrendsLinkHistory> history;

  /// Whether moderator review is required.
  @override
  final bool? requiresReview;
}
