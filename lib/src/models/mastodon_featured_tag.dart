import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_featured_tag.g.dart';

/// アカウントのプロフィールで紹介されているハッシュタグ
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFeaturedTag {
  /// 各フィールドを指定して [MastodonFeaturedTag] を生成する
  const MastodonFeaturedTag({
    required this.id,
    required this.name,
    required this.url,
    required this.statusesCount,
    this.lastStatusAt,
  });

  /// JSON マップから [MastodonFeaturedTag] を生成する
  factory MastodonFeaturedTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonFeaturedTagFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonFeaturedTagToJson(this);

  /// 紹介タグの内部 ID
  final String id;

  /// 紹介されているハッシュタグの名前
  final String name;

  /// このハッシュタグを含む投稿一覧への URL
  @JsonKey(defaultValue: '')
  final String url;

  /// このハッシュタグを含む投稿の件数
  @JsonKey(fromJson: parseIntFromString)
  final int statusesCount;

  /// このハッシュタグを含む最新投稿の日付
  @SafeDateTimeConverter()
  final DateTime? lastStatusAt;
}
