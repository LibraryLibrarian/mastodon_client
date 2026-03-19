import '../client/mastodon_http_client.dart';
import '../models/mastodon_preferences.dart';
import 'accounts_api.dart' show AccountsApi;

/// API for retrieving user preferences.
///
/// Use [AccountsApi.updateCredentials] to change preferences.
class PreferencesApi {
  /// Creates a [PreferencesApi] instance with the given [MastodonHttpClient].
  const PreferencesApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the user's account preferences.
  ///
  /// `GET /api/v1/preferences`
  ///
  /// Includes default posting visibility, language, content warning settings,
  /// media expansion settings, and CW expansion settings.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPreferences> fetch() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/preferences',
    );
    return MastodonPreferences.fromJson(data!);
  }
}
