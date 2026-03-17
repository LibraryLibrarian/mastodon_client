import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_tag.dart';
import '../../models/mastodon_page.dart';

/// 管理者向けタグ API
class AdminTagsApi {
  const AdminTagsApi(this._http);

  final MastodonHttpClient _http;

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

  Future<MastodonAdminTag> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/tags/$id',
    );
    return MastodonAdminTag.fromJson(data!);
  }

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
