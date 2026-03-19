import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';

/// API client for user-level domain block management.
class DomainBlocksApi {
  /// Creates a [DomainBlocksApi] instance with the given [MastodonHttpClient].
  const DomainBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the list of blocked domains.
  ///
  /// `GET /api/v1/domain_blocks`
  ///
  /// [limit] controls the maximum number of results (default: 100, max: 200).
  /// Use [maxId] to return results older than that ID, [sinceId] for newer
  /// results, and [minId] for reverse-order forward pagination.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<String>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/domain_blocks',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[]).cast<String>().toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Blocks a domain.
  ///
  /// `POST /api/v1/domain_blocks`
  ///
  /// Blocking a domain hides all public posts and notifications from that
  /// domain, removes existing followers from that domain, and prevents new
  /// follows to accounts on that domain.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> block(String domain) async {
    await _http.send<void>(
      '/api/v1/domain_blocks',
      method: 'POST',
      data: <String, dynamic>{'domain': domain},
    );
  }

  /// Unblocks a domain.
  ///
  /// `DELETE /api/v1/domain_blocks`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> unblock(String domain) async {
    await _http.send<void>(
      '/api/v1/domain_blocks',
      method: 'DELETE',
      data: <String, dynamic>{'domain': domain},
    );
  }
}
