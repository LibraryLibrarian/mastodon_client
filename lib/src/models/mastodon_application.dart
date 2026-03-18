import 'package:json_annotation/json_annotation.dart';

part 'mastodon_application.g.dart';

/// OAuth application information model.
///
/// Corresponds to the response from `GET /api/v1/apps/verify_credentials`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonApplication {
  /// Creates a [MastodonApplication] with the given fields.
  const MastodonApplication({
    required this.id,
    required this.name,
    this.website,
    required this.scopes,
    required this.redirectUris,
    @Deprecated('Use redirectUris instead') this.redirectUri,
    @Deprecated('VAPID key used by the Push Streaming API') this.vapidKey,
  });

  /// Creates a [MastodonApplication] from a JSON map.
  factory MastodonApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonApplicationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonApplicationToJson(this);

  /// Database ID of the application.
  final String id;

  /// Name of the application.
  final String name;

  /// Website URL of the application.
  final String? website;

  /// Scopes granted to the application.
  final List<String> scopes;

  /// List of registered redirect URIs.
  final List<String> redirectUris;

  /// Redirect URI (deprecated, for backward compatibility).
  @Deprecated('Use redirectUris instead')
  final String? redirectUri;

  /// VAPID key for the Web Push API (deprecated).
  @Deprecated('VAPID key used by the Push Streaming API')
  final String? vapidKey;
}

/// OAuth application registration response model.
///
/// Corresponds to the response from `POST /api/v1/apps`.
/// Includes client credentials in addition to the [MastodonApplication] fields.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCredentialApplication {
  /// Creates a [MastodonCredentialApplication] with the given fields.
  const MastodonCredentialApplication({
    required this.id,
    required this.name,
    this.website,
    required this.scopes,
    required this.redirectUris,
    @Deprecated('Use redirectUris instead') this.redirectUri,
    required this.clientId,
    required this.clientSecret,
    required this.clientSecretExpiresAt,
  });

  /// Creates a [MastodonCredentialApplication] from a JSON map.
  factory MastodonCredentialApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonCredentialApplicationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCredentialApplicationToJson(this);

  /// Database ID of the application.
  final String id;

  /// Name of the application.
  final String name;

  /// Website URL of the application.
  final String? website;

  /// Scopes granted to the application.
  final List<String> scopes;

  /// List of registered redirect URIs.
  final List<String> redirectUris;

  /// Redirect URI (deprecated, for backward compatibility).
  @Deprecated('Use redirectUris instead')
  final String? redirectUri;

  /// Client ID used for obtaining OAuth tokens.
  final String clientId;

  /// Client secret used for obtaining OAuth tokens.
  final String clientSecret;

  /// Expiration time of the client secret (currently always 0).
  final int clientSecretExpiresAt;
}
