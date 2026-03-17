import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_account.dart';
import '../../models/admin/mastodon_admin_account_action_request.dart';
import '../../models/mastodon_page.dart';

/// 管理者向けアカウント管理 API
///
/// アカウントの一覧取得・承認・拒否・モデレーションアクションなどを行う。
/// すべてのエンドポイントに `admin:read:accounts` または
/// `admin:write:accounts` の OAuth スコープが必要。
class AdminAccountsApi {
  /// [MastodonHttpClient] を受け取り、管理者アカウント API へのアクセスを提供する
  const AdminAccountsApi(this._http);

  final MastodonHttpClient _http;

  /// すべてのアカウントを取得する（v1）
  ///
  /// `GET /api/v1/admin/accounts`
  ///
  /// - [local]: ローカルアカウントのみに絞り込む
  /// - [remote]: リモートアカウントのみに絞り込む
  /// - [active]: アクティブなアカウントのみに絞り込む
  /// - [pending]: 承認待ちのアカウントのみに絞り込む
  /// - [disabled]: 無効化されたアカウントのみに絞り込む
  /// - [silenced]: サイレンスされたアカウントのみに絞り込む
  /// - [suspended]: 凍結されたアカウントのみに絞り込む
  /// - [sensitized]: センシティブ指定されたアカウントのみに絞り込む
  /// - [username]: ユーザー名で検索
  /// - [displayName]: 表示名で検索
  /// - [byDomain]: ドメインで絞り込む
  /// - [email]: メールアドレスで検索
  /// - [ip]: IP アドレスで検索
  /// - [staff]: スタッフアカウントのみに絞り込む
  /// - [maxId]: ページネーション上限 ID
  /// - [sinceId]: ページネーション下限 ID
  /// - [minId]: 前方ページネーション用 ID
  /// - [limit]: 最大取得件数（デフォルト: 100、最大: 200）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonAdminAccount>> fetch({
    bool? local,
    bool? remote,
    bool? active,
    bool? pending,
    bool? disabled,
    bool? silenced,
    bool? suspended,
    bool? sensitized,
    String? username,
    String? displayName,
    String? byDomain,
    String? email,
    String? ip,
    bool? staff,
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/accounts',
      queryParameters: <String, dynamic>{
        'local': ?local,
        'remote': ?remote,
        'active': ?active,
        'pending': ?pending,
        'disabled': ?disabled,
        'silenced': ?silenced,
        'suspended': ?suspended,
        'sensitized': ?sensitized,
        'username': ?username,
        'display_name': ?displayName,
        'by_domain': ?byDomain,
        'email': ?email,
        'ip': ?ip,
        'staff': ?staff,
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminAccount.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// すべてのアカウントを取得する（v2）
  ///
  /// `GET /api/v2/admin/accounts`
  ///
  /// v1 と異なり、`origin` / `status` / `permissions` / `role_ids` で
  /// フィルタリングする。
  ///
  /// - [origin]: `local` または `remote`
  /// - [status]: `active` / `pending` / `disabled` / `silenced` / `suspended`
  /// - [permissions]: `staff` でスタッフアカウントに絞り込む
  /// - [roleIds]: 指定ロール ID のアカウントに絞り込む
  /// - [invitedBy]: 招待者のアカウント ID で絞り込む
  /// - [username]: ユーザー名で検索
  /// - [displayName]: 表示名で検索
  /// - [byDomain]: ドメインで絞り込む
  /// - [email]: メールアドレスで検索
  /// - [ip]: IP アドレスで検索
  /// - [maxId]: ページネーション上限 ID
  /// - [sinceId]: ページネーション下限 ID
  /// - [minId]: 前方ページネーション用 ID
  /// - [limit]: 最大取得件数（デフォルト: 100、最大: 200）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonAdminAccount>> fetchV2({
    String? origin,
    String? status,
    String? permissions,
    List<String>? roleIds,
    String? invitedBy,
    String? username,
    String? displayName,
    String? byDomain,
    String? email,
    String? ip,
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v2/admin/accounts',
      queryParameters: <String, dynamic>{
        'origin': ?origin,
        'status': ?status,
        'permissions': ?permissions,
        'role_ids[]': ?roleIds,
        'invited_by': ?invitedBy,
        'username': ?username,
        'display_name': ?displayName,
        'by_domain': ?byDomain,
        'email': ?email,
        'ip': ?ip,
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminAccount.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// ID を指定してアカウントの管理者向け詳細情報を取得する
  ///
  /// `GET /api/v1/admin/accounts/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// 保留中のアカウントを承認する
  ///
  /// `POST /api/v1/admin/accounts/{id}/approve`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> approve(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/approve',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// 保留中のアカウントを拒否する
  ///
  /// `POST /api/v1/admin/accounts/{id}/reject`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> reject(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/reject',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// 凍結済みアカウントのデータを完全に削除する
  ///
  /// `DELETE /api/v1/admin/accounts/{id}`
  ///
  /// 「ユーザーデータ削除」権限が必要。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> delete(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id',
      method: 'DELETE',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// アカウントに対してモデレーションアクションを実行する
  ///
  /// `POST /api/v1/admin/accounts/{id}/action`
  ///
  /// 関連する未解決の通報も自動的に解決される。
  /// 「ユーザー管理」および「通報管理」権限が必要。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> performAction(
    String id,
    MastodonAdminAccountActionRequest request,
  ) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/action',
      method: 'POST',
      data: request.toJson(),
    );
  }

  /// 無効化されたアカウントを再有効化する
  ///
  /// `POST /api/v1/admin/accounts/{id}/enable`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> enable(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/enable',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// アカウントのサイレンスを解除する
  ///
  /// `POST /api/v1/admin/accounts/{id}/unsilence`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> unsilence(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/unsilence',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// アカウントの凍結を解除する
  ///
  /// `POST /api/v1/admin/accounts/{id}/unsuspend`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> unsuspend(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/unsuspend',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// アカウントのセンシティブ指定を解除する
  ///
  /// `POST /api/v1/admin/accounts/{id}/unsensitive`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminAccount> unsensitive(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/unsensitive',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }
}
