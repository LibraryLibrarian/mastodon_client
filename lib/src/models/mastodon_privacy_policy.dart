import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_privacy_policy.g.dart';

/// Privacy policy of the instance.
///
/// `GET /api/v1/instance/privacy_policy`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPrivacyPolicy {
  const MastodonPrivacyPolicy({
    this.updatedAt,
    required this.content,
  });

  factory MastodonPrivacyPolicy.fromJson(Map<String, dynamic> json) =>
      _$MastodonPrivacyPolicyFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPrivacyPolicyToJson(this);

  /// Timestamp when the privacy policy was last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// HTML content of the privacy policy.
  @JsonKey(defaultValue: '')
  final String content;
}
