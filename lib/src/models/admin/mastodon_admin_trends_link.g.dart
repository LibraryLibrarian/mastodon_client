// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_trends_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminTrendsLink _$MastodonAdminTrendsLinkFromJson(
  Map<String, dynamic> json,
) => MastodonAdminTrendsLink(
  id: json['id'] as String,
  url: json['url'] as String,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  type: $enumDecode(
    _$MastodonPreviewCardTypeEnumMap,
    MastodonAdminTrendsLink._readType(json, 'type'),
    unknownValue: MastodonPreviewCardType.link,
  ),
  authorName: json['author_name'] as String? ?? '',
  authorUrl: json['author_url'] as String? ?? '',
  providerName: json['provider_name'] as String? ?? '',
  providerUrl: json['provider_url'] as String? ?? '',
  html: json['html'] as String? ?? '',
  width: (json['width'] as num?)?.toInt() ?? 0,
  height: (json['height'] as num?)?.toInt() ?? 0,
  embedUrl: json['embed_url'] as String? ?? '',
  authors:
      (json['authors'] as List<dynamic>?)
          ?.map(
            (e) =>
                MastodonPreviewCardAuthor.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  history:
      (json['history'] as List<dynamic>?)
          ?.map(
            (e) =>
                MastodonTrendsLinkHistory.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  image: json['image'] as String?,
  blurhash: json['blurhash'] as String?,
  requiresReview: json['requires_review'] as bool?,
);

Map<String, dynamic> _$MastodonAdminTrendsLinkToJson(
  MastodonAdminTrendsLink instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'title': instance.title,
  'description': instance.description,
  'type': _$MastodonPreviewCardTypeEnumMap[instance.type]!,
  'author_name': instance.authorName,
  'author_url': instance.authorUrl,
  'provider_name': instance.providerName,
  'provider_url': instance.providerUrl,
  'html': instance.html,
  'width': instance.width,
  'height': instance.height,
  'image': instance.image,
  'embed_url': instance.embedUrl,
  'blurhash': instance.blurhash,
  'authors': instance.authors.map((e) => e.toJson()).toList(),
  'history': instance.history.map((e) => e.toJson()).toList(),
  'requires_review': instance.requiresReview,
};

const _$MastodonPreviewCardTypeEnumMap = {
  MastodonPreviewCardType.link: 'link',
  MastodonPreviewCardType.photo: 'photo',
  MastodonPreviewCardType.video: 'video',
  MastodonPreviewCardType.rich: 'rich',
};
