// GENERATED CODE - DO NOT MODIFY BY HAND

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
