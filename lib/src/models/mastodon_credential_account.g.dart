// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_credential_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonCredentialAccount _$MastodonCredentialAccountFromJson(
  Map<String, dynamic> json,
) => MastodonCredentialAccount(
  id: json['id'] as String,
  username: json['username'] as String,
  acct: json['acct'] as String,
  displayName: json['display_name'] as String? ?? '',
  note: json['note'] as String? ?? '',
  url: json['url'] as String? ?? '',
  avatarUrl: json['avatar'] as String? ?? '',
  avatarStaticUrl: json['avatar_static'] as String? ?? '',
  headerUrl: json['header'] as String? ?? '',
  headerStaticUrl: json['header_static'] as String? ?? '',
  locked: json['locked'] as bool? ?? false,
  bot: json['bot'] as bool? ?? false,
  followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
  followingCount: (json['following_count'] as num?)?.toInt() ?? 0,
  statusesCount: (json['statuses_count'] as num?)?.toInt() ?? 0,
  fields:
      (json['fields'] as List<dynamic>?)
          ?.map((e) => MastodonField.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  emojis:
      (json['emojis'] as List<dynamic>?)
          ?.map((e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  uri: json['uri'] as String?,
  discoverable: json['discoverable'] as bool?,
  indexable: json['indexable'] as bool?,
  group: json['group'] as bool?,
  noindex: json['noindex'] as bool?,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  lastStatusAt: const SafeDateTimeConverter().fromJson(
    json['last_status_at'] as String?,
  ),
  moved: json['moved'] == null
      ? null
      : MastodonAccount.fromJson(json['moved'] as Map<String, dynamic>),
  suspended: json['suspended'] as bool?,
  limited: json['limited'] as bool?,
  hideCollections: json['hide_collections'] as bool?,
  avatarBlurhash: json['avatar_blurhash'] as String?,
  headerBlurhash: json['header_blurhash'] as String?,
  avatarDescription: json['avatar_description'] as String?,
  headerDescription: json['header_description'] as String?,
  featureApproval: json['feature_approval'] == null
      ? null
      : MastodonFeatureApproval.fromJson(
          json['feature_approval'] as Map<String, dynamic>,
        ),
  showFeatured: json['show_featured'] as bool?,
  showMedia: json['show_media'] as bool?,
  showMediaReplies: json['show_media_replies'] as bool?,
  roles:
      (json['roles'] as List<dynamic>?)
          ?.map((e) => MastodonRole.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  source: json['source'] == null
      ? null
      : MastodonAccountSource.fromJson(json['source'] as Map<String, dynamic>),
  role: json['role'] == null
      ? null
      : MastodonRole.fromJson(json['role'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MastodonCredentialAccountToJson(
  MastodonCredentialAccount instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'acct': instance.acct,
  'display_name': instance.displayName,
  'note': instance.note,
  'url': instance.url,
  'uri': instance.uri,
  'avatar': instance.avatarUrl,
  'avatar_static': instance.avatarStaticUrl,
  'header': instance.headerUrl,
  'header_static': instance.headerStaticUrl,
  'locked': instance.locked,
  'bot': instance.bot,
  'discoverable': instance.discoverable,
  'indexable': instance.indexable,
  'group': instance.group,
  'noindex': instance.noindex,
  'followers_count': instance.followersCount,
  'following_count': instance.followingCount,
  'statuses_count': instance.statusesCount,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
  'last_status_at': const SafeDateTimeConverter().toJson(instance.lastStatusAt),
  'fields': instance.fields.map((e) => e.toJson()).toList(),
  'emojis': instance.emojis.map((e) => e.toJson()).toList(),
  'moved': instance.moved?.toJson(),
  'suspended': instance.suspended,
  'limited': instance.limited,
  'hide_collections': instance.hideCollections,
  'avatar_blurhash': instance.avatarBlurhash,
  'header_blurhash': instance.headerBlurhash,
  'avatar_description': instance.avatarDescription,
  'header_description': instance.headerDescription,
  'feature_approval': instance.featureApproval?.toJson(),
  'show_featured': instance.showFeatured,
  'show_media': instance.showMedia,
  'show_media_replies': instance.showMediaReplies,
  'roles': instance.roles.map((e) => e.toJson()).toList(),
  'source': instance.source?.toJson(),
  'role': instance.role?.toJson(),
};

MastodonAccountSource _$MastodonAccountSourceFromJson(
  Map<String, dynamic> json,
) => MastodonAccountSource(
  privacy: json['privacy'] as String?,
  sensitive: json['sensitive'] as bool?,
  language: json['language'] as String?,
  note: json['note'] as String?,
  fields:
      (json['fields'] as List<dynamic>?)
          ?.map((e) => MastodonField.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  followRequestsCount: (json['follow_requests_count'] as num?)?.toInt() ?? 0,
  hideCollections: json['hide_collections'] as bool?,
  discoverable: json['discoverable'] as bool?,
  indexable: json['indexable'] as bool?,
  attributionDomains:
      (json['attribution_domains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  quotePolicy: json['quote_policy'] as String?,
);

Map<String, dynamic> _$MastodonAccountSourceToJson(
  MastodonAccountSource instance,
) => <String, dynamic>{
  'privacy': instance.privacy,
  'sensitive': instance.sensitive,
  'language': instance.language,
  'note': instance.note,
  'fields': instance.fields?.map((e) => e.toJson()).toList(),
  'follow_requests_count': instance.followRequestsCount,
  'hide_collections': instance.hideCollections,
  'discoverable': instance.discoverable,
  'indexable': instance.indexable,
  'attribution_domains': instance.attributionDomains,
  'quote_policy': instance.quotePolicy,
};
