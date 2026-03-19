// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAccount _$MastodonAccountFromJson(Map<String, dynamic> json) =>
    MastodonAccount(
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
              ?.map(
                (e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>),
              )
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
    );

Map<String, dynamic> _$MastodonAccountToJson(
  MastodonAccount instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'acct': instance.acct,
  'display_name': instance.displayName,
  'note': instance.note,
  'url': instance.url,
  'avatar': instance.avatarUrl,
  'avatar_static': instance.avatarStaticUrl,
  'header': instance.headerUrl,
  'header_static': instance.headerStaticUrl,
  'locked': instance.locked,
  'bot': instance.bot,
  'discoverable': instance.discoverable,
  'noindex': instance.noindex,
  'followers_count': instance.followersCount,
  'following_count': instance.followingCount,
  'statuses_count': instance.statusesCount,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
  'last_status_at': const SafeDateTimeConverter().toJson(instance.lastStatusAt),
  'fields': instance.fields,
  'emojis': instance.emojis,
  'moved': instance.moved,
  'suspended': instance.suspended,
  'limited': instance.limited,
  'hide_collections': instance.hideCollections,
  'avatar_blurhash': instance.avatarBlurhash,
  'header_blurhash': instance.headerBlurhash,
};

MastodonField _$MastodonFieldFromJson(Map<String, dynamic> json) =>
    MastodonField(
      name: json['name'] as String,
      value: json['value'] as String,
      verifiedAt: const SafeDateTimeConverter().fromJson(
        json['verified_at'] as String?,
      ),
    );

Map<String, dynamic> _$MastodonFieldToJson(MastodonField instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'verified_at': const SafeDateTimeConverter().toJson(instance.verifiedAt),
    };
