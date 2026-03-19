// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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

Map<String, dynamic> _$MastodonAdminIpBlockToJson(
  MastodonAdminIpBlock instance,
) => <String, dynamic>{
  'id': instance.id,
  'ip': instance.ip,
  'severity': _$MastodonAdminIpBlockSeverityEnumMap[instance.severity]!,
  'comment': instance.comment,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
  'expires_at': const SafeDateTimeConverter().toJson(instance.expiresAt),
};

const _$MastodonAdminIpBlockSeverityEnumMap = {
  MastodonAdminIpBlockSeverity.signUpRequiresApproval:
      'sign_up_requires_approval',
  MastodonAdminIpBlockSeverity.signUpBlock: 'sign_up_block',
  MastodonAdminIpBlockSeverity.noAccess: 'no_access',
};
