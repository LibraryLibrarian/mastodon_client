import 'package:json_annotation/json_annotation.dart';

part 'mastodon_list.g.dart';

/// ユーザー定義のリスト
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonList {
  /// 各フィールドを指定して [MastodonList] を生成する
  const MastodonList({
    required this.id,
    required this.title,
    required this.repliesPolicy,
    required this.exclusive,
  });

  /// JSON マップから [MastodonList] を生成する
  factory MastodonList.fromJson(Map<String, dynamic> json) =>
      _$MastodonListFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonListToJson(this);

  /// リストの内部 ID
  final String id;

  /// リストのタイトル
  final String title;

  /// リスト内に表示するリプライのポリシー（`followed`・`list`・`none`）
  @JsonKey(defaultValue: 'list')
  final String repliesPolicy;

  /// リストメンバーの投稿をホームタイムラインから除外するかどうか
  @JsonKey(defaultValue: false)
  final bool exclusive;
}
