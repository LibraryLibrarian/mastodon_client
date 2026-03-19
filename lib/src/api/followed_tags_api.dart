import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_tag.dart';

/// API for listing followed hashtags.
class FollowedTagsApi {
  /// Creates a [FollowedTagsApi] instance with the given [MastodonHttpClient].
  const FollowedTagsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the hashtags followed by the authenticated user.
  ///
  /// `GET /api/v1/followed_tags`
  ///
  /// [limit] controls the maximum number of results (default: 100, max: 200).
  /// Use [maxId] to return results older than that ID, [sinceId] for newer
  /// results, and [minId] for reverse-order forward pagination. Pagination
  /// is provided via the HTTP `Link` header; cursor IDs are internal
  /// follow-relationship record IDs, not Tag entity IDs.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonTag>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/followed_tags',
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
        .map(MastodonTag.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
