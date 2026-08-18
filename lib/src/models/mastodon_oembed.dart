import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_oembed.freezed.dart';
part 'mastodon_oembed.g.dart';

/// OEmbed metadata for Mastodon.
///
/// Corresponds to the response from `/api/oembed`.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOEmbed with _$MastodonOEmbed {
  const MastodonOEmbed({
    required this.type,
    required this.version,
    this.title,
    this.authorName,
    this.authorUrl,
    this.providerName,
    this.providerUrl,
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
  @override
  final String type;

  /// OEmbed version. Always `"1.0"`.
  @override
  final String version;

  /// Description title of the status.
  @override
  final String? title;

  /// Display name of the author.
  @override
  final String? authorName;

  /// Profile URL of the author.
  @override
  final String? authorUrl;

  /// Domain name of the instance.
  @override
  final String? providerName;

  /// Base URL of the instance.
  @override
  final String? providerUrl;

  /// Recommended cache duration in seconds.
  @override
  final int cacheAge;

  /// HTML code for the embed iframe.
  @override
  final String html;

  /// Width of the iframe in pixels.
  @override
  final int width;

  /// Height of the iframe in pixels. `null` if unspecified.
  @override
  final int? height;
}
