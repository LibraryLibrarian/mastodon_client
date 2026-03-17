// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_weekly_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonWeeklyActivity _$MastodonWeeklyActivityFromJson(
  Map<String, dynamic> json,
) => MastodonWeeklyActivity(
  week: json['week'] as String? ?? '0',
  statuses: json['statuses'] as String? ?? '0',
  logins: json['logins'] as String? ?? '0',
  registrations: json['registrations'] as String? ?? '0',
);

Map<String, dynamic> _$MastodonWeeklyActivityToJson(
  MastodonWeeklyActivity instance,
) => <String, dynamic>{
  'week': instance.week,
  'statuses': instance.statuses,
  'logins': instance.logins,
  'registrations': instance.registrations,
};
