import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_suggestion.dart';

/// API client for follow suggestions.
class SuggestionsApi {
  /// Creates a [SuggestionsApi] instance with the given [MastodonHttpClient].
  const SuggestionsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches a list of follow suggestions.
  ///
  /// `GET /api/v2/suggestions`
  ///
  /// Returns staff-recommended accounts or accounts the user has had
  /// positive interactions with but does not yet follow. [limit] controls
  /// the maximum number of results (default: 40, max: 80).
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonSuggestion>> fetch({int? limit}) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/suggestions',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonSuggestion.fromJson)
        .toList();
  }

  /// Fetches follow suggestions in v1 format.
  ///
  /// `GET /api/v1/suggestions`
  ///
  /// **Deprecated**: Deprecated in Mastodon 3.4.0. Use [fetch] (v2) instead.
  /// Unlike v2, does not include suggestion source information (`source`)
  /// and returns an array of `Account` objects. [limit] controls the
  /// maximum number of results (default: 40, max: 80).
  ///
  /// Throws a `MastodonException` on failure.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 3.4.0. Use fetch() (v2) instead')
  Future<List<MastodonAccount>> fetchV1({int? limit}) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/suggestions',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// Removes an account from follow suggestions.
  ///
  /// `DELETE /api/v1/suggestions/{accountId}`
  ///
  /// Succeeds even if the ID does not exist or is not in the suggestions.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> remove(String accountId) async {
    await _http.send<void>(
      '/api/v1/suggestions/$accountId',
      method: 'DELETE',
    );
  }
}
