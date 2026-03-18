import '../client/mastodon_http_client.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_trends_link.dart';

/// Trends API client.
///
/// All endpoints are public and require no authentication.
class TrendsApi {
  /// Creates a [TrendsApi] instance with the given [MastodonHttpClient].
  const TrendsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches trending tags.
  ///
  /// `GET /api/v1/trends/tags`
  ///
  /// Returns tags with increasing usage over the past week, sorted by
  /// internal trend score. [limit] controls the maximum number of results
  /// (default: 10, max: 20) and [offset] skips that many for pagination.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonTag>> fetchTags({
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/trends/tags',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTag.fromJson)
        .toList();
  }

  /// Fetches trending statuses.
  ///
  /// `GET /api/v1/trends/statuses`
  ///
  /// Returns statuses that have received more interactions than others.
  /// [limit] controls the maximum number of results (default: 20, max: 40)
  /// and [offset] skips that many for pagination.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonStatus>> fetchStatuses({
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/trends/statuses',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// Fetches trending links.
  ///
  /// `GET /api/v1/trends/links`
  ///
  /// Returns links that are being frequently shared across the network.
  /// [limit] controls the maximum number of results (default: 10, max: 20)
  /// and [offset] skips that many for pagination.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonTrendsLink>> fetchLinks({
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/trends/links',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTrendsLink.fromJson)
        .toList();
  }
}
