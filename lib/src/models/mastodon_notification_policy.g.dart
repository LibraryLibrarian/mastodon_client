// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_notification_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonNotificationPolicySummary _$MastodonNotificationPolicySummaryFromJson(
  Map<String, dynamic> json,
) => MastodonNotificationPolicySummary(
  pendingRequestsCount: (json['pending_requests_count'] as num?)?.toInt() ?? 0,
  pendingNotificationsCount:
      (json['pending_notifications_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MastodonNotificationPolicySummaryToJson(
  MastodonNotificationPolicySummary instance,
) => <String, dynamic>{
  'pending_requests_count': instance.pendingRequestsCount,
  'pending_notifications_count': instance.pendingNotificationsCount,
};

MastodonNotificationPolicy _$MastodonNotificationPolicyFromJson(
  Map<String, dynamic> json,
) => MastodonNotificationPolicy(
  forNotFollowing: $enumDecode(
    _$NotificationFilterActionEnumMap,
    json['for_not_following'],
    unknownValue: NotificationFilterAction.accept,
  ),
  forNotFollowers: $enumDecode(
    _$NotificationFilterActionEnumMap,
    json['for_not_followers'],
    unknownValue: NotificationFilterAction.accept,
  ),
  forNewAccounts: $enumDecode(
    _$NotificationFilterActionEnumMap,
    json['for_new_accounts'],
    unknownValue: NotificationFilterAction.accept,
  ),
  forPrivateMentions: $enumDecode(
    _$NotificationFilterActionEnumMap,
    json['for_private_mentions'],
    unknownValue: NotificationFilterAction.accept,
  ),
  forLimitedAccounts: $enumDecode(
    _$NotificationFilterActionEnumMap,
    json['for_limited_accounts'],
    unknownValue: NotificationFilterAction.accept,
  ),
  summary: json['summary'] == null
      ? null
      : MastodonNotificationPolicySummary.fromJson(
          json['summary'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MastodonNotificationPolicyToJson(
  MastodonNotificationPolicy instance,
) => <String, dynamic>{
  'for_not_following':
      _$NotificationFilterActionEnumMap[instance.forNotFollowing]!,
  'for_not_followers':
      _$NotificationFilterActionEnumMap[instance.forNotFollowers]!,
  'for_new_accounts':
      _$NotificationFilterActionEnumMap[instance.forNewAccounts]!,
  'for_private_mentions':
      _$NotificationFilterActionEnumMap[instance.forPrivateMentions]!,
  'for_limited_accounts':
      _$NotificationFilterActionEnumMap[instance.forLimitedAccounts]!,
  'summary': instance.summary,
};

const _$NotificationFilterActionEnumMap = {
  NotificationFilterAction.accept: 'accept',
  NotificationFilterAction.filter: 'filter',
  NotificationFilterAction.drop: 'drop',
};
