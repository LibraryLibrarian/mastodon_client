// GENERATED CODE - DO NOT MODIFY BY HAND

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

MastodonWebPushSubscription _$MastodonWebPushSubscriptionFromJson(
  Map<String, dynamic> json,
) => MastodonWebPushSubscription(
  id: json['id'] as String,
  endpoint: json['endpoint'] as String,
  serverKey: json['server_key'] as String,
  alerts: MastodonPushAlerts.fromJson(json['alerts'] as Map<String, dynamic>),
  policy: json['policy'] as String,
);
