import 'package:json_annotation/json_annotation.dart';

part 'mastodon_terms_of_service.g.dart';

/// インスタンスの利用規約
///
/// `GET /api/v1/instance/terms_of_service`
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTermsOfService {
  const MastodonTermsOfService({
    required this.effectiveDate,
    required this.effective,
    required this.content,
    this.succeededBy,
  });

  factory MastodonTermsOfService.fromJson(Map<String, dynamic> json) =>
      _$MastodonTermsOfServiceFromJson(json);

  /// 利用規約の発効日
  final String effectiveDate;

  /// 現在有効な利用規約かどうか
  @JsonKey(defaultValue: false)
  final bool effective;

  /// 利用規約の HTML コンテンツ
  @JsonKey(defaultValue: '')
  final String content;

  /// より新しい利用規約が存在する場合、その発効日
  final String? succeededBy;
}
