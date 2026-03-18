import '../client/mastodon_http_client.dart';
import '../models/mastodon_search_result.dart';

/// Search API client.
class SearchApi {
  /// Creates a [SearchApi] instance with the given [MastodonHttpClient].
  const SearchApi(this._http);

  final MastodonHttpClient _http;

  /// Searches across accounts, statuses, and hashtags (v2).
  ///
  /// `GET /api/v2/search`
  ///
  /// [query] is required. [type] limits results to `accounts`, `hashtags`,
  /// or `statuses`; all types are searched when omitted. When [resolve] is
  /// `true`, remote accounts are resolved via WebFinger (requires a user
  /// token; default: `false`). When [following] is `true`, only followed
  /// accounts are returned (default: `false`). [accountId] restricts status
  /// results to a specific account. [excludeUnreviewed] excludes unreviewed
  /// tags when `true` (added in Mastodon 3.0.0). Use [maxId] and [minId]
  /// for pagination. [limit] sets the maximum results per category (max 40,
  /// default: 20). [offset] skips results from the beginning and is only
  /// effective when [type] is specified (requires a user token).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonSearchResult> search(
    String query, {
    String? type,
    bool? resolve,
    bool? following,
    String? accountId,
    bool? excludeUnreviewed,
    String? maxId,
    String? minId,
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/search',
      queryParameters: <String, dynamic>{
        'q': query,
        'type': ?type,
        'resolve': ?resolve,
        'following': ?following,
        'account_id': ?accountId,
        'exclude_unreviewed': ?excludeUnreviewed,
        'max_id': ?maxId,
        'min_id': ?minId,
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return MastodonSearchResult.fromJson(data!);
  }

  /// Searches across accounts, statuses, and hashtags (v1, deprecated).
  ///
  /// `GET /api/v1/search`
  ///
  /// **Deprecated in Mastodon 2.4.1, removed in 3.0.0.**
  /// Provided for compatibility with instances running 2.x or earlier.
  /// Use [search] (v2) for new integrations.
  ///
  /// Key differences from v2: the `hashtags` response field returns plain
  /// strings rather than Tag objects, and the `following` and
  /// `exclude_unreviewed` parameters are not available.
  ///
  /// [query] is required. [type] limits results to `accounts`, `hashtags`,
  /// or `statuses`; all types are searched when omitted. When [resolve] is
  /// `true`, remote accounts are resolved via WebFinger (default: `false`).
  /// [accountId] restricts status results to a specific account. Use
  /// [maxId] and [minId] for pagination. [limit] sets the maximum results
  /// per category (max 40, default: 20). [offset] skips results from the
  /// beginning and is only effective when [type] is specified.
  ///
  /// Throws a `MastodonException` on failure.
  @Deprecated(
    'Removed in Mastodon 3.0.0. Use search() (v2) instead',
  )
  Future<MastodonSearchResultV1> searchV1(
    String query, {
    String? type,
    bool? resolve,
    String? accountId,
    String? maxId,
    String? minId,
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/search',
      queryParameters: <String, dynamic>{
        'q': query,
        'type': ?type,
        'resolve': ?resolve,
        'account_id': ?accountId,
        'max_id': ?maxId,
        'min_id': ?minId,
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return MastodonSearchResultV1.fromJson(data!);
  }
}
