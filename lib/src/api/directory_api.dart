import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';

/// API client for the profile directory.
class DirectoryApi {
  /// Creates a [DirectoryApi] instance with the given [MastodonHttpClient].
  const DirectoryApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches accounts listed in the profile directory.
  ///
  /// `GET /api/v1/directory`
  ///
  /// No authentication required.
  ///
  /// [limit] controls the number of results returned (default: 40, max: 80),
  /// and [offset] skips that many results from the beginning. [order] sets
  /// the sort order: `active` sorts by most recently posted, `new` by
  /// account creation date. Set [local] to `true` to return only local
  /// accounts.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAccount>> fetch({
    int? offset,
    int? limit,
    String? order,
    bool? local,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/directory',
      queryParameters: <String, dynamic>{
        'offset': ?offset,
        'limit': ?limit,
        'order': ?order,
        'local': ?local,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }
}
