import 'package:json_annotation/json_annotation.dart';

import 'mastodon_preview_card.dart';

part 'mastodon_trends_link.g.dart';

/// トレンドリンクの利用履歴（日別統計）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTrendsLinkHistory {
  const MastodonTrendsLinkHistory({
    required this.day,
    required this.accounts,
    required this.uses,
  });

  factory MastodonTrendsLinkHistory.fromJson(Map<String, dynamic> json) =>
      _$MastodonTrendsLinkHistoryFromJson(json);

  /// UNIX タイムスタンプ（秒）を文字列で表した日付
  @JsonKey(defaultValue: '0')
  final String day;

  /// この日にリンクを共有したアカウント数（文字列）
  @JsonKey(defaultValue: '0')
  final String accounts;

  /// この日のリンク共有回数（文字列）
  @JsonKey(defaultValue: '0')
  final String uses;
}

/// トレンドリンク
///
/// `GET /api/v1/trends/links` のレスポンスに対応する。
/// [MastodonPreviewCard] の全フィールドに加え、トレンド固有の [history] を持つ。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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
}
