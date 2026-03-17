import 'package:json_annotation/json_annotation.dart';

import 'mastodon_status.dart';

part 'mastodon_status_context.g.dart';

/// 投稿のコンテキスト（祖先と子孫）
///
/// `GET /api/v1/statuses/{id}/context` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusContext {
  const MastodonStatusContext({
    required this.ancestors,
    required this.descendants,
  });

  factory MastodonStatusContext.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusContextFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonStatusContextToJson(this);

  /// 対象投稿より前の投稿（スレッドの先祖）
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> ancestors;

  /// 対象投稿への返信ツリー（子孫）
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> descendants;
}
