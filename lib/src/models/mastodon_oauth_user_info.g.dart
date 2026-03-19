// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_oauth_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonOAuthUserInfo _$MastodonOAuthUserInfoFromJson(
  Map<String, dynamic> json,
) => MastodonOAuthUserInfo(
  iss: json['iss'] as String,
  sub: json['sub'] as String,
  name: json['name'] as String,
  preferredUsername: json['preferred_username'] as String,
  profile: json['profile'] as String,
  picture: json['picture'] as String,
);

Map<String, dynamic> _$MastodonOAuthUserInfoToJson(
  MastodonOAuthUserInfo instance,
) => <String, dynamic>{
  'iss': instance.iss,
  'sub': instance.sub,
  'name': instance.name,
  'preferred_username': instance.preferredUsername,
  'profile': instance.profile,
  'picture': instance.picture,
};
