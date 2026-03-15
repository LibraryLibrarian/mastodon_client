import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_domain_block.dart';
import '../../models/admin/mastodon_admin_domain_block_request.dart';

/// 管理者向けドメインブロック管理 API
///
/// フェデレーションブロックドメインの一覧取得・作成・更新・削除を行う。
/// すべてのエンドポイントに `admin:read:domain_blocks` または
/// `admin:write:domain_blocks` の OAuth スコープが必要。
class AdminDomainBlocksApi {
  const AdminDomainBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// すべてのブロック済みドメインを取得する
  ///
  /// `GET /api/v1/admin/domain_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminDomainBlock>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/domain_blocks',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminDomainBlock.fromJson)
        .toList();
  }

  /// ID を指定してドメインブロックの詳細を取得する
  ///
  /// `GET /api/v1/admin/domain_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminDomainBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_blocks/$id',
    );
    return MastodonAdminDomainBlock.fromJson(data!);
  }

  /// ドメインをブロックする
  ///
  /// `POST /api/v1/admin/domain_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminDomainBlock> create(
    MastodonAdminDomainBlockRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_blocks',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonAdminDomainBlock.fromJson(data!);
  }

  /// ドメインブロックを更新する
  ///
  /// `PUT /api/v1/admin/domain_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminDomainBlock> update(
    String id,
    MastodonAdminDomainBlockRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_blocks/$id',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonAdminDomainBlock.fromJson(data!);
  }

  /// ドメインブロックを削除する
  ///
  /// `DELETE /api/v1/admin/domain_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_blocks/$id',
      method: 'DELETE',
    );
  }
}
