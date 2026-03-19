import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_tag.dart';
import '../../models/mastodon_page.dart';

/// Admin tags API.
class AdminTagsApi {
  const AdminTagsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches a list of admin tags.
  ///
  /// `GET /api/v1/admin/tags`
  ///
  /// Use [maxId] to return results older than that ID, [sinceId] for
  /// newer results, and [minId] for immediate forward pagination. [limit]
  /// controls the maximum number of results (uses server default when
  /// omitted).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAdminTag>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/tags',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminTag.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a tag by its ID.
  ///
  /// `GET /api/v1/admin/tags/:id`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminTag> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/tags/$id',
    );
    return MastodonAdminTag.fromJson(data!);
  }

  /// Updates a tag by its ID.
  ///
  /// `PUT /api/v1/admin/tags/:id`
  ///
  /// All parameters are optional; only provided fields are updated.
  /// [displayName] sets the display name, [listable] controls whether
  /// the tag appears in listings, [trendable] whether it is allowed in
  /// trends, and [usable] whether it may be used in posts.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminTag> update(
    String id, {
    String? displayName,
    bool? listable,
    bool? trendable,
    bool? usable,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/tags/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'display_name': ?displayName,
        'listable': ?listable,
        'trendable': ?trendable,
        'usable': ?usable,
      },
    );
    return MastodonAdminTag.fromJson(data!);
  }
}
