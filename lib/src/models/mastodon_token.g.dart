// GENERATED CODE - DO NOT MODIFY BY HAND

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
