// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_oembed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonOEmbed _$MastodonOEmbedFromJson(Map<String, dynamic> json) =>
    MastodonOEmbed(
      type: json['type'] as String,
      version: json['version'] as String,
      title: json['title'] as String,
      authorName: json['author_name'] as String,
      authorUrl: json['author_url'] as String,
      providerName: json['provider_name'] as String,
      providerUrl: json['provider_url'] as String,
      cacheAge: (json['cache_age'] as num).toInt(),
      html: json['html'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num?)?.toInt(),
    );
