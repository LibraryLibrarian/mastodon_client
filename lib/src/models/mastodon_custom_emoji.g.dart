// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_custom_emoji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonCustomEmoji _$MastodonCustomEmojiFromJson(Map<String, dynamic> json) =>
    MastodonCustomEmoji(
      shortcode: json['shortcode'] as String,
      url: json['url'] as String,
      staticUrl: json['static_url'] as String,
      visibleInPicker: json['visible_in_picker'] as bool? ?? true,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$MastodonCustomEmojiToJson(
  MastodonCustomEmoji instance,
) => <String, dynamic>{
  'shortcode': instance.shortcode,
  'url': instance.url,
  'static_url': instance.staticUrl,
  'visible_in_picker': instance.visibleInPicker,
  'category': instance.category,
};
