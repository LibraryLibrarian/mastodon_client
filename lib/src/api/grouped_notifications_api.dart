import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_grouped_notifications_results.dart';
import '../models/mastodon_page.dart';

/// Grouped notifications API (v2).
///
/// Provides the grouped notifications endpoints added in Mastodon 4.3+.
/// Groups notifications of the same type and target for efficient retrieval.
class GroupedNotificationsApi {
  const GroupedNotificationsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches grouped notifications.
  ///
  /// `GET /api/v2/notifications`
  ///
  /// Use [maxId], [sinceId], and [minId] for pagination by group key.
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). [types] and [excludeTypes] filter by notification type.
  /// [accountId] restricts results to a specific account. [expandAccounts]
  /// sets the account expansion method (`full` or `partial_avatars`).
  /// [groupedTypes] lists the notification types to group, and
  /// [includeFiltered] controls whether filtered notifications are included.
  ///
  /// Pagination cursors are parsed from the `Link` response header and
  /// stored in [MastodonPage]. [MastodonPage.items] contains a single
  /// [MastodonGroupedNotificationsResults].
  Future<MastodonPage<MastodonGroupedNotificationsResults>> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
    String? expandAccounts,
    List<String>? groupedTypes,
    bool? includeFiltered,
  }) async {
    final query = <String, dynamic>{
      if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
      if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
      if (minId != null && minId.isNotEmpty) 'min_id': minId,
      'limit': ?limit,
      if (types != null && types.isNotEmpty) 'types[]': types,
      if (excludeTypes != null && excludeTypes.isNotEmpty)
        'exclude_types[]': excludeTypes,
      if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
      if (expandAccounts != null && expandAccounts.isNotEmpty)
        'expand_accounts': expandAccounts,
      if (groupedTypes != null && groupedTypes.isNotEmpty)
        'grouped_types[]': groupedTypes,
      'include_filtered': ?includeFiltered,
    };
    final response = await _http.sendRaw<Map<String, dynamic>>(
      '/api/v2/notifications',
      queryParameters: query,
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final results = MastodonGroupedNotificationsResults.fromJson(
      response.data!,
    );
    return MastodonPage(
      items: [results],
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a notification group by its group key.
  ///
  /// `GET /api/v2/notifications/:group_key`
  Future<MastodonGroupedNotificationsResults> fetchByGroupKey(
    String groupKey,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications/$groupKey',
    );
    return MastodonGroupedNotificationsResults.fromJson(data!);
  }

  /// Dismisses a notification group by its group key.
  ///
  /// `POST /api/v2/notifications/:group_key/dismiss`
  Future<void> dismiss(String groupKey) async {
    await _http.send<dynamic>(
      '/api/v2/notifications/$groupKey/dismiss',
      method: 'POST',
    );
  }

  /// Fetches the accounts associated with a notification group.
  ///
  /// `GET /api/v2/notifications/:group_key/accounts`
  Future<List<MastodonAccount>> fetchAccounts(String groupKey) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/notifications/$groupKey/accounts',
    );
    return (data ?? [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList(growable: false);
  }

  /// Fetches the count of unread notification groups.
  ///
  /// `GET /api/v2/notifications/unread_count`
  ///
  /// [limit] sets an upper bound on the returned count (uses server default
  /// when omitted). [types] and [excludeTypes] filter by notification type.
  /// [accountId] restricts the count to a specific account, and
  /// [groupedTypes] lists the notification types to group.
  Future<int> fetchUnreadCount({
    int? limit,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
    List<String>? groupedTypes,
  }) async {
    final query = <String, dynamic>{
      'limit': ?limit,
      if (types != null && types.isNotEmpty) 'types[]': types,
      if (excludeTypes != null && excludeTypes.isNotEmpty)
        'exclude_types[]': excludeTypes,
      if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
      if (groupedTypes != null && groupedTypes.isNotEmpty)
        'grouped_types[]': groupedTypes,
    };
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications/unread_count',
      queryParameters: query,
    );
    return (data?['count'] as int?) ?? 0;
  }
}
