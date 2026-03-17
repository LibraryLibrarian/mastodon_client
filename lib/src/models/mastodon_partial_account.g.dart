// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_partial_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonPartialAccount _$MastodonPartialAccountFromJson(
  Map<String, dynamic> json,
) => MastodonPartialAccount(
  id: json['id'] as String,
  acct: json['acct'] as String,
  url: json['url'] as String,
  avatar: json['avatar'] as String,
  avatarStatic: json['avatar_static'] as String,
  locked: json['locked'] as bool? ?? false,
  bot: json['bot'] as bool? ?? false,
);

Map<String, dynamic> _$MastodonPartialAccountToJson(
  MastodonPartialAccount instance,
) => <String, dynamic>{
  'id': instance.id,
  'acct': instance.acct,
  'url': instance.url,
  'avatar': instance.avatar,
  'avatar_static': instance.avatarStatic,
  'locked': instance.locked,
  'bot': instance.bot,
};
