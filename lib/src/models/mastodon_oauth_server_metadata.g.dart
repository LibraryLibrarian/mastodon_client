// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_oauth_server_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonOAuthServerMetadata _$MastodonOAuthServerMetadataFromJson(
  Map<String, dynamic> json,
) => MastodonOAuthServerMetadata(
  issuer: json['issuer'] as String,
  serviceDocumentation: json['service_documentation'] as String,
  authorizationEndpoint: json['authorization_endpoint'] as String,
  tokenEndpoint: json['token_endpoint'] as String,
  appRegistrationEndpoint: json['app_registration_endpoint'] as String,
  revocationEndpoint: json['revocation_endpoint'] as String,
  userinfoEndpoint: json['userinfo_endpoint'] as String?,
  scopesSupported: (json['scopes_supported'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  responseTypesSupported: (json['response_types_supported'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  responseModesSupported: (json['response_modes_supported'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  codeChallengeMethodsSupported:
      (json['code_challenge_methods_supported'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  grantTypesSupported: (json['grant_types_supported'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tokenEndpointAuthMethodsSupported:
      (json['token_endpoint_auth_methods_supported'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
);
