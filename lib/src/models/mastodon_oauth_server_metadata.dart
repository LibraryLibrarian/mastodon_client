import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_oauth_server_metadata.freezed.dart';
part 'mastodon_oauth_server_metadata.g.dart';

/// OAuth authorization server metadata model.
///
/// Corresponds to the response from `GET /.well-known/oauth-authorization-server`.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOAuthServerMetadata with _$MastodonOAuthServerMetadata {
  /// Creates a [MastodonOAuthServerMetadata] with the given fields.
  const MastodonOAuthServerMetadata({
    required this.issuer,
    required this.serviceDocumentation,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.appRegistrationEndpoint,
    required this.revocationEndpoint,
    this.userinfoEndpoint,
    required this.scopesSupported,
    required this.responseTypesSupported,
    required this.responseModesSupported,
    this.codeChallengeMethodsSupported,
    required this.grantTypesSupported,
    required this.tokenEndpointAuthMethodsSupported,
  });

  /// Creates a [MastodonOAuthServerMetadata] from a JSON map.
  factory MastodonOAuthServerMetadata.fromJson(Map<String, dynamic> json) =>
      _$MastodonOAuthServerMetadataFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonOAuthServerMetadataToJson(this);

  /// Identifier URL of the authorization server.
  @override
  final String issuer;

  /// URL of the service documentation.
  @override
  final String serviceDocumentation;

  /// URL of the authorization endpoint.
  @override
  final String authorizationEndpoint;

  /// URL of the token endpoint.
  @override
  final String tokenEndpoint;

  /// URL of the application registration endpoint.
  @override
  final String appRegistrationEndpoint;

  /// URL of the token revocation endpoint.
  @override
  final String revocationEndpoint;

  /// URL of the userinfo endpoint.
  ///
  /// Added in Mastodon 4.4.0. Will be `null` on 4.3 servers.
  @override
  final String? userinfoEndpoint;

  /// List of supported scopes.
  @override
  final List<String> scopesSupported;

  /// List of supported response types.
  @override
  final List<String> responseTypesSupported;

  /// List of supported response modes.
  @override
  final List<String> responseModesSupported;

  /// List of supported code challenge methods.
  ///
  /// Added after the initial Mastodon 4.3.0 release with PKCE support.
  /// May be `null` on early 4.3.0 servers.
  @override
  final List<String>? codeChallengeMethodsSupported;

  /// List of supported grant types.
  @override
  final List<String> grantTypesSupported;

  /// List of supported token endpoint authentication methods.
  @override
  final List<String> tokenEndpointAuthMethodsSupported;
}
