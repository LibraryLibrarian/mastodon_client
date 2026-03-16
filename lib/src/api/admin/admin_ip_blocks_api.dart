import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_ip_block.dart';
import '../../models/admin/mastodon_admin_ip_block_request.dart';
import '../../models/mastodon_page.dart';

/// 管理者向け IP ブロック管理 API
///
/// IP アドレス範囲のブロック管理を行う。
/// すべてのエンドポイントに `admin:read:ip_blocks` または
/// `admin:write:ip_blocks` の OAuth スコープが必要。
class AdminIpBlocksApi {
  const AdminIpBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// すべての IP ブロックを取得する
  ///
  /// `GET /api/v1/admin/ip_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonAdminIpBlock>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/ip_blocks',
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
        .map(MastodonAdminIpBlock.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// ID を指定して IP ブロックの詳細を取得する
  ///
  /// `GET /api/v1/admin/ip_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminIpBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks/$id',
    );
    return MastodonAdminIpBlock.fromJson(data!);
  }

  /// IP ブロックを作成する
  ///
  /// `POST /api/v1/admin/ip_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminIpBlock> create(
    MastodonAdminIpBlockRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonAdminIpBlock.fromJson(data!);
  }

  /// IP ブロックを更新する
  ///
  /// `PUT /api/v1/admin/ip_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminIpBlock> update(
    String id,
    MastodonAdminIpBlockRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks/$id',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonAdminIpBlock.fromJson(data!);
  }

  /// IP ブロックを削除する
  ///
  /// `DELETE /api/v1/admin/ip_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks/$id',
      method: 'DELETE',
    );
  }
}
