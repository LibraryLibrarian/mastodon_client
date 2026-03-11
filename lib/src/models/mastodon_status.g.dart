// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonMention _$MastodonMentionFromJson(Map<String, dynamic> json) =>
    MastodonMention(
      id: json['id'] as String,
      username: json['username'] as String,
      acct: json['acct'] as String,
      url: json['url'] as String,
    );

MastodonTag _$MastodonTagFromJson(Map<String, dynamic> json) =>
    MastodonTag(name: json['name'] as String, url: json['url'] as String);

MastodonStatus _$MastodonStatusFromJson(
  Map<String, dynamic> json,
) => MastodonStatus(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  sensitive: json['sensitive'] as bool? ?? false,
  spoilerText: json['spoiler_text'] as String? ?? '',
  visibility: $enumDecode(
    _$MastodonVisibilityEnumMap,
    MastodonStatus._readVisibility(json, 'visibility'),
    unknownValue: MastodonVisibility.public,
  ),
  content: json['content'] as String? ?? '',
  reblogsCount: (json['reblogs_count'] as num?)?.toInt() ?? 0,
  favouritesCount: (json['favourites_count'] as num?)?.toInt() ?? 0,
  repliesCount: (json['replies_count'] as num?)?.toInt() ?? 0,
  account: MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
  mediaAttachments: (json['media_attachments'] as List<dynamic>)
      .map((e) => MastodonMediaAttachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  mentions: (json['mentions'] as List<dynamic>)
      .map((e) => MastodonMention.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>)
      .map((e) => MastodonTag.fromJson(e as Map<String, dynamic>))
      .toList(),
  emojis: (json['emojis'] as List<dynamic>)
      .map((e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>))
      .toList(),
  uri: json['uri'] as String?,
  url: json['url'] as String?,
  inReplyToId: json['in_reply_to_id'] as String?,
  inReplyToAccountId: json['in_reply_to_account_id'] as String?,
  language: json['language'] as String?,
  text: json['text'] as String?,
  editedAt: const SafeDateTimeConverter().fromJson(
    json['edited_at'] as String?,
  ),
  favourited: json['favourited'] as bool?,
  reblogged: json['reblogged'] as bool?,
  bookmarked: json['bookmarked'] as bool?,
  muted: json['muted'] as bool?,
  pinned: json['pinned'] as bool?,
  reblog: json['reblog'] == null
      ? null
      : MastodonStatus.fromJson(json['reblog'] as Map<String, dynamic>),
  poll: json['poll'] == null
      ? null
      : MastodonPoll.fromJson(json['poll'] as Map<String, dynamic>),
  quote: json['quote'] == null
      ? null
      : MastodonStatus.fromJson(json['quote'] as Map<String, dynamic>),
);

const _$MastodonVisibilityEnumMap = {
  MastodonVisibility.public: 'public',
  MastodonVisibility.unlisted: 'unlisted',
  MastodonVisibility.private: 'private',
  MastodonVisibility.direct: 'direct',
};
