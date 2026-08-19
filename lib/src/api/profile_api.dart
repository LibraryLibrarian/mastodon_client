import '../client/mastodon_http_client.dart';
import '../models/mastodon_credential_account.dart';
import '../models/mastodon_profile.dart';

/// API client for profile image management.
class ProfileApi {
  /// Creates a [ProfileApi] instance with the given [MastodonHttpClient].
  const ProfileApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the authenticated account's editable profile.
  ///
  /// `GET /api/v1/profile`
  Future<MastodonProfile> fetch() async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/profile');
    return MastodonProfile.fromJson(data!);
  }

  /// Updates the authenticated account's editable profile.
  ///
  /// `PATCH /api/v1/profile`
  Future<MastodonProfile> update(MastodonProfileUpdateRequest request) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/profile',
      method: 'PATCH',
      data: request.toJson(),
    );
    return MastodonProfile.fromJson(data!);
  }

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
