// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonApplication _$MastodonApplicationFromJson(Map<String, dynamic> json) =>
    MastodonApplication(
      id: json['id'] as String,
      name: json['name'] as String,
      website: json['website'] as String?,
      scopes: (json['scopes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      redirectUris: (json['redirect_uris'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      redirectUri: json['redirect_uri'] as String?,
      vapidKey: json['vapid_key'] as String?,
    );

Map<String, dynamic> _$MastodonApplicationToJson(
  MastodonApplication instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'website': instance.website,
  'scopes': instance.scopes,
  'redirect_uris': instance.redirectUris,
  'redirect_uri': instance.redirectUri,
  'vapid_key': instance.vapidKey,
};

MastodonCredentialApplication _$MastodonCredentialApplicationFromJson(
  Map<String, dynamic> json,
) => MastodonCredentialApplication(
  id: json['id'] as String,
  name: json['name'] as String,
  website: json['website'] as String?,
  scopes: (json['scopes'] as List<dynamic>).map((e) => e as String).toList(),
  redirectUris: (json['redirect_uris'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  redirectUri: json['redirect_uri'] as String?,
  clientId: json['client_id'] as String,
  clientSecret: json['client_secret'] as String,
  clientSecretExpiresAt: (json['client_secret_expires_at'] as num).toInt(),
);

Map<String, dynamic> _$MastodonCredentialApplicationToJson(
  MastodonCredentialApplication instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'website': instance.website,
  'scopes': instance.scopes,
  'redirect_uris': instance.redirectUris,
  'redirect_uri': instance.redirectUri,
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
  'client_secret_expires_at': instance.clientSecretExpiresAt,
};
