import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_page.dart';

/// API client for listing endorsed (featured) accounts.
class EndorsementsApi {
  /// Creates an [EndorsementsApi] instance with the given [MastodonHttpClient].
  const EndorsementsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the accounts the user has featured on their profile.
  ///
  /// `GET /api/v1/endorsements`
  ///
  /// [limit] controls the maximum number of results (default: 40, max: 80).
  /// Use [maxId] to return results older than that ID and [sinceId] for
  /// newer results. Pagination cursors are parsed from the `Link` response
  /// header and stored in [MastodonPage].
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAccount>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/endorsements',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
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
