import 'package:json_annotation/json_annotation.dart';

part 'mastodon_preview_card.g.dart';

/// プレビューカードの種別
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonPreviewCardType {
  /// リンク型のOEmbed
  link,

  /// 写真型のOEmbed
  photo,

  /// 動画型のOEmbed
  video,

  /// リッチ型のOEmbed
  rich,
}

/// リンク先のプレビューカード
///
/// `GET /api/v1/statuses/:id/card` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPreviewCard {
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

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonPreviewCardToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'link';

  /// リンク先のURL
  final String url;

  /// リンク先のタイトル
  @JsonKey(defaultValue: '')
  final String title;

  /// プレビューの説明文
  @JsonKey(defaultValue: '')
  final String description;

  /// プレビューカードの種別
  @JsonKey(readValue: _readType, unknownEnumValue: MastodonPreviewCardType.link)
  final MastodonPreviewCardType type;

  /// コンテンツ作成者の名前
  ///
  /// Mastodon 4.3.0以降は非推奨。代わりに [authors] を使用する。
  @JsonKey(defaultValue: '')
  final String authorName;

  /// コンテンツ作成者のURL
  ///
  /// Mastodon 4.3.0以降は非推奨。代わりに [authors] を使用する。
  @JsonKey(defaultValue: '')
  final String authorUrl;

  /// コンテンツ提供元の名前
  @JsonKey(defaultValue: '')
  final String providerName;

  /// コンテンツ提供元のURL
  @JsonKey(defaultValue: '')
  final String providerUrl;

  /// プレビュー生成用のHTML
  @JsonKey(defaultValue: '')
  final String html;

  /// プレビューの幅（ピクセル）
  @JsonKey(defaultValue: 0)
  final int width;

  /// プレビューの高さ（ピクセル）
  @JsonKey(defaultValue: 0)
  final int height;

  /// プレビューサムネイルのURL。存在しない場合は `null`
  final String? image;

  /// 写真埋め込み用のURL
  @JsonKey(defaultValue: '')
  final String embedUrl;

  /// サムネイル用のBlurhash文字列。存在しない場合は `null`
  final String? blurhash;

  /// コンテンツ作成者のリスト（Mastodon 4.3.0+）
  @JsonKey(defaultValue: <MastodonPreviewCardAuthor>[])
  final List<MastodonPreviewCardAuthor> authors;
}

/// プレビューカードの作成者情報（Mastodon 4.3.0+）
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPreviewCardAuthor {
  const MastodonPreviewCardAuthor({required this.name, this.url, this.account});

  factory MastodonPreviewCardAuthor.fromJson(Map<String, dynamic> json) =>
      _$MastodonPreviewCardAuthorFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonPreviewCardAuthorToJson(this);

  /// 作成者の名前
  @JsonKey(defaultValue: '')
  final String name;

  /// 作成者のプロフィールURL
  final String? url;

  /// 作成者のFediverseアカウントURI
  final String? account;
}
