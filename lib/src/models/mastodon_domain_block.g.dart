// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_domain_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonDomainBlock _$MastodonDomainBlockFromJson(Map<String, dynamic> json) =>
    MastodonDomainBlock(
      domain: json['domain'] as String,
      digest: json['digest'] as String,
      severity: $enumDecode(
        _$MastodonDomainBlockSeverityEnumMap,
        json['severity'],
        unknownValue: MastodonDomainBlockSeverity.unknown,
      ),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$MastodonDomainBlockToJson(
  MastodonDomainBlock instance,
) => <String, dynamic>{
  'domain': instance.domain,
  'digest': instance.digest,
  'severity': _$MastodonDomainBlockSeverityEnumMap[instance.severity]!,
  'comment': instance.comment,
};

const _$MastodonDomainBlockSeverityEnumMap = {
  MastodonDomainBlockSeverity.silence: 'silence',
  MastodonDomainBlockSeverity.suspend: 'suspend',
  MastodonDomainBlockSeverity.unknown: 'unknown',
};
