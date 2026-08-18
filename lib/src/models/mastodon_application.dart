import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_application.freezed.dart';
part 'mastodon_application.g.dart';

/// OAuth application information model.
///
/// Corresponds to the response from `GET /api/v1/apps/verify_credentials`.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonApplication with _$MastodonApplication {
  /// Creates a [MastodonApplication] with the given fields.
  const MastodonApplication({
    required this.id,
    required this.name,
    this.website,
    required this.scopes,
    required this.redirectUris,
    // ignore: remove_deprecations_in_breaking_versions
    @Deprecated('Use redirectUris instead') this.redirectUri,
    // ignore: remove_deprecations_in_breaking_versions
    @Deprecated('VAPID key used by the Push Streaming API') this.vapidKey,
  });

  /// Creates a [MastodonApplication] from a JSON map.
  factory MastodonApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonApplicationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonApplicationToJson(this);

  /// Database ID of the application.
  @override
  final String id;

  /// Name of the application.
  @override
  final String name;

  /// Website URL of the application.
  @override
  final String? website;

  /// Scopes granted to the application.
  @override
  final List<String> scopes;

  /// List of registered redirect URIs.
  @override
  final List<String> redirectUris;

  /// Redirect URI (deprecated, for backward compatibility).
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Use redirectUris instead')
  @override
  final String? redirectUri;

  /// VAPID key for the Web Push API (deprecated).
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('VAPID key used by the Push Streaming API')
  @override
  final String? vapidKey;
}

/// OAuth application registration response model.
///
/// Corresponds to the response from `POST /api/v1/apps`.
/// Includes client credentials in addition to the [MastodonApplication] fields.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCredentialApplication with _$MastodonCredentialApplication {
  /// Creates a [MastodonCredentialApplication] with the given fields.
  const MastodonCredentialApplication({
    required this.id,
    required this.name,
    this.website,
    required this.scopes,
    required this.redirectUris,
    // ignore: remove_deprecations_in_breaking_versions
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
  @override
  final String id;

  /// Name of the application.
  @override
  final String name;

  /// Website URL of the application.
  @override
  final String? website;

  /// Scopes granted to the application.
  @override
  final List<String> scopes;

  /// List of registered redirect URIs.
  @override
  final List<String> redirectUris;

  /// Redirect URI (deprecated, for backward compatibility).
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Use redirectUris instead')
  @override
  final String? redirectUri;

  /// Client ID used for obtaining OAuth tokens.
  @override
  final String clientId;

  /// Client secret used for obtaining OAuth tokens.
  @override
  final String clientSecret;

  /// Expiration time of the client secret (currently always 0).
  @override
  final int clientSecretExpiresAt;
}
