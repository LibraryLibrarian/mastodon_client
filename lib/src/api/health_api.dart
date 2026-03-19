import '../client/mastodon_http_client.dart';

/// API client for server health checks.
class HealthApi {
  /// Creates a [HealthApi] instance with the given [MastodonHttpClient].
  const HealthApi(this._http);

  final MastodonHttpClient _http;

  /// Checks whether the instance is healthy.
  ///
  /// `GET /health`
  ///
  /// No authentication required.
  /// Returns `true` if the web process, database, and cache connections
  /// are all healthy. Throws an exception if the server returns an
  /// unhealthy response.
  ///
  /// Throws a `MastodonException` on failure.
  Future<bool> check() async {
    await _http.send<dynamic>('/health');
    return true;
  }
}
