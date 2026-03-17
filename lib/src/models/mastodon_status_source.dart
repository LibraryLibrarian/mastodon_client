import 'package:json_annotation/json_annotation.dart';

part 'mastodon_status_source.g.dart';

/// 投稿のソース情報
///
/// `GET /api/v1/statuses/:id/source`
///
/// 編集画面で使用するプレーンテキストの投稿内容を保持
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusSource {
  const MastodonStatusSource({
    required this.id,
    required this.text,
    required this.spoilerText,
  });

  factory MastodonStatusSource.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusSourceFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonStatusSourceToJson(this);

  /// 投稿の内部ID
  final String id;

  /// 投稿本文のプレーンテキスト
  final String text;

  /// コンテンツ警告（CW）のプレーンテキスト
  @JsonKey(defaultValue: '')
  final String spoilerText;
}
