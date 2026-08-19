// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_oauth_token_introspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonOAuthTokenIntrospection _$MastodonOAuthTokenIntrospectionFromJson(
  Map<String, dynamic> json,
) => MastodonOAuthTokenIntrospection(
  active: json['active'] as bool? ?? false,
  scope: json['scope'] as String?,
  clientId: json['client_id'] as String?,
  tokenType: json['token_type'] as String?,
  issuedAt: (json['iat'] as num?)?.toInt(),
  expiresAt: (json['exp'] as num?)?.toInt(),
);

Map<String, dynamic> _$MastodonOAuthTokenIntrospectionToJson(
  MastodonOAuthTokenIntrospection instance,
) => <String, dynamic>{
  'active': instance.active,
  'scope': instance.scope,
  'client_id': instance.clientId,
  'token_type': instance.tokenType,
  'iat': instance.issuedAt,
  'exp': instance.expiresAt,
};
