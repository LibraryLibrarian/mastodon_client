// GENERATED CODE - DO NOT MODIFY BY HAND

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

const _$MastodonAdminDomainBlockSeverityEnumMap = {
  MastodonAdminDomainBlockSeverity.silence: 'silence',
  MastodonAdminDomainBlockSeverity.suspend: 'suspend',
  MastodonAdminDomainBlockSeverity.noop: 'noop',
};
