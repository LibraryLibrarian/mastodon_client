// GENERATED CODE - DO NOT MODIFY BY HAND

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
