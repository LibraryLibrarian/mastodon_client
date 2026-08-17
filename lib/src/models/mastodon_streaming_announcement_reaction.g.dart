// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_streaming_announcement_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonStreamingAnnouncementReaction
_$MastodonStreamingAnnouncementReactionFromJson(Map<String, dynamic> json) =>
    MastodonStreamingAnnouncementReaction(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
      announcementId: json['announcement_id'] as String,
    );

Map<String, dynamic> _$MastodonStreamingAnnouncementReactionToJson(
  MastodonStreamingAnnouncementReaction instance,
) => <String, dynamic>{
  'name': instance.name,
  'count': instance.count,
  'announcement_id': instance.announcementId,
};
