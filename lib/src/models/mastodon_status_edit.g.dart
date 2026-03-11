// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_status_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonStatusEdit _$MastodonStatusEditFromJson(
  Map<String, dynamic> json,
) => MastodonStatusEdit(
  content: json['content'] as String? ?? '',
  spoilerText: json['spoiler_text'] as String? ?? '',
  sensitive: json['sensitive'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  account: MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
  mediaAttachments:
      (json['media_attachments'] as List<dynamic>?)
          ?.map(
            (e) => MastodonMediaAttachment.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  emojis:
      (json['emojis'] as List<dynamic>?)
          ?.map((e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  poll: json['poll'] == null
      ? null
      : MastodonStatusEditPoll.fromJson(json['poll'] as Map<String, dynamic>),
);

MastodonStatusEditPoll _$MastodonStatusEditPollFromJson(
  Map<String, dynamic> json,
) => MastodonStatusEditPoll(
  options:
      (json['options'] as List<dynamic>?)
          ?.map(
            (e) => MastodonStatusEditPollOption.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
);

MastodonStatusEditPollOption _$MastodonStatusEditPollOptionFromJson(
  Map<String, dynamic> json,
) => MastodonStatusEditPollOption(title: json['title'] as String);
