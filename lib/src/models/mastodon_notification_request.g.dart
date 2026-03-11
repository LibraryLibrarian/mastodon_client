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
