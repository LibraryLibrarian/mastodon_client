// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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
