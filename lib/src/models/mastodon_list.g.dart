// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonList _$MastodonListFromJson(Map<String, dynamic> json) => MastodonList(
  id: json['id'] as String,
  title: json['title'] as String,
  repliesPolicy: json['replies_policy'] as String? ?? 'list',
  exclusive: json['exclusive'] as bool? ?? false,
);

Map<String, dynamic> _$MastodonListToJson(MastodonList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'replies_policy': instance.repliesPolicy,
      'exclusive': instance.exclusive,
    };
