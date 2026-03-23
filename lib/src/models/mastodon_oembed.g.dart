// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_oembed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonOEmbed _$MastodonOEmbedFromJson(Map<String, dynamic> json) =>
    MastodonOEmbed(
      type: json['type'] as String,
      version: json['version'] as String,
      title: json['title'] as String?,
      authorName: json['author_name'] as String?,
      authorUrl: json['author_url'] as String?,
      providerName: json['provider_name'] as String?,
      providerUrl: json['provider_url'] as String?,
      cacheAge: (json['cache_age'] as num).toInt(),
      html: json['html'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MastodonOEmbedToJson(MastodonOEmbed instance) =>
    <String, dynamic>{
      'type': instance.type,
      'version': instance.version,
      'title': instance.title,
      'author_name': instance.authorName,
      'author_url': instance.authorUrl,
      'provider_name': instance.providerName,
      'provider_url': instance.providerUrl,
      'cache_age': instance.cacheAge,
      'html': instance.html,
      'width': instance.width,
      'height': instance.height,
    };
