import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_terms_of_service.freezed.dart';
part 'mastodon_terms_of_service.g.dart';

/// Terms of service of the instance.
///
/// `GET /api/v1/instance/terms_of_service`
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTermsOfService with _$MastodonTermsOfService {
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
  @override
  final String effectiveDate;

  /// Whether this is the currently effective terms of service.
  @JsonKey(defaultValue: false)
  @override
  final bool effective;

  /// HTML content of the terms of service.
  @JsonKey(defaultValue: '')
  @override
  final String content;

  /// Effective date of a newer terms of service, if one exists.
  @override
  final String? succeededBy;
}
