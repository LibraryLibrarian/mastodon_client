// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_terms_of_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonTermsOfService _$MastodonTermsOfServiceFromJson(
  Map<String, dynamic> json,
) => MastodonTermsOfService(
  effectiveDate: json['effective_date'] as String,
  effective: json['effective'] as bool? ?? false,
  content: json['content'] as String? ?? '',
  succeededBy: json['succeeded_by'] as String?,
);

Map<String, dynamic> _$MastodonTermsOfServiceToJson(
  MastodonTermsOfService instance,
) => <String, dynamic>{
  'effective_date': instance.effectiveDate,
  'effective': instance.effective,
  'content': instance.content,
  'succeeded_by': instance.succeededBy,
};
