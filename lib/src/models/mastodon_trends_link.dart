import 'package:json_annotation/json_annotation.dart';

import 'mastodon_preview_card.dart';

part 'mastodon_trends_link.g.dart';

/// Daily usage statistics for a trending link.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTrendsLinkHistory {
  const MastodonTrendsLinkHistory({
    required this.day,
    required this.accounts,
    required this.uses,
  });

  factory MastodonTrendsLinkHistory.fromJson(Map<String, dynamic> json) =>
      _$MastodonTrendsLinkHistoryFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTrendsLinkHistoryToJson(this);

  /// Date as a UNIX timestamp in seconds (string).
  @JsonKey(defaultValue: '0')
  final String day;

  /// Number of accounts that shared the link on that day (string).
  @JsonKey(defaultValue: '0')
  final String accounts;

  /// Number of times the link was shared on that day (string).
  @JsonKey(defaultValue: '0')
  final String uses;
}

/// Trending link.
///
/// Corresponds to the response from `GET /api/v1/trends/links`.
/// Includes all [MastodonPreviewCard] fields plus trend-specific [history].
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTrendsLink {
  const MastodonTrendsLink({
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
  });

  factory MastodonTrendsLink.fromJson(Map<String, dynamic> json) =>
      _$MastodonTrendsLinkFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTrendsLinkToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'link';

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
}
