import 'package:json_annotation/json_annotation.dart';

part 'mastodon_oembed.g.dart';

/// OEmbed metadata for Mastodon.
///
/// Corresponds to the response from `/api/oembed`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOEmbed {
  const MastodonOEmbed({
    required this.type,
    required this.version,
    required this.title,
    required this.authorName,
    required this.authorUrl,
    required this.providerName,
    required this.providerUrl,
    required this.cacheAge,
    required this.html,
    required this.width,
    this.height,
  });

  factory MastodonOEmbed.fromJson(Map<String, dynamic> json) =>
      _$MastodonOEmbedFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonOEmbedToJson(this);

  /// OEmbed type. Always `"rich"`.
  final String type;

  /// OEmbed version. Always `"1.0"`.
  final String version;

  /// Description title of the status.
  final String title;

  /// Display name of the author.
  final String authorName;

  /// Profile URL of the author.
  final String authorUrl;

  /// Domain name of the instance.
  final String providerName;

  /// Base URL of the instance.
  final String providerUrl;

  /// Recommended cache duration in seconds.
  final int cacheAge;

  /// HTML code for the embed iframe.
  final String html;

  /// Width of the iframe in pixels.
  final int width;

  /// Height of the iframe in pixels. `null` if unspecified.
  final int? height;
}
