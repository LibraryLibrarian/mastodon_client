import '../client/mastodon_http_client.dart';
import '../models/mastodon_credential_account.dart';

/// API client for profile image management.
class ProfileApi {
  /// Creates a [ProfileApi] instance with the given [MastodonHttpClient].
  const ProfileApi(this._http);

  final MastodonHttpClient _http;

  /// Deletes the profile avatar image.
  ///
  /// `DELETE /api/v1/profile/avatar`
  ///
  /// Succeeds even if no avatar is set.
  /// Requires authentication (`write:accounts` scope).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonCredentialAccount> deleteAvatar() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/profile/avatar',
      method: 'DELETE',
    );
    return MastodonCredentialAccount.fromJson(data!);
  }

  /// Deletes the profile header image.
  ///
  /// `DELETE /api/v1/profile/header`
  ///
  /// Succeeds even if no header is set.
  /// Requires authentication (`write:accounts` scope).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonCredentialAccount> deleteHeader() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/profile/header',
      method: 'DELETE',
    );
    return MastodonCredentialAccount.fromJson(data!);
  }
}
