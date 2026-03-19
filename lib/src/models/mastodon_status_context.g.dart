// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_status_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonStatusContext _$MastodonStatusContextFromJson(
  Map<String, dynamic> json,
) => MastodonStatusContext(
  ancestors:
      (json['ancestors'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  descendants:
      (json['descendants'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonStatusContextToJson(
  MastodonStatusContext instance,
) => <String, dynamic>{
  'ancestors': instance.ancestors.map((e) => e.toJson()).toList(),
  'descendants': instance.descendants.map((e) => e.toJson()).toList(),
};
