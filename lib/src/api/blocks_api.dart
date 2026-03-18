import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_page.dart';
import 'accounts_api.dart' show AccountsApi;

/// API client for listing blocked accounts.
class BlocksApi {
  /// Creates a [BlocksApi] instance with the given [MastodonHttpClient].
  const BlocksApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the list of blocked accounts.
  ///
  /// `GET /api/v1/blocks`
  ///
  /// [limit] controls the maximum number of results (default: 40, max: 80).
  /// Use [maxId] to return results older than that ID, [sinceId] for newer
  /// results, and [minId] for reverse-order forward pagination. Pagination
  /// cursors are parsed from the `Link` response header and stored in
  /// [MastodonPage].
  ///
  /// Use [AccountsApi]'s `block` / `unblock` to block or unblock accounts.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAccount>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/blocks',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
