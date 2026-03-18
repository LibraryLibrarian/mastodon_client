import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_domain_block.dart';
import '../../models/admin/mastodon_admin_domain_block_request.dart';
import '../../models/mastodon_page.dart';

/// Admin domain block management API.
///
/// Manages the list of blocked federation domains.
/// All endpoints require `admin:read:domain_blocks` or
/// `admin:write:domain_blocks` OAuth scopes.
class AdminDomainBlocksApi {
  const AdminDomainBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all blocked domains.
  ///
  /// `GET /api/v1/admin/domain_blocks`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAdminDomainBlock>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/domain_blocks',
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
        .map(MastodonAdminDomainBlock.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a domain block by its ID.
  ///
  /// `GET /api/v1/admin/domain_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminDomainBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_blocks/$id',
    );
    return MastodonAdminDomainBlock.fromJson(data!);
  }

  /// Blocks a domain.
  ///
  /// `POST /api/v1/admin/domain_blocks`
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Updates a domain block.
  ///
  /// `PUT /api/v1/admin/domain_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Deletes a domain block.
  ///
  /// `DELETE /api/v1/admin/domain_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/domain_blocks/$id',
      method: 'DELETE',
    );
  }
}
