import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_account.dart';
import '../../models/admin/mastodon_admin_account_action_request.dart';
import '../../models/mastodon_page.dart';

/// Admin account management API.
///
/// Provides account listing, approval, rejection, and moderation actions.
/// All endpoints require `admin:read:accounts` or `admin:write:accounts`
/// OAuth scopes.
class AdminAccountsApi {
  /// Creates an [AdminAccountsApi] instance with the given
  /// [MastodonHttpClient].
  const AdminAccountsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all accounts (v1).
  ///
  /// `GET /api/v1/admin/accounts`
  ///
  /// Set [local] or [remote] to restrict to local or remote accounts.
  /// Use [active], [pending], [disabled], [silenced], [suspended], or
  /// [sensitized] to filter by account status. Search within the results
  /// using [username], [displayName], [email], or [ip]. [byDomain] filters
  /// by domain and [staff] restricts to staff accounts. Use [maxId],
  /// [sinceId], and [minId] for pagination. [limit] controls the maximum
  /// number of results (default: 100, max: 200).
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Fetches all accounts (v2).
  ///
  /// `GET /api/v2/admin/accounts`
  ///
  /// Unlike v1, filters by `origin` / `status` / `permissions` /
  /// `role_ids`. [origin] is `local` or `remote`. [status] is one of
  /// `active`, `pending`, `disabled`, `silenced`, or `suspended`.
  /// Pass `staff` as [permissions] to filter to staff accounts. [roleIds]
  /// restricts to accounts with those role IDs, and [invitedBy] filters
  /// by inviter account ID. Search within results using [username],
  /// [displayName], [email], [ip], or [byDomain]. Use [maxId], [sinceId],
  /// and [minId] for pagination. [limit] controls the maximum number of
  /// results (default: 100, max: 200).
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Fetches admin-level account details by ID.
  ///
  /// `GET /api/v1/admin/accounts/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Approves a pending account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/approve`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> approve(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/approve',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Rejects a pending account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/reject`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> reject(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/reject',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Permanently deletes the data of a suspended account.
  ///
  /// `DELETE /api/v1/admin/accounts/{id}`
  ///
  /// Requires "Delete user data" permission.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> delete(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id',
      method: 'DELETE',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Performs a moderation action on an account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/action`
  ///
  /// Related unresolved reports are automatically resolved.
  /// Requires "Manage Users" and "Manage Reports" permissions.
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Re-enables a disabled account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/enable`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> enable(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/enable',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Removes the silence from an account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/unsilence`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> unsilence(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/unsilence',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Unsuspends an account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/unsuspend`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> unsuspend(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/unsuspend',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }

  /// Removes the sensitive flag from an account.
  ///
  /// `POST /api/v1/admin/accounts/{id}/unsensitive`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminAccount> unsensitive(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/accounts/$id/unsensitive',
      method: 'POST',
    );
    return MastodonAdminAccount.fromJson(data!);
  }
}
