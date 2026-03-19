// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_scheduled_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonScheduledStatus _$MastodonScheduledStatusFromJson(
  Map<String, dynamic> json,
) => MastodonScheduledStatus(
  id: json['id'] as String,
  scheduledAt: const SafeDateTimeConverter().fromJson(
    json['scheduled_at'] as String?,
  ),
  params: json['params'] == null
      ? null
      : MastodonScheduledStatusParams.fromJson(
          json['params'] as Map<String, dynamic>,
        ),
  mediaAttachments:
      (json['media_attachments'] as List<dynamic>?)
          ?.map(
            (e) => MastodonMediaAttachment.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonScheduledStatusToJson(
  MastodonScheduledStatus instance,
) => <String, dynamic>{
  'id': instance.id,
  'scheduled_at': const SafeDateTimeConverter().toJson(instance.scheduledAt),
  'params': instance.params,
  'media_attachments': instance.mediaAttachments,
};

MastodonScheduledStatusParams _$MastodonScheduledStatusParamsFromJson(
  Map<String, dynamic> json,
) => MastodonScheduledStatusParams(
  text: json['text'] as String? ?? '',
  poll: json['poll'] == null
      ? null
      : MastodonScheduledStatusPoll.fromJson(
          json['poll'] as Map<String, dynamic>,
        ),
  mediaIds: (json['media_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sensitive: json['sensitive'] as bool?,
  spoilerText: json['spoiler_text'] as String?,
  visibility: json['visibility'] as String?,
  inReplyToId: flexibleIdFromJson(json['in_reply_to_id']),
  language: json['language'] as String?,
  idempotency: json['idempotency'] as String?,
);

Map<String, dynamic> _$MastodonScheduledStatusParamsToJson(
  MastodonScheduledStatusParams instance,
) => <String, dynamic>{
  'text': instance.text,
  'poll': instance.poll,
  'media_ids': instance.mediaIds,
  'sensitive': instance.sensitive,
  'spoiler_text': instance.spoilerText,
  'visibility': instance.visibility,
  'in_reply_to_id': instance.inReplyToId,
  'language': instance.language,
  'idempotency': instance.idempotency,
};

MastodonScheduledStatusPoll _$MastodonScheduledStatusPollFromJson(
  Map<String, dynamic> json,
) => MastodonScheduledStatusPoll(
  options:
      (json['options'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  expiresIn: (json['expires_in'] as num).toInt(),
  multiple: json['multiple'] as bool?,
  hideTotals: json['hide_totals'] as bool?,
);

Map<String, dynamic> _$MastodonScheduledStatusPollToJson(
  MastodonScheduledStatusPoll instance,
) => <String, dynamic>{
  'options': instance.options,
  'expires_in': instance.expiresIn,
  'multiple': instance.multiple,
  'hide_totals': instance.hideTotals,
};
