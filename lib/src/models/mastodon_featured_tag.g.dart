// GENERATED CODE - DO NOT MODIFY BY HAND

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
