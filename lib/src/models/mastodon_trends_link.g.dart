// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_trends_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonTrendsLinkHistory _$MastodonTrendsLinkHistoryFromJson(
  Map<String, dynamic> json,
) => MastodonTrendsLinkHistory(
  day: json['day'] as String? ?? '0',
  accounts: json['accounts'] as String? ?? '0',
  uses: json['uses'] as String? ?? '0',
);

Map<String, dynamic> _$MastodonTrendsLinkHistoryToJson(
  MastodonTrendsLinkHistory instance,
) => <String, dynamic>{
  'day': instance.day,
  'accounts': instance.accounts,
  'uses': instance.uses,
};

MastodonTrendsLink _$MastodonTrendsLinkFromJson(
  Map<String, dynamic> json,
) => MastodonTrendsLink(
  url: json['url'] as String,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  type: $enumDecode(
    _$MastodonPreviewCardTypeEnumMap,
    MastodonTrendsLink._readType(json, 'type'),
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
);

Map<String, dynamic> _$MastodonTrendsLinkToJson(MastodonTrendsLink instance) =>
    <String, dynamic>{
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
    };

const _$MastodonPreviewCardTypeEnumMap = {
  MastodonPreviewCardType.link: 'link',
  MastodonPreviewCardType.photo: 'photo',
  MastodonPreviewCardType.video: 'video',
  MastodonPreviewCardType.rich: 'rich',
};
