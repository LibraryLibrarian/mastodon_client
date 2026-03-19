// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_extended_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonExtendedDescription _$MastodonExtendedDescriptionFromJson(
  Map<String, dynamic> json,
) => MastodonExtendedDescription(
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
  content: json['content'] as String? ?? '',
);

Map<String, dynamic> _$MastodonExtendedDescriptionToJson(
  MastodonExtendedDescription instance,
) => <String, dynamic>{
  'updated_at': const SafeDateTimeConverter().toJson(instance.updatedAt),
  'content': instance.content,
};
