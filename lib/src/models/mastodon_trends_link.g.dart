// GENERATED CODE - DO NOT MODIFY BY HAND

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

const _$MastodonPreviewCardTypeEnumMap = {
  MastodonPreviewCardType.link: 'link',
  MastodonPreviewCardType.photo: 'photo',
  MastodonPreviewCardType.video: 'video',
  MastodonPreviewCardType.rich: 'rich',
};
