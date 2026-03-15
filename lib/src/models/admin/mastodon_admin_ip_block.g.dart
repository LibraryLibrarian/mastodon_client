// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_ip_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminIpBlock _$MastodonAdminIpBlockFromJson(
  Map<String, dynamic> json,
) => MastodonAdminIpBlock(
  id: json['id'] as String,
  ip: json['ip'] as String,
  severity: $enumDecode(
    _$MastodonAdminIpBlockSeverityEnumMap,
    json['severity'],
    unknownValue: MastodonAdminIpBlockSeverity.signUpBlock,
  ),
  comment: json['comment'] as String? ?? '',
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  expiresAt: const SafeDateTimeConverter().fromJson(
    json['expires_at'] as String?,
  ),
);

const _$MastodonAdminIpBlockSeverityEnumMap = {
  MastodonAdminIpBlockSeverity.signUpRequiresApproval:
      'sign_up_requires_approval',
  MastodonAdminIpBlockSeverity.signUpBlock: 'sign_up_block',
  MastodonAdminIpBlockSeverity.noAccess: 'no_access',
};
