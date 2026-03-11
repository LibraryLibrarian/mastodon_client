import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_privacy_policy.g.dart';

/// インスタンスのプライバシーポリシー
///
/// `GET /api/v1/instance/privacy_policy`
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonPrivacyPolicy {
  const MastodonPrivacyPolicy({
    this.updatedAt,
    required this.content,
  });

  factory MastodonPrivacyPolicy.fromJson(Map<String, dynamic> json) =>
      _$MastodonPrivacyPolicyFromJson(json);

  /// プライバシーポリシーの最終更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// プライバシーポリシーの HTML コンテンツ
  @JsonKey(defaultValue: '')
  final String content;
}
