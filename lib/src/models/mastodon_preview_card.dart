import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_preview_card.freezed.dart';
part 'mastodon_preview_card.g.dart';

/// Type of preview card.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonPreviewCardType {
  /// Link-type OEmbed.
  link,

  /// Photo-type OEmbed.
  photo,

  /// Video-type OEmbed.
  video,

  /// Rich-type OEmbed.
  rich,
}

/// Preview card for a link.
///
/// Embedded in the `MastodonStatus.card` property since Mastodon 2.6.0.
/// The former `GET /api/v1/statuses/:id/card` endpoint was removed in 3.0.0.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPreviewCard with _$MastodonPreviewCard {
  const MastodonPreviewCard({
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
    this.image,
    this.blurhash,
  });

  factory MastodonPreviewCard.fromJson(Map<String, dynamic> json) =>
      _$MastodonPreviewCardFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPreviewCardToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'link';

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

  /// Type of the preview card.
  @JsonKey(readValue: _readType, unknownEnumValue: MastodonPreviewCardType.link)
  @override
  final MastodonPreviewCardType type;

  /// Name of the content author.
  ///
  /// Deprecated since Mastodon 4.3.0. Use [authors] instead.
  @JsonKey(defaultValue: '')
  @override
  final String authorName;

  /// URL of the content author.
  ///
  /// Deprecated since Mastodon 4.3.0. Use [authors] instead.
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

  /// URL of the preview thumbnail. `null` if not available.
  @override
  final String? image;

  /// URL for embedding photos.
  @JsonKey(defaultValue: '')
  @override
  final String embedUrl;

  /// Blurhash string for the thumbnail. `null` if not available.
  @override
  final String? blurhash;

  /// List of content authors (Mastodon 4.3.0+).
  @JsonKey(defaultValue: <MastodonPreviewCardAuthor>[])
  @override
  final List<MastodonPreviewCardAuthor> authors;
}

/// Author information for a preview card (Mastodon 4.3.0+).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPreviewCardAuthor with _$MastodonPreviewCardAuthor {
  const MastodonPreviewCardAuthor({required this.name, this.url, this.account});

  factory MastodonPreviewCardAuthor.fromJson(Map<String, dynamic> json) =>
      _$MastodonPreviewCardAuthorFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPreviewCardAuthorToJson(this);

  /// Name of the author.
  @JsonKey(defaultValue: '')
  @override
  final String name;

  /// Profile URL of the author.
  @override
  final String? url;

  /// Fediverse account URI of the author.
  @override
  final String? account;
}
