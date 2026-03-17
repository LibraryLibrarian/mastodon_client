// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_privacy_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonPrivacyPolicy _$MastodonPrivacyPolicyFromJson(
  Map<String, dynamic> json,
) => MastodonPrivacyPolicy(
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
  content: json['content'] as String? ?? '',
);

Map<String, dynamic> _$MastodonPrivacyPolicyToJson(
  MastodonPrivacyPolicy instance,
) => <String, dynamic>{
  'updated_at': const SafeDateTimeConverter().toJson(instance.updatedAt),
  'content': instance.content,
};
