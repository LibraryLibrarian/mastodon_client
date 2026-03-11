// GENERATED CODE - DO NOT MODIFY BY HAND

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
