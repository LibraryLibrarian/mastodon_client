// GENERATED CODE - DO NOT MODIFY BY HAND

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
