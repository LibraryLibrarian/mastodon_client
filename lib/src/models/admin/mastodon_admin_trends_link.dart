import 'package:json_annotation/json_annotation.dart';

import '../mastodon_preview_card.dart';
import '../mastodon_trends_link.dart';

part 'mastodon_admin_trends_link.g.dart';

/// 管理者向けトレンドリンク
///
/// 通常の [MastodonTrendsLink] のフィールドに加え、
/// 管理者向けの [id] と [requiresReview] を持つ。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'link';

  /// トレンドリンクのデータベース ID
  final String id;

  /// リンク先のURL
  final String url;

  /// リンク先のタイトル
  @JsonKey(defaultValue: '')
  final String title;

  /// プレビューの説明文
  @JsonKey(defaultValue: '')
  final String description;

  /// プレビューカードの種別
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonPreviewCardType.link,
  )
  final MastodonPreviewCardType type;

  /// コンテンツ作成者の名前
  @JsonKey(defaultValue: '')
  final String authorName;

  /// コンテンツ作成者のURL
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

  /// プレビューサムネイルのURL
  final String? image;

  /// 写真埋め込み用のURL
  @JsonKey(defaultValue: '')
  final String embedUrl;

  /// サムネイル用のBlurhash文字列
  final String? blurhash;

  /// コンテンツ作成者のリスト（Mastodon 4.3.0+）
  @JsonKey(defaultValue: <MastodonPreviewCardAuthor>[])
  final List<MastodonPreviewCardAuthor> authors;

  /// 日別利用統計の履歴
  @JsonKey(defaultValue: <MastodonTrendsLinkHistory>[])
  final List<MastodonTrendsLinkHistory> history;

  /// モデレーターによるレビューが必要かどうか
  final bool? requiresReview;
}
