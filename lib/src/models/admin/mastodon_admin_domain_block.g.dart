// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_admin_domain_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminDomainBlock _$MastodonAdminDomainBlockFromJson(
  Map<String, dynamic> json,
) => MastodonAdminDomainBlock(
  id: json['id'] as String,
  domain: json['domain'] as String,
  digest: json['digest'] as String,
  severity: $enumDecode(
    _$MastodonAdminDomainBlockSeverityEnumMap,
    json['severity'],
    unknownValue: MastodonAdminDomainBlockSeverity.silence,
  ),
  rejectMedia: json['reject_media'] as bool? ?? false,
  rejectReports: json['reject_reports'] as bool? ?? false,
  privateComment: json['private_comment'] as String?,
  publicComment: json['public_comment'] as String?,
  obfuscate: json['obfuscate'] as bool? ?? false,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
);

Map<String, dynamic> _$MastodonAdminDomainBlockToJson(
  MastodonAdminDomainBlock instance,
) => <String, dynamic>{
  'id': instance.id,
  'domain': instance.domain,
  'digest': instance.digest,
  'severity': _$MastodonAdminDomainBlockSeverityEnumMap[instance.severity]!,
  'reject_media': instance.rejectMedia,
  'reject_reports': instance.rejectReports,
  'private_comment': instance.privateComment,
  'public_comment': instance.publicComment,
  'obfuscate': instance.obfuscate,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
};

const _$MastodonAdminDomainBlockSeverityEnumMap = {
  MastodonAdminDomainBlockSeverity.silence: 'silence',
  MastodonAdminDomainBlockSeverity.suspend: 'suspend',
  MastodonAdminDomainBlockSeverity.noop: 'noop',
};
