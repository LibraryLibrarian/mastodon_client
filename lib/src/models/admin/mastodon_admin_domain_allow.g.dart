// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_admin_domain_allow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminDomainAllow _$MastodonAdminDomainAllowFromJson(
  Map<String, dynamic> json,
) => MastodonAdminDomainAllow(
  id: json['id'] as String,
  domain: json['domain'] as String,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
);

Map<String, dynamic> _$MastodonAdminDomainAllowToJson(
  MastodonAdminDomainAllow instance,
) => <String, dynamic>{
  'id': instance.id,
  'domain': instance.domain,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
};
