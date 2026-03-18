import '../client/mastodon_http_client.dart';
import '../models/mastodon_marker.dart';

/// API for timeline read position markers.
class MarkersApi {
  /// Creates a [MarkersApi] instance with the given [MastodonHttpClient].
  const MarkersApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the saved timeline read positions.
  ///
  /// `GET /api/v1/markers`
  ///
  /// [timelines] is a list of timeline names to fetch markers for; valid
  /// values are `home` and `notifications`. Returns an empty map if
  /// unspecified. The result is a map with timeline names as keys and
  /// [MastodonMarker] as values.
  ///
  /// Throws a `MastodonException` on failure.
  Future<Map<String, MastodonMarker>> fetch(List<String> timelines) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/markers',
      queryParameters: <String, dynamic>{'timeline[]': timelines},
    );
    if (data == null) return const {};
    return data.map(
      (key, value) => MapEntry(
        key,
        MastodonMarker.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  /// Saves timeline read positions.
  ///
  /// `POST /api/v1/markers`
  ///
  /// At least one of [homeLastReadId] or [notificationsLastReadId] must be
  /// specified. Returns a map containing the updated markers. Retry if the
  /// server responds with `409 Conflict`, which indicates a write conflict.
  ///
  /// Throws a `MastodonException` on failure.
  Future<Map<String, MastodonMarker>> save({
    String? homeLastReadId,
    String? notificationsLastReadId,
  }) async {
    final body = <String, dynamic>{
      if (homeLastReadId != null) 'home': {'last_read_id': homeLastReadId},
      if (notificationsLastReadId != null)
        'notifications': {'last_read_id': notificationsLastReadId},
    };
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/markers',
      method: 'POST',
      data: body,
    );
    if (data == null) return const {};
    return data.map(
      (key, value) => MapEntry(
        key,
        MastodonMarker.fromJson(value as Map<String, dynamic>),
      ),
    );
  }
}
