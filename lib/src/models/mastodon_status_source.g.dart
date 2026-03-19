// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_status_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonStatusSource _$MastodonStatusSourceFromJson(
  Map<String, dynamic> json,
) => MastodonStatusSource(
  id: json['id'] as String,
  text: json['text'] as String,
  spoilerText: json['spoiler_text'] as String? ?? '',
);

Map<String, dynamic> _$MastodonStatusSourceToJson(
  MastodonStatusSource instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'spoiler_text': instance.spoilerText,
};
