import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_ip_block.dart';
import '../../models/admin/mastodon_admin_ip_block_request.dart';
import '../../models/mastodon_page.dart';

/// Admin IP block management API.
///
/// Manages IP address range blocks.
/// All endpoints require `admin:read:ip_blocks` or
/// `admin:write:ip_blocks` OAuth scopes.
class AdminIpBlocksApi {
  const AdminIpBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all IP blocks.
  ///
  /// `GET /api/v1/admin/ip_blocks`
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Fetches an IP block by its ID.
  ///
  /// `GET /api/v1/admin/ip_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminIpBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks/$id',
    );
    return MastodonAdminIpBlock.fromJson(data!);
  }

  /// Creates an IP block.
  ///
  /// `POST /api/v1/admin/ip_blocks`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminIpBlock> create(
    MastodonAdminIpBlockCreateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonAdminIpBlock.fromJson(data!);
  }

  /// Updates an IP block.
  ///
  /// `PUT /api/v1/admin/ip_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminIpBlock> update(
    String id,
    MastodonAdminIpBlockUpdateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks/$id',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonAdminIpBlock.fromJson(data!);
  }

  /// Deletes an IP block.
  ///
  /// `DELETE /api/v1/admin/ip_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/ip_blocks/$id',
      method: 'DELETE',
    );
  }
}
