import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_email_domain_block.dart';
import '../../models/mastodon_page.dart';

/// Admin email domain block management API.
///
/// Manages email domains that are blocked from sign-up.
/// All endpoints require `admin:read:email_domain_blocks` or
/// `admin:write:email_domain_blocks` OAuth scopes.
class AdminEmailDomainBlocksApi {
  const AdminEmailDomainBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all blocked email domains.
  ///
  /// `GET /api/v1/admin/email_domain_blocks`
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Fetches an email domain block by its ID.
  ///
  /// `GET /api/v1/admin/email_domain_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminEmailDomainBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/email_domain_blocks/$id',
    );
    return MastodonAdminEmailDomainBlock.fromJson(data!);
  }

  /// Blocks an email domain.
  ///
  /// `POST /api/v1/admin/email_domain_blocks`
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Deletes an email domain block.
  ///
  /// `DELETE /api/v1/admin/email_domain_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/email_domain_blocks/$id',
      method: 'DELETE',
    );
  }
}
