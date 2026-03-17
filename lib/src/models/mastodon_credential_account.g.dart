// GENERATED CODE - DO NOT MODIFY BY HAND

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
  discoverable: json['discoverable'] as bool?,
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
  source: json['source'] == null
      ? null
      : MastodonAccountSource.fromJson(json['source'] as Map<String, dynamic>),
  role: json['role'] == null
      ? null
      : MastodonRole.fromJson(json['role'] as Map<String, dynamic>),
);

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
  quotePolicy: json['quote_policy'] as String?,
);

MastodonRole _$MastodonRoleFromJson(Map<String, dynamic> json) => MastodonRole(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  permissions: json['permissions'] as String?,
  color: json['color'] as String? ?? '',
  highlighted: json['highlighted'] as bool?,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);
