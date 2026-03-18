// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_measure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminMeasure _$MastodonAdminMeasureFromJson(
  Map<String, dynamic> json,
) => MastodonAdminMeasure(
  key: json['key'] as String,
  unit: json['unit'] as String?,
  total: json['total'] as String,
  humanValue: json['human_value'] as String?,
  previousTotal: json['previous_total'] as String?,
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => MastodonAdminMeasureData.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonAdminMeasureToJson(
  MastodonAdminMeasure instance,
) => <String, dynamic>{
  'key': instance.key,
  'unit': instance.unit,
  'total': instance.total,
  'human_value': instance.humanValue,
  'previous_total': instance.previousTotal,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

MastodonAdminMeasureData _$MastodonAdminMeasureDataFromJson(
  Map<String, dynamic> json,
) => MastodonAdminMeasureData(
  date: json['date'] as String,
  value: json['value'] as String,
);

Map<String, dynamic> _$MastodonAdminMeasureDataToJson(
  MastodonAdminMeasureData instance,
) => <String, dynamic>{'date': instance.date, 'value': instance.value};
