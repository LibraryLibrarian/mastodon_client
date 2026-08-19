// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonProfile _$MastodonProfileFromJson(Map<String, dynamic> json) =>
    MastodonProfile(
      id: json['id'] as String,
      displayName: json['display_name'] as String? ?? '',
      note: json['note'] as String? ?? '',
      formattedNote: json['formatted_note'] as String? ?? '',
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => MastodonField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      formattedFields:
          (json['formatted_fields'] as List<dynamic>?)
              ?.map((e) => MastodonField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      locked: json['locked'] as bool? ?? false,
      bot: json['bot'] as bool? ?? false,
      hideCollections: json['hide_collections'] as bool? ?? false,
      discoverable: json['discoverable'] as bool? ?? false,
      indexable: json['indexable'] as bool? ?? false,
      showMedia: json['show_media'] as bool? ?? true,
      showMediaReplies: json['show_media_replies'] as bool? ?? true,
      showFeatured: json['show_featured'] as bool? ?? true,
      avatar: json['avatar'] as String?,
      avatarStatic: json['avatar_static'] as String?,
      avatarDescription: json['avatar_description'] as String?,
      header: json['header'] as String?,
      headerStatic: json['header_static'] as String?,
      headerDescription: json['header_description'] as String?,
      attributionDomains:
          (json['attribution_domains'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      featuredTags:
          (json['featured_tags'] as List<dynamic>?)
              ?.map(
                (e) => MastodonFeaturedTag.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$MastodonProfileToJson(
  MastodonProfile instance,
) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'note': instance.note,
  'formatted_note': instance.formattedNote,
  'fields': instance.fields.map((e) => e.toJson()).toList(),
  'formatted_fields': instance.formattedFields.map((e) => e.toJson()).toList(),
  'avatar': instance.avatar,
  'avatar_static': instance.avatarStatic,
  'avatar_description': instance.avatarDescription,
  'header': instance.header,
  'header_static': instance.headerStatic,
  'header_description': instance.headerDescription,
  'locked': instance.locked,
  'bot': instance.bot,
  'hide_collections': instance.hideCollections,
  'discoverable': instance.discoverable,
  'indexable': instance.indexable,
  'show_media': instance.showMedia,
  'show_media_replies': instance.showMediaReplies,
  'show_featured': instance.showFeatured,
  'attribution_domains': instance.attributionDomains,
  'featured_tags': instance.featuredTags.map((e) => e.toJson()).toList(),
};
