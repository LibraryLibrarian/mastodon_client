import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_domain_allow.dart';

/// 管理者向けドメイン許可管理 API
///
/// フェデレーション許可ドメインの一覧取得・追加・削除を行う。
/// すべてのエンドポイントに `admin:read:domain_allows` または
/// `admin:write:domain_allows` の OAuth スコープが必要。
class AdminDomainAllowsApi {
  const AdminDomainAllowsApi(this._http);

  final MastodonHttpClient _http;

  /// すべての許可ドメインを取得する
  ///
  /// `GET /api/v1/admin/domain_allows`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminDomainAllow>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/domain_allows',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminDomainAllow.fromJson)
        .toList();
  }

  /// ID を指定して許可ドメインの詳細を取得する
  ///
  /// `GET /api/v1/admin/domain_allows/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminDomainAllow> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_allows/$id',
    );
    return MastodonAdminDomainAllow.fromJson(data!);
  }

  /// ドメインを許可リストに追加する
  ///
  /// `POST /api/v1/admin/domain_allows`
  ///
  /// - [domain]: 許可するドメイン（必須）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminDomainAllow> create({required String domain}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_allows',
      method: 'POST',
      data: <String, dynamic>{'domain': domain},
    );
    return MastodonAdminDomainAllow.fromJson(data!);
  }

  /// 許可ドメインを削除する
  ///
  /// `DELETE /api/v1/admin/domain_allows/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminDomainAllow> delete(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_allows/$id',
      method: 'DELETE',
    );
    return MastodonAdminDomainAllow.fromJson(data!);
  }
}
