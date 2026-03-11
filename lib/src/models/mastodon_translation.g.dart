// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonTranslation _$MastodonTranslationFromJson(Map<String, dynamic> json) =>
    MastodonTranslation(
      content: json['content'] as String? ?? '',
      spoilerText: json['spoiler_text'] as String? ?? '',
      language: json['language'] as String? ?? '',
      detectedSourceLanguage: json['detected_source_language'] as String? ?? '',
      provider: json['provider'] as String? ?? '',
      mediaAttachments:
          (json['media_attachments'] as List<dynamic>?)
              ?.map(
                (e) => MastodonTranslationAttachment.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      poll: json['poll'] == null
          ? null
          : MastodonTranslationPoll.fromJson(
              json['poll'] as Map<String, dynamic>,
            ),
    );

MastodonTranslationAttachment _$MastodonTranslationAttachmentFromJson(
  Map<String, dynamic> json,
) => MastodonTranslationAttachment(
  id: json['id'] as String,
  description: json['description'] as String? ?? '',
);

MastodonTranslationPoll _$MastodonTranslationPollFromJson(
  Map<String, dynamic> json,
) => MastodonTranslationPoll(
  id: json['id'] as String,
  options:
      (json['options'] as List<dynamic>?)
          ?.map(
            (e) => MastodonTranslationPollOption.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
);

MastodonTranslationPollOption _$MastodonTranslationPollOptionFromJson(
  Map<String, dynamic> json,
) => MastodonTranslationPollOption(title: json['title'] as String);
