import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_email_domain_block.dart';
import '../../models/mastodon_page.dart';

/// 管理者向けメールドメインブロック管理 API
///
/// サインアップ禁止メールドメインの管理を行う。
/// すべてのエンドポイントに `admin:read:email_domain_blocks` または
/// `admin:write:email_domain_blocks` の OAuth スコープが必要。
class AdminEmailDomainBlocksApi {
  const AdminEmailDomainBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// すべてのブロック済みメールドメインを取得する
  ///
  /// `GET /api/v1/admin/email_domain_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonAdminEmailDomainBlock>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/email_domain_blocks',
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
        .map(MastodonAdminEmailDomainBlock.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// ID を指定してメールドメインブロックの詳細を取得する
  ///
  /// `GET /api/v1/admin/email_domain_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminEmailDomainBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/email_domain_blocks/$id',
    );
    return MastodonAdminEmailDomainBlock.fromJson(data!);
  }

  /// メールドメインをブロックする
  ///
  /// `POST /api/v1/admin/email_domain_blocks`
  ///
  /// - [domain]: ブロックするメールドメイン（必須）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminEmailDomainBlock> create({
    required String domain,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/email_domain_blocks',
      method: 'POST',
      data: <String, dynamic>{'domain': domain},
    );
    return MastodonAdminEmailDomainBlock.fromJson(data!);
  }

  /// メールドメインブロックを削除する
  ///
  /// `DELETE /api/v1/admin/email_domain_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/email_domain_blocks/$id',
      method: 'DELETE',
    );
  }
}
