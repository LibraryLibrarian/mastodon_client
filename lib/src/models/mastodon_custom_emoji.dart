import 'package:json_annotation/json_annotation.dart';

part 'mastodon_custom_emoji.g.dart';

/// Custom emoji on Mastodon.
///
/// Represents a `:shortcode:` format emoji found in account profiles and
/// status text.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCustomEmoji {
  const MastodonCustomEmoji({
    required this.shortcode,
    required this.url,
    required this.staticUrl,
    required this.visibleInPicker,
    this.category,
  });

  factory MastodonCustomEmoji.fromJson(Map<String, dynamic> json) =>
      _$MastodonCustomEmojiFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCustomEmojiToJson(this);

  /// Shortcode in `:shortcode:` format (without the colons).
  final String shortcode;

  /// URL of the animated image.
  final String url;

  /// URL of the static image.
  final String staticUrl;

  /// Whether to show in the emoji picker.
  @JsonKey(defaultValue: true)
  final bool visibleInPicker;

  /// Category name the emoji belongs to.
  final String? category;
}
