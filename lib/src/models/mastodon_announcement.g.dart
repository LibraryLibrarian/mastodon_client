// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAnnouncementReaction _$MastodonAnnouncementReactionFromJson(
  Map<String, dynamic> json,
) => MastodonAnnouncementReaction(
  name: json['name'] as String,
  count: (json['count'] as num?)?.toInt() ?? 0,
  me: json['me'] as bool? ?? false,
  url: json['url'] as String?,
  staticUrl: json['static_url'] as String?,
);

MastodonAnnouncement _$MastodonAnnouncementFromJson(
  Map<String, dynamic> json,
) => MastodonAnnouncement(
  id: json['id'] as String,
  content: json['content'] as String? ?? '',
  allDay: json['all_day'] as bool? ?? false,
  read: json['read'] as bool? ?? false,
  emojis:
      (json['emojis'] as List<dynamic>?)
          ?.map((e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  reactions:
      (json['reactions'] as List<dynamic>?)
          ?.map(
            (e) => MastodonAnnouncementReaction.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => MastodonTag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  mentions:
      (json['mentions'] as List<dynamic>?)
          ?.map((e) => MastodonMention.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map(
            (e) =>
                MastodonAnnouncementStatus.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  startsAt: const SafeDateTimeConverter().fromJson(
    json['starts_at'] as String?,
  ),
  endsAt: const SafeDateTimeConverter().fromJson(json['ends_at'] as String?),
  publishedAt: const SafeDateTimeConverter().fromJson(
    json['published_at'] as String?,
  ),
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

MastodonAnnouncementStatus _$MastodonAnnouncementStatusFromJson(
  Map<String, dynamic> json,
) => MastodonAnnouncementStatus(
  id: json['id'] as String,
  url: json['url'] as String? ?? '',
);
