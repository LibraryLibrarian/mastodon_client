import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_domain_allow.dart';
import '../../models/mastodon_page.dart';

/// Admin domain allow management API.
///
/// Manages the list of domains allowed for federation.
/// All endpoints require `admin:read:domain_allows` or
/// `admin:write:domain_allows` OAuth scopes.
class AdminDomainAllowsApi {
  const AdminDomainAllowsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all allowed domains.
  ///
  /// `GET /api/v1/admin/domain_allows`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAdminDomainAllow>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/domain_allows',
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
        .map(MastodonAdminDomainAllow.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches an allowed domain by its ID.
  ///
  /// `GET /api/v1/admin/domain_allows/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminDomainAllow> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_allows/$id',
    );
    return MastodonAdminDomainAllow.fromJson(data!);
  }

  /// Adds a domain to the allow list.
  ///
  /// `POST /api/v1/admin/domain_allows`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminDomainAllow> create({required String domain}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_allows',
      method: 'POST',
      data: <String, dynamic>{'domain': domain},
    );
    return MastodonAdminDomainAllow.fromJson(data!);
  }

  /// Removes an allowed domain.
  ///
  /// `DELETE /api/v1/admin/domain_allows/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminDomainAllow> delete(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_allows/$id',
      method: 'DELETE',
    );
    return MastodonAdminDomainAllow.fromJson(data!);
  }
}
