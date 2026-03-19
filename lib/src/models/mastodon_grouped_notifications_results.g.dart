// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_grouped_notifications_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonGroupedNotificationsResults
_$MastodonGroupedNotificationsResultsFromJson(Map<String, dynamic> json) =>
    MastodonGroupedNotificationsResults(
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      partialAccounts:
          (json['partial_accounts'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MastodonPartialAccount.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      statuses:
          (json['statuses'] as List<dynamic>?)
              ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      notificationGroups:
          (json['notification_groups'] as List<dynamic>?)
              ?.map(
                (e) => MastodonNotificationGroup.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$MastodonGroupedNotificationsResultsToJson(
  MastodonGroupedNotificationsResults instance,
) => <String, dynamic>{
  'accounts': instance.accounts,
  'partial_accounts': instance.partialAccounts,
  'statuses': instance.statuses,
  'notification_groups': instance.notificationGroups,
};
