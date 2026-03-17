// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_email_domain_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminEmailDomainBlock _$MastodonAdminEmailDomainBlockFromJson(
  Map<String, dynamic> json,
) => MastodonAdminEmailDomainBlock(
  id: json['id'] as String,
  domain: json['domain'] as String,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  history:
      (json['history'] as List<dynamic>?)
          ?.map(
            (e) => MastodonAdminEmailDomainBlockHistory.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonAdminEmailDomainBlockToJson(
  MastodonAdminEmailDomainBlock instance,
) => <String, dynamic>{
  'id': instance.id,
  'domain': instance.domain,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
  'history': instance.history,
};

MastodonAdminEmailDomainBlockHistory
_$MastodonAdminEmailDomainBlockHistoryFromJson(Map<String, dynamic> json) =>
    MastodonAdminEmailDomainBlockHistory(
      day: json['day'] as String,
      accounts: json['accounts'] as String,
      uses: json['uses'] as String,
    );

Map<String, dynamic> _$MastodonAdminEmailDomainBlockHistoryToJson(
  MastodonAdminEmailDomainBlockHistory instance,
) => <String, dynamic>{
  'day': instance.day,
  'accounts': instance.accounts,
  'uses': instance.uses,
};
