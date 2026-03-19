// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonTag _$MastodonTagFromJson(Map<String, dynamic> json) => MastodonTag(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  url: json['url'] as String? ?? '',
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => MastodonTagHistory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  following: json['following'] as bool?,
  featuring: json['featuring'] as bool?,
);

Map<String, dynamic> _$MastodonTagToJson(MastodonTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'history': instance.history,
      'following': instance.following,
      'featuring': instance.featuring,
    };

MastodonTagHistory _$MastodonTagHistoryFromJson(Map<String, dynamic> json) =>
    MastodonTagHistory(
      day: json['day'] as String,
      uses: json['uses'] as String,
      accounts: json['accounts'] as String,
    );

Map<String, dynamic> _$MastodonTagHistoryToJson(MastodonTagHistory instance) =>
    <String, dynamic>{
      'day': instance.day,
      'uses': instance.uses,
      'accounts': instance.accounts,
    };
