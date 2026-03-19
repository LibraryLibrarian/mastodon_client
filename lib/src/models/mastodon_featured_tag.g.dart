// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_featured_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonFeaturedTag _$MastodonFeaturedTagFromJson(Map<String, dynamic> json) =>
    MastodonFeaturedTag(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String? ?? '',
      statusesCount: parseIntFromString(json['statuses_count']),
      lastStatusAt: const SafeDateTimeConverter().fromJson(
        json['last_status_at'] as String?,
      ),
    );

Map<String, dynamic> _$MastodonFeaturedTagToJson(
  MastodonFeaturedTag instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'statuses_count': instance.statusesCount,
  'last_status_at': const SafeDateTimeConverter().toJson(instance.lastStatusAt),
};
