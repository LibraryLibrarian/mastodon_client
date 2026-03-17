import 'package:json_annotation/json_annotation.dart';

part 'mastodon_custom_emoji.g.dart';

/// Mastodon のカスタム絵文字
///
/// アカウントのプロフィールや投稿テキストに含まれる `:shortcode:` 形式の絵文字を表す
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

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonCustomEmojiToJson(this);

  /// `:shortcode:` 形式のショートコード（コロンを除いた部分）
  final String shortcode;

  /// アニメーション版の画像 URL
  final String url;

  /// 静止画版の画像 URL
  final String staticUrl;

  /// 絵文字ピッカーに表示するかどうか
  @JsonKey(defaultValue: true)
  final bool visibleInPicker;

  /// 絵文字が属するカテゴリ名
  final String? category;
}
