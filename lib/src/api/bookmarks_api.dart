import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_status.dart';

/// API for listing bookmarked statuses.
class BookmarksApi {
  /// Creates a [BookmarksApi] instance with the given [MastodonHttpClient].
  const BookmarksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the authenticated user's bookmarked statuses.
  ///
  /// `GET /api/v1/bookmarks`
  ///
  /// [limit] controls the maximum number of results (default: 20, max: 40).
  /// Use [maxId] to return results older than that ID, [sinceId] for newer
  /// results, and [minId] for reverse-order forward pagination. Pagination
  /// cursors are parsed from the `Link` response header and stored in
  /// [MastodonPage].
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonStatus>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/bookmarks',
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
        .map(MastodonStatus.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
