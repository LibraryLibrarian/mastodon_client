// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_cohort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminCohort _$MastodonAdminCohortFromJson(Map<String, dynamic> json) =>
    MastodonAdminCohort(
      period: const SafeDateTimeConverter().fromJson(json['period'] as String?),
      frequency: json['frequency'] as String,
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MastodonAdminCohortData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

MastodonAdminCohortData _$MastodonAdminCohortDataFromJson(
  Map<String, dynamic> json,
) => MastodonAdminCohortData(
  date: const SafeDateTimeConverter().fromJson(json['date'] as String?),
  rate: (json['rate'] as num).toDouble(),
  value: json['value'] as String,
);
