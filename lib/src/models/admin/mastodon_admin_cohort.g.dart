// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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

Map<String, dynamic> _$MastodonAdminCohortToJson(
  MastodonAdminCohort instance,
) => <String, dynamic>{
  'period': const SafeDateTimeConverter().toJson(instance.period),
  'frequency': instance.frequency,
  'data': instance.data,
};

MastodonAdminCohortData _$MastodonAdminCohortDataFromJson(
  Map<String, dynamic> json,
) => MastodonAdminCohortData(
  date: const SafeDateTimeConverter().fromJson(json['date'] as String?),
  rate: (json['rate'] as num).toDouble(),
  value: json['value'] as String,
);

Map<String, dynamic> _$MastodonAdminCohortDataToJson(
  MastodonAdminCohortData instance,
) => <String, dynamic>{
  'date': const SafeDateTimeConverter().toJson(instance.date),
  'rate': instance.rate,
  'value': instance.value,
};
