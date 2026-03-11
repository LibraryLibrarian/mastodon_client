// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_media_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonMediaAttachment _$MastodonMediaAttachmentFromJson(
  Map<String, dynamic> json,
) => MastodonMediaAttachment(
  id: json['id'] as String,
  type: $enumDecode(
    _$MastodonMediaTypeEnumMap,
    MastodonMediaAttachment._readType(json, 'type'),
    unknownValue: MastodonMediaType.unknown,
  ),
  url: json['url'] as String?,
  previewUrl: json['preview_url'] as String?,
  remoteUrl: json['remote_url'] as String?,
  description: json['description'] as String?,
  blurhash: json['blurhash'] as String?,
);

const _$MastodonMediaTypeEnumMap = {
  MastodonMediaType.unknown: 'unknown',
  MastodonMediaType.image: 'image',
  MastodonMediaType.gifv: 'gifv',
  MastodonMediaType.video: 'video',
  MastodonMediaType.audio: 'audio',
};
