import '../client/mastodon_http_client.dart';
import '../models/mastodon_application.dart';

/// API client for OAuth application registration and verification.
class AppsApi {
  /// Creates an [AppsApi] instance with the given [MastodonHttpClient].
  const AppsApi(this._http);

  final MastodonHttpClient _http;

  /// Registers a new OAuth application.
  ///
  /// `POST /api/v1/apps`
  ///
  /// [clientName] and [redirectUris] are required. For the OOB flow,
  /// pass `['urn:ietf:wg:oauth:2.0:oob']` as [redirectUris]. [scopes] is
  /// a space-separated scope string that defaults to `read` when omitted.
  /// [website] is the optional application website URL.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonCredentialApplication> create({
    required String clientName,
    required List<String> redirectUris,
    String? scopes,
    String? website,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/apps',
      method: 'POST',
      data: <String, dynamic>{
        'client_name': clientName,
        'redirect_uris': redirectUris,
        'scopes': ?scopes,
        'website': ?website,
      },
    );
    return MastodonCredentialApplication.fromJson(data!);
  }

  /// Verifies the current application token credentials.
  ///
  /// `GET /api/v1/apps/verify_credentials`
  ///
  /// Returns the application information. Throws an authentication error if
  /// the token is invalid.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonApplication> verifyCredentials() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/apps/verify_credentials',
    );
    return MastodonApplication.fromJson(data!);
  }
}
