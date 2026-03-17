import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_extended_description.g.dart';

/// インスタンスの詳細な説明文
///
/// `GET /api/v1/instance/extended_description`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonExtendedDescription {
  const MastodonExtendedDescription({
    this.updatedAt,
    required this.content,
  });

  factory MastodonExtendedDescription.fromJson(Map<String, dynamic> json) =>
      _$MastodonExtendedDescriptionFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonExtendedDescriptionToJson(this);

  /// 詳細説明の最終更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// 詳細説明の HTML コンテンツ
  @JsonKey(defaultValue: '')
  final String content;
}
