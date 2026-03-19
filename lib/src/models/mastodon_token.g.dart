// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonToken _$MastodonTokenFromJson(Map<String, dynamic> json) =>
    MastodonToken(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      scope: json['scope'] as String,
      createdAt: (json['created_at'] as num).toInt(),
    );

Map<String, dynamic> _$MastodonTokenToJson(MastodonToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'scope': instance.scope,
      'created_at': instance.createdAt,
    };
