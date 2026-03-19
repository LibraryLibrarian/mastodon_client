import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_list.dart';
import '../models/mastodon_page.dart';

/// API client for creating and managing lists.
class ListsApi {
  /// Creates a [ListsApi] instance with the given [MastodonHttpClient].
  const ListsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all lists owned by the user.
  ///
  /// `GET /api/v1/lists`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonList>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v1/lists');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonList.fromJson)
        .toList();
  }

  /// Fetches a list by its ID.
  ///
  /// `GET /api/v1/lists/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonList> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/lists/$id',
    );
    return MastodonList.fromJson(data!);
  }

  /// Creates a new list.
  ///
  /// `POST /api/v1/lists`
  ///
  /// [title] is required. [repliesPolicy] controls which replies appear:
  /// `followed` shows replies to followed users, `list` shows replies to
  /// list members, and `none` hides all replies (uses server default when
  /// omitted). Set [exclusive] to `true` to exclude list member posts from
  /// the home timeline.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonList> create({
    required String title,
    String? repliesPolicy,
    bool? exclusive,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/lists',
      method: 'POST',
      data: <String, dynamic>{
        'title': title,
        'replies_policy': ?repliesPolicy,
        'exclusive': ?exclusive,
      },
    );
    return MastodonList.fromJson(data!);
  }

  /// Updates the properties of a list.
  ///
  /// `PUT /api/v1/lists/{id}`
  ///
  /// [title] is required. [repliesPolicy] is one of `followed`, `list`,
  /// or `none`. Set [exclusive] to `true` to exclude list member posts
  /// from the home timeline.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonList> update(
    String id, {
    required String title,
    String? repliesPolicy,
    bool? exclusive,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/lists/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'title': title,
        'replies_policy': ?repliesPolicy,
        'exclusive': ?exclusive,
      },
    );
    return MastodonList.fromJson(data!);
  }

  /// Deletes a list.
  ///
  /// `DELETE /api/v1/lists/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/lists/$id',
      method: 'DELETE',
    );
  }

  /// Fetches the accounts belonging to a list.
  ///
  /// `GET /api/v1/lists/{id}/accounts`
  ///
  /// [limit] controls the maximum number of results (default: 40, max: 80;
  /// pass `0` to fetch all). Use [maxId] to return results before that ID,
  /// [sinceId] for results after it, and [minId] for immediate forward
  /// pagination. Next/previous page cursors are parsed from the `Link`
  /// header and stored in [MastodonPage.nextMaxId] / [MastodonPage.prevMinId].
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAccount>> fetchAccounts(
    String id, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/lists/$id/accounts',
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

  /// Adds accounts to a list.
  ///
  /// `POST /api/v1/lists/{id}/accounts`
  ///
  /// The accounts to add must be followed by the user.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> addAccounts(
    String id, {
    required List<String> accountIds,
  }) async {
    await _http.send<void>(
      '/api/v1/lists/$id/accounts',
      method: 'POST',
      data: <String, dynamic>{'account_ids': accountIds},
    );
  }

  /// Removes accounts from a list.
  ///
  /// `DELETE /api/v1/lists/{id}/accounts`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> removeAccounts(
    String id, {
    required List<String> accountIds,
  }) async {
    await _http.send<void>(
      '/api/v1/lists/$id/accounts',
      method: 'DELETE',
      data: <String, dynamic>{'account_ids': accountIds},
    );
  }
}
