import 'package:json_annotation/json_annotation.dart';

part 'mastodon_oembed.g.dart';

/// Mastodon の OEmbed メタデータ
///
/// `/api/oembed` のレスポンスに対応する
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

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonOEmbedToJson(this);

  /// OEmbed タイプ。常に `"rich"`
  final String type;

  /// OEmbed バージョン。常に `"1.0"`
  final String version;

  /// ステータスの説明タイトル
  final String title;

  /// 投稿者の表示名
  final String authorName;

  /// 投稿者のプロフィール URL
  final String authorUrl;

  /// インスタンスのドメイン名
  final String providerName;

  /// インスタンスのベース URL
  final String providerUrl;

  /// 推奨キャッシュ期間（秒）
  final int cacheAge;

  /// 埋め込み用 iframe の HTML コード
  final String html;

  /// iframe の幅（ピクセル）
  final int width;

  /// iframe の高さ（ピクセル）。未指定の場合は `null`
  final int? height;
}
