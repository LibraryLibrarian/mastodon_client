import '../client/mastodon_http_client.dart';
import '../models/mastodon_oauth_server_metadata.dart';
import '../models/mastodon_oauth_user_info.dart';
import '../models/mastodon_token.dart';

/// API client for OAuth token operations.
///
/// The authorization flow involving browser redirects (`GET /oauth/authorize`)
/// is platform-dependent and outside the scope of this library.
/// Use [obtainToken] to obtain an access token after acquiring an
/// authorization code.
class OAuthApi {
  /// Creates an [OAuthApi] instance with the given [MastodonHttpClient].
  const OAuthApi(this._http);

  final MastodonHttpClient _http;

  /// Obtains an access token using an authorization code or client credentials.
  ///
  /// `POST /oauth/token`
  ///
  /// [grantType], [clientId], [clientSecret], and [redirectUri] are required.
  /// [grantType] must be `authorization_code` or `client_credentials`.
  /// For the `authorization_code` grant, [code] is also required. Provide
  /// [codeVerifier] when a PKCE `code_challenge` was used during
  /// authorization. [scope] is only effective for the `client_credentials`
  /// grant type.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonToken> obtainToken({
    required String grantType,
    required String clientId,
    required String clientSecret,
    required String redirectUri,
    String? code,
    String? codeVerifier,
    String? scope,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/oauth/token',
      method: 'POST',
      contentType: 'application/x-www-form-urlencoded',
      data: <String, dynamic>{
        'grant_type': grantType,
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'code': ?code,
        'code_verifier': ?codeVerifier,
        'scope': ?scope,
      },
    );
    return MastodonToken.fromJson(data!);
  }

  /// Revokes an access token.
  ///
  /// `POST /oauth/revoke`
  ///
  /// [clientId], [clientSecret], and [token] are all required.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> revokeToken({
    required String clientId,
    required String clientSecret,
    required String token,
  }) async {
    await _http.send<dynamic>(
      '/oauth/revoke',
      method: 'POST',
      contentType: 'application/x-www-form-urlencoded',
      data: <String, dynamic>{
        'client_id': clientId,
        'client_secret': clientSecret,
        'token': token,
      },
    );
  }

  /// Fetches the OpenID Connect user info of the authenticated user.
  ///
  /// `GET /oauth/userinfo`
  ///
  /// Requires a user token with the `profile` scope.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonOAuthUserInfo> fetchUserInfo() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/oauth/userinfo',
    );
    return MastodonOAuthUserInfo.fromJson(data!);
  }

  /// Fetches the OAuth authorization server metadata.
  ///
  /// `GET /.well-known/oauth-authorization-server`
  ///
  /// No authentication required. Returns information about the endpoints
  /// and scopes supported by the server.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonOAuthServerMetadata> fetchServerMetadata() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/.well-known/oauth-authorization-server',
    );
    return MastodonOAuthServerMetadata.fromJson(data!);
  }
}
