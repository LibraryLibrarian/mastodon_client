// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_web_push_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonPushAlerts _$MastodonPushAlertsFromJson(Map<String, dynamic> json) =>
    MastodonPushAlerts(
      mention: json['mention'] as bool? ?? false,
      quote: json['quote'] as bool? ?? false,
      status: json['status'] as bool? ?? false,
      reblog: json['reblog'] as bool? ?? false,
      follow: json['follow'] as bool? ?? false,
      followRequest: json['follow_request'] as bool? ?? false,
      favourite: json['favourite'] as bool? ?? false,
      poll: json['poll'] as bool? ?? false,
      update: json['update'] as bool? ?? false,
      quotedUpdate: json['quoted_update'] as bool? ?? false,
      adminSignUp: json['admin.sign_up'] as bool? ?? false,
      adminReport: json['admin.report'] as bool? ?? false,
    );

Map<String, dynamic> _$MastodonPushAlertsToJson(MastodonPushAlerts instance) =>
    <String, dynamic>{
      'mention': instance.mention,
      'quote': instance.quote,
      'status': instance.status,
      'reblog': instance.reblog,
      'follow': instance.follow,
      'follow_request': instance.followRequest,
      'favourite': instance.favourite,
      'poll': instance.poll,
      'update': instance.update,
      'quoted_update': instance.quotedUpdate,
      'admin.sign_up': instance.adminSignUp,
      'admin.report': instance.adminReport,
    };

MastodonWebPushSubscription _$MastodonWebPushSubscriptionFromJson(
  Map<String, dynamic> json,
) => MastodonWebPushSubscription(
  id: json['id'] as String,
  endpoint: json['endpoint'] as String,
  serverKey: json['server_key'] as String,
  alerts: MastodonPushAlerts.fromJson(json['alerts'] as Map<String, dynamic>),
  policy: json['policy'] as String,
  standard: json['standard'] as bool?,
);

Map<String, dynamic> _$MastodonWebPushSubscriptionToJson(
  MastodonWebPushSubscription instance,
) => <String, dynamic>{
  'id': instance.id,
  'endpoint': instance.endpoint,
  'server_key': instance.serverKey,
  'alerts': instance.alerts.toJson(),
  'policy': instance.policy,
  'standard': instance.standard,
};
