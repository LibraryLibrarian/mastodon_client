import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_scheduled_status.dart';

/// API for managing scheduled statuses.
class ScheduledStatusesApi {
  /// Creates a [ScheduledStatusesApi] instance with the given
  /// [MastodonHttpClient].
  const ScheduledStatusesApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the authenticated user's scheduled statuses.
  ///
  /// `GET /api/v1/scheduled_statuses`
  ///
  /// [limit] controls the maximum number of results (default: 20, max: 40).
  /// Use [maxId] to return results older than that ID, [sinceId] for newer
  /// results, and [minId] for reverse-order forward pagination.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonScheduledStatus>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/scheduled_statuses',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonScheduledStatus.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a scheduled status by its ID.
  ///
  /// `GET /api/v1/scheduled_statuses/:id`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonScheduledStatus> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/scheduled_statuses/$id',
    );
    return MastodonScheduledStatus.fromJson(data!);
  }

  /// Updates the scheduled publication date of a scheduled status.
  ///
  /// `PUT /api/v1/scheduled_statuses/:id`
  ///
  /// [scheduledAt] is the new publication date in ISO 8601 format and must
  /// be at least 5 minutes in the future.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonScheduledStatus> update(
    String id, {
    required String scheduledAt,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/scheduled_statuses/$id',
      method: 'PUT',
      data: <String, dynamic>{'scheduled_at': scheduledAt},
    );
    return MastodonScheduledStatus.fromJson(data!);
  }

  /// Cancels (deletes) a scheduled status.
  ///
  /// `DELETE /api/v1/scheduled_statuses/:id`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/scheduled_statuses/$id',
      method: 'DELETE',
    );
  }
}
