// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_notification_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonNotificationGroup _$MastodonNotificationGroupFromJson(
  Map<String, dynamic> json,
) => MastodonNotificationGroup(
  groupKey: json['group_key'] as String,
  notificationsCount: (json['notifications_count'] as num?)?.toInt() ?? 0,
  type: $enumDecode(
    _$MastodonNotificationTypeEnumMap,
    MastodonNotificationGroup._readType(json, 'type'),
    unknownValue: MastodonNotificationType.unknown,
  ),
  mostRecentNotificationId: json['most_recent_notification_id'] as String,
  pageMinId: json['page_min_id'] as String?,
  pageMaxId: json['page_max_id'] as String?,
  latestPageNotificationAt: const SafeDateTimeConverter().fromJson(
    json['latest_page_notification_at'] as String?,
  ),
  sampleAccountIds:
      (json['sample_account_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  statusId: json['status_id'] as String?,
  report: json['report'] == null
      ? null
      : MastodonReport.fromJson(json['report'] as Map<String, dynamic>),
  event: json['event'] == null
      ? null
      : MastodonRelationshipSeveranceEvent.fromJson(
          json['event'] as Map<String, dynamic>,
        ),
  moderationWarning: json['moderation_warning'] == null
      ? null
      : MastodonAccountWarning.fromJson(
          json['moderation_warning'] as Map<String, dynamic>,
        ),
);

const _$MastodonNotificationTypeEnumMap = {
  MastodonNotificationType.mention: 'mention',
  MastodonNotificationType.status: 'status',
  MastodonNotificationType.reblog: 'reblog',
  MastodonNotificationType.follow: 'follow',
  MastodonNotificationType.followRequest: 'follow_request',
  MastodonNotificationType.favourite: 'favourite',
  MastodonNotificationType.poll: 'poll',
  MastodonNotificationType.update: 'update',
  MastodonNotificationType.adminSignUp: 'admin.sign_up',
  MastodonNotificationType.adminReport: 'admin.report',
  MastodonNotificationType.severedRelationships: 'severed_relationships',
  MastodonNotificationType.moderationWarning: 'moderation_warning',
  MastodonNotificationType.quote: 'quote',
  MastodonNotificationType.quotedUpdate: 'quoted_update',
  MastodonNotificationType.unknown: 'unknown',
};
