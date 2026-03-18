// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonPollOption _$MastodonPollOptionFromJson(Map<String, dynamic> json) =>
    MastodonPollOption(
      title: json['title'] as String,
      votesCount: (json['votes_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MastodonPollOptionToJson(MastodonPollOption instance) =>
    <String, dynamic>{
      'title': instance.title,
      'votes_count': instance.votesCount,
    };

MastodonPoll _$MastodonPollFromJson(Map<String, dynamic> json) => MastodonPoll(
  id: json['id'] as String,
  expired: json['expired'] as bool? ?? false,
  multiple: json['multiple'] as bool? ?? false,
  votesCount: (json['votes_count'] as num?)?.toInt() ?? 0,
  options: (json['options'] as List<dynamic>)
      .map((e) => MastodonPollOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  emojis:
      (json['emojis'] as List<dynamic>?)
          ?.map((e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  expiresAt: const SafeDateTimeConverter().fromJson(
    json['expires_at'] as String?,
  ),
  votersCount: (json['voters_count'] as num?)?.toInt(),
  voted: json['voted'] as bool?,
  ownVotes: (json['own_votes'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$MastodonPollToJson(MastodonPoll instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expires_at': const SafeDateTimeConverter().toJson(instance.expiresAt),
      'expired': instance.expired,
      'multiple': instance.multiple,
      'votes_count': instance.votesCount,
      'voters_count': instance.votersCount,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'emojis': instance.emojis.map((e) => e.toJson()).toList(),
      'voted': instance.voted,
      'own_votes': instance.ownVotes,
    };
