import 'package:json_annotation/json_annotation.dart';

part 'mastodon_terms_of_service.g.dart';

/// Terms of service of the instance.
///
/// `GET /api/v1/instance/terms_of_service`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTermsOfService {
  const MastodonTermsOfService({
    required this.effectiveDate,
    required this.effective,
    required this.content,
    this.succeededBy,
  });

  factory MastodonTermsOfService.fromJson(Map<String, dynamic> json) =>
      _$MastodonTermsOfServiceFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTermsOfServiceToJson(this);

  /// Effective date of the terms of service.
  final String effectiveDate;

  /// Whether this is the currently effective terms of service.
  @JsonKey(defaultValue: false)
  final bool effective;

  /// HTML content of the terms of service.
  @JsonKey(defaultValue: '')
  final String content;

  /// Effective date of a newer terms of service, if one exists.
  final String? succeededBy;
}
