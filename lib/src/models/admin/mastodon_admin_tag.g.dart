// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminTag _$MastodonAdminTagFromJson(Map<String, dynamic> json) =>
    MastodonAdminTag(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      url: json['url'] as String? ?? '',
      history:
          (json['history'] as List<dynamic>?)
              ?.map(
                (e) => MastodonTagHistory.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      trendable: json['trendable'] as bool?,
      usable: json['usable'] as bool?,
      requiresReview: json['requires_review'] as bool?,
      listable: json['listable'] as bool?,
    );

Map<String, dynamic> _$MastodonAdminTagToJson(MastodonAdminTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'history': instance.history,
      'trendable': instance.trendable,
      'usable': instance.usable,
      'requires_review': instance.requiresReview,
      'listable': instance.listable,
    };
