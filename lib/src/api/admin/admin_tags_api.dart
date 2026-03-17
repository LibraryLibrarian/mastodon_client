import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_tag.dart';
import '../../models/mastodon_page.dart';

/// 管理者向けタグ API
class AdminTagsApi {
  const AdminTagsApi(this._http);

  final MastodonHttpClient _http;

  /// 管理者向けタグの一覧を取得する
  ///
  /// `GET /api/v1/admin/tags`
  ///
  /// - [maxId]: この ID 以前のタグを取得する（古い方向）
  /// - [sinceId]: この ID 以降のタグを取得する（新しい方向）
  /// - [minId]: この ID 直後のタグから取得する（前方ページネーション）
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
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

  /// 指定 ID のタグを取得する
  ///
  /// `GET /api/v1/admin/tags/:id`
  ///
  /// - [id]: 取得するタグの ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminTag> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/tags/$id',
    );
    return MastodonAdminTag.fromJson(data!);
  }

  /// 指定 ID のタグを更新する
  ///
  /// `PUT /api/v1/admin/tags/:id`
  ///
  /// - [id]: 更新するタグの ID
  /// - [displayName]: タグの表示名
  /// - [listable]: 一覧に表示するかどうか
  /// - [trendable]: トレンドに表示可能かどうか
  /// - [usable]: 投稿で使用可能かどうか
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
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
