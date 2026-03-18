import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_canonical_email_block.dart';
import '../../models/mastodon_page.dart';

/// Admin canonical email block management API.
///
/// Manages blocks on canonical (normalized) email addresses.
/// All endpoints require `admin:read:canonical_email_blocks` or
/// `admin:write:canonical_email_blocks` OAuth scopes.
class AdminCanonicalEmailBlocksApi {
  const AdminCanonicalEmailBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all canonical email blocks.
  ///
  /// `GET /api/v1/admin/canonical_email_blocks`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAdminCanonicalEmailBlock>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/admin/canonical_email_blocks',
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
        .map(MastodonAdminCanonicalEmailBlock.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a canonical email block by its ID.
  ///
  /// `GET /api/v1/admin/canonical_email_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminCanonicalEmailBlock> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/canonical_email_blocks/$id',
    );
    return MastodonAdminCanonicalEmailBlock.fromJson(data!);
  }

  /// Tests canonicalization and hashing of an email address.
  ///
  /// `POST /api/v1/admin/canonical_email_blocks/test`
  ///
  /// Returns a list of existing blocks that match the email.
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Creates a canonical email block.
  ///
  /// `POST /api/v1/admin/canonical_email_blocks`
  ///
  /// Provide either [email] or [canonicalEmailHash]. When [email] is
  /// specified, [canonicalEmailHash] is ignored; otherwise the hash is
  /// required.
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Deletes a canonical email block.
  ///
  /// `DELETE /api/v1/admin/canonical_email_blocks/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/canonical_email_blocks/$id',
      method: 'DELETE',
    );
  }
}
