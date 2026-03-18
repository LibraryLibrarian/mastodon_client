// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonRelationshipSeveranceEvent _$MastodonRelationshipSeveranceEventFromJson(
  Map<String, dynamic> json,
) => MastodonRelationshipSeveranceEvent(
  id: json['id'] as String,
  type: json['type'] as String,
  purged: json['purged'] as bool? ?? false,
  targetName: json['target_name'] as String,
  followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
  followingCount: (json['following_count'] as num?)?.toInt() ?? 0,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
);

Map<String, dynamic> _$MastodonRelationshipSeveranceEventToJson(
  MastodonRelationshipSeveranceEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'purged': instance.purged,
  'target_name': instance.targetName,
  'followers_count': instance.followersCount,
  'following_count': instance.followingCount,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
};

MastodonAccountWarning _$MastodonAccountWarningFromJson(
  Map<String, dynamic> json,
) => MastodonAccountWarning(
  id: json['id'] as String,
  action: json['action'] as String,
  text: json['text'] as String? ?? '',
  appeal: MastodonAccountWarning._readAppeal(json, 'appeal') as bool? ?? false,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
);

Map<String, dynamic> _$MastodonAccountWarningToJson(
  MastodonAccountWarning instance,
) => <String, dynamic>{
  'id': instance.id,
  'action': instance.action,
  'text': instance.text,
  'appeal': instance.appeal,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
};

MastodonNotification _$MastodonNotificationFromJson(
  Map<String, dynamic> json,
) => MastodonNotification(
  id: json['id'] as String,
  type: $enumDecode(
    _$MastodonNotificationTypeEnumMap,
    MastodonNotification._readType(json, 'type'),
    unknownValue: MastodonNotificationType.unknown,
  ),
  createdAt: DateTime.parse(json['created_at'] as String),
  account: MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
  status: json['status'] == null
      ? null
      : MastodonStatus.fromJson(json['status'] as Map<String, dynamic>),
  relationshipSeveranceEvent: json['relationship_severance_event'] == null
      ? null
      : MastodonRelationshipSeveranceEvent.fromJson(
          json['relationship_severance_event'] as Map<String, dynamic>,
        ),
  moderationWarning: json['moderation_warning'] == null
      ? null
      : MastodonAccountWarning.fromJson(
          json['moderation_warning'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MastodonNotificationToJson(
  MastodonNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$MastodonNotificationTypeEnumMap[instance.type]!,
  'created_at': instance.createdAt.toIso8601String(),
  'account': instance.account.toJson(),
  'status': instance.status?.toJson(),
  'relationship_severance_event': instance.relationshipSeveranceEvent?.toJson(),
  'moderation_warning': instance.moderationWarning?.toJson(),
};

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
