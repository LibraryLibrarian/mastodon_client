// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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

Map<String, dynamic> _$MastodonMentionToJson(MastodonMention instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'acct': instance.acct,
      'url': instance.url,
    };

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
  card: json['card'] == null
      ? null
      : MastodonPreviewCard.fromJson(json['card'] as Map<String, dynamic>),
  application: json['application'] == null
      ? null
      : MastodonStatusApplication.fromJson(
          json['application'] as Map<String, dynamic>,
        ),
  quoteApproval: json['quote_approval'] == null
      ? null
      : MastodonQuoteApproval.fromJson(
          json['quote_approval'] as Map<String, dynamic>,
        ),
  quotesCount: (json['quotes_count'] as num?)?.toInt() ?? 0,
  filtered:
      (json['filtered'] as List<dynamic>?)
          ?.map((e) => MastodonFilterResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  taggedCollections:
      (json['tagged_collections'] as List<dynamic>?)
          ?.map((e) => MastodonCollection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonStatusToJson(MastodonStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      'url': instance.url,
      'created_at': instance.createdAt.toIso8601String(),
      'in_reply_to_id': instance.inReplyToId,
      'in_reply_to_account_id': instance.inReplyToAccountId,
      'sensitive': instance.sensitive,
      'spoiler_text': instance.spoilerText,
      'visibility': _$MastodonVisibilityEnumMap[instance.visibility]!,
      'language': instance.language,
      'content': instance.content,
      'text': instance.text,
      'edited_at': const SafeDateTimeConverter().toJson(instance.editedAt),
      'reblogs_count': instance.reblogsCount,
      'favourites_count': instance.favouritesCount,
      'replies_count': instance.repliesCount,
      'quotes_count': instance.quotesCount,
      'favourited': instance.favourited,
      'reblogged': instance.reblogged,
      'bookmarked': instance.bookmarked,
      'muted': instance.muted,
      'pinned': instance.pinned,
      'account': instance.account.toJson(),
      'media_attachments': instance.mediaAttachments
          .map((e) => e.toJson())
          .toList(),
      'mentions': instance.mentions.map((e) => e.toJson()).toList(),
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'emojis': instance.emojis.map((e) => e.toJson()).toList(),
      'reblog': instance.reblog?.toJson(),
      'poll': instance.poll?.toJson(),
      'quote': instance.quote?.toJson(),
      'card': instance.card?.toJson(),
      'application': instance.application?.toJson(),
      'filtered': instance.filtered.map((e) => e.toJson()).toList(),
      'quote_approval': instance.quoteApproval?.toJson(),
      'tagged_collections': instance.taggedCollections
          .map((e) => e.toJson())
          .toList(),
    };

const _$MastodonVisibilityEnumMap = {
  MastodonVisibility.public: 'public',
  MastodonVisibility.unlisted: 'unlisted',
  MastodonVisibility.private: 'private',
  MastodonVisibility.direct: 'direct',
};

MastodonStatusApplication _$MastodonStatusApplicationFromJson(
  Map<String, dynamic> json,
) => MastodonStatusApplication(
  name: json['name'] as String? ?? '',
  website: json['website'] as String?,
);

Map<String, dynamic> _$MastodonStatusApplicationToJson(
  MastodonStatusApplication instance,
) => <String, dynamic>{'name': instance.name, 'website': instance.website};

MastodonQuoteApproval _$MastodonQuoteApprovalFromJson(
  Map<String, dynamic> json,
) => MastodonQuoteApproval(
  automatic:
      (json['automatic'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  manual:
      (json['manual'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  currentUser: json['current_user'] as String?,
);

Map<String, dynamic> _$MastodonQuoteApprovalToJson(
  MastodonQuoteApproval instance,
) => <String, dynamic>{
  'automatic': instance.automatic,
  'manual': instance.manual,
  'current_user': instance.currentUser,
};
