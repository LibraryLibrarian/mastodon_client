// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonNotificationRequest _$MastodonNotificationRequestFromJson(
  Map<String, dynamic> json,
) => MastodonNotificationRequest(
  id: json['id'] as String,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
  notificationsCount: parseIntFromString(json['notifications_count']),
  account: MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
  lastStatus: json['last_status'] == null
      ? null
      : MastodonStatus.fromJson(json['last_status'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MastodonNotificationRequestToJson(
  MastodonNotificationRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const SafeDateTimeConverter().toJson(instance.updatedAt),
  'notifications_count': instance.notificationsCount,
  'account': instance.account.toJson(),
  'last_status': instance.lastStatus?.toJson(),
};
