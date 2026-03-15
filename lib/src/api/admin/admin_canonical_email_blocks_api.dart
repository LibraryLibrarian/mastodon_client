import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_canonical_email_block.dart';

/// 管理者向け正規化メールブロック管理 API
///
/// 正規化メールアドレスのブロック管理を行う。
/// すべてのエンドポイントに `admin:read:canonical_email_blocks` または
/// `admin:write:canonical_email_blocks` の OAuth スコープが必要。
class AdminCanonicalEmailBlocksApi {
  const AdminCanonicalEmailBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// すべての正規化メールブロックを取得する
  ///
  /// `GET /api/v1/admin/canonical_email_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminCanonicalEmailBlock>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/canonical_email_blocks',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminCanonicalEmailBlock.fromJson)
        .toList();
  }

  /// ID を指定して正規化メールブロックの詳細を取得する
  ///
  /// `GET /api/v1/admin/canonical_email_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminCanonicalEmailBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/canonical_email_blocks/$id',
    );
    return MastodonAdminCanonicalEmailBlock.fromJson(data!);
  }

  /// メールアドレスの正規化・ハッシュ化をテストする
  ///
  /// `POST /api/v1/admin/canonical_email_blocks/test`
  ///
  /// 既存のブロックに一致するものがあればそのリストを返す。
  ///
  /// - [email]: テストするメールアドレス（必須）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminCanonicalEmailBlock>> test({
    required String email,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/canonical_email_blocks/test',
      method: 'POST',
      data: <String, dynamic>{'email': email},
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminCanonicalEmailBlock.fromJson)
        .toList();
  }

  /// 正規化メールブロックを作成する
  ///
  /// `POST /api/v1/admin/canonical_email_blocks`
  ///
  /// - [email]: ブロックするメールアドレス（指定時は canonicalEmailHash は無視）
  /// - [canonicalEmailHash]: 直接ハッシュを指定してブロック（email 未指定時に必要）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminCanonicalEmailBlock> create({
    String? email,
    String? canonicalEmailHash,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/canonical_email_blocks',
      method: 'POST',
      data: <String, dynamic>{
        'email': ?email,
        'canonical_email_hash': ?canonicalEmailHash,
      },
    );
    return MastodonAdminCanonicalEmailBlock.fromJson(data!);
  }

  /// 正規化メールブロックを削除する
  ///
  /// `DELETE /api/v1/admin/canonical_email_blocks/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/canonical_email_blocks/$id',
      method: 'DELETE',
    );
  }
}
