import '../client/mastodon_http_client.dart';
import '../models/mastodon_async_refresh.dart';

/// API client for checking async refresh status (experimental).
///
/// Experimental API added in Mastodon 4.4.0.
/// Used to check the progress of background jobs.
class AsyncRefreshesApi {
  /// Creates an [AsyncRefreshesApi] instance with the given
  /// [MastodonHttpClient].
  const AsyncRefreshesApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the status of an async refresh operation.
  ///
  /// `GET /api/v1_alpha/async_refreshes/{id}`
  ///
  /// Requires authentication (`read` scope). The [id] is obtained from
  /// the `Mastodon-Async-Refresh` header of other API responses.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAsyncRefresh> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1_alpha/async_refreshes/$id',
    );
    final inner = data!['async_refresh'] as Map<String, dynamic>;
    return MastodonAsyncRefresh.fromJson(inner);
  }
}
