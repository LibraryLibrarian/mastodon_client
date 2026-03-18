// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_dimension.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminDimension _$MastodonAdminDimensionFromJson(
  Map<String, dynamic> json,
) => MastodonAdminDimension(
  key: json['key'] as String,
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) =>
                MastodonAdminDimensionData.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonAdminDimensionToJson(
  MastodonAdminDimension instance,
) => <String, dynamic>{
  'key': instance.key,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

MastodonAdminDimensionData _$MastodonAdminDimensionDataFromJson(
  Map<String, dynamic> json,
) => MastodonAdminDimensionData(
  key: json['key'] as String,
  humanKey: json['human_key'] as String,
  value: json['value'] as String,
  unit: json['unit'] as String?,
  humanValue: json['human_value'] as String?,
);

Map<String, dynamic> _$MastodonAdminDimensionDataToJson(
  MastodonAdminDimensionData instance,
) => <String, dynamic>{
  'key': instance.key,
  'human_key': instance.humanKey,
  'value': instance.value,
  'unit': instance.unit,
  'human_value': instance.humanValue,
};
