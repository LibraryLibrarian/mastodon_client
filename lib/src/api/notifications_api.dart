import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_notification.dart';
import '../models/mastodon_notification_policy.dart';
import '../models/mastodon_notification_request.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_unread_notification_count.dart';

/// Notifications API.
class NotificationsApi {
  const NotificationsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the authenticated user's notifications.
  ///
  /// `GET /api/v1/notifications`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [sinceId] for newer notifications, [maxId] for
  /// older ones, and [minId] for immediate forward pagination. [types]
  /// and [excludeTypes] filter by notification type. [accountId] restricts
  /// results to a specific account, and [includeFiltered] controls whether
  /// filtered notifications are included.
  Future<MastodonPage<MastodonNotification>> fetch({
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
    bool? includeFiltered,
  }) async {
    final query = <String, dynamic>{
      'limit': ?limit,
      if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
      if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
      if (minId != null && minId.isNotEmpty) 'min_id': minId,
      if (types != null && types.isNotEmpty) 'types[]': types,
      if (excludeTypes != null && excludeTypes.isNotEmpty)
        'exclude_types[]': excludeTypes,
      if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
      'include_filtered': ?includeFiltered,
    };
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/notifications',
      queryParameters: query,
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MastodonNotification.fromJson)
        .toList(growable: false);
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a notification by its ID.
  ///
  /// `GET /api/v1/notifications/:id`
  Future<MastodonNotification> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/notifications/$id',
    );
    return MastodonNotification.fromJson(data!);
  }

  /// Clears all notifications.
  ///
  /// `POST /api/v1/notifications/clear`
  Future<void> clear() async {
    await _http.send<dynamic>(
      '/api/v1/notifications/clear',
      method: 'POST',
    );
  }

  /// Dismisses a notification by its ID.
  ///
  /// `POST /api/v1/notifications/:id/dismiss`
  Future<void> dismiss(String id) async {
    await _http.send<dynamic>(
      '/api/v1/notifications/$id/dismiss',
      method: 'POST',
    );
  }

  /// Dismisses a notification by its ID (body-based).
  ///
  /// `POST /api/v1/notifications/dismiss`
  ///
  /// **Deprecated**: Deprecated in Mastodon 1.3.0, removed in 3.0.0.
  /// Use [dismiss] (path-based) instead.
  @Deprecated(
    'Removed in Mastodon 3.0.0. Use dismiss() instead',
  )
  Future<void> dismissV1(String id) async {
    await _http.send<dynamic>(
      '/api/v1/notifications/dismiss',
      method: 'POST',
      data: <String, dynamic>{'id': id},
    );
  }

  /// Fetches the unread notification count (Mastodon 4.3+).
  ///
  /// `GET /api/v1/notifications/unread_count`
  ///
  /// [limit] sets an upper bound on the returned count (uses server default
  /// when omitted). [types] and [excludeTypes] filter by notification type.
  /// [accountId] restricts the count to a specific account.
  Future<MastodonUnreadNotificationCount> fetchUnreadCount({
    int? limit,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
  }) async {
    final query = <String, dynamic>{
      'limit': ?limit,
      if (types != null && types.isNotEmpty) 'types[]': types,
      if (excludeTypes != null && excludeTypes.isNotEmpty)
        'exclude_types[]': excludeTypes,
      if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
    };
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/notifications/unread_count',
      queryParameters: query,
    );
    return MastodonUnreadNotificationCount.fromJson(data!);
  }

  /// Fetches the notification policy (Mastodon 4.3+).
  ///
  /// `GET /api/v2/notifications/policy`
  Future<MastodonNotificationPolicy> fetchPolicy() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications/policy',
    );
    return MastodonNotificationPolicy.fromJson(data!);
  }

  /// Updates the notification policy (Mastodon 4.3+).
  ///
  /// `PATCH /api/v2/notifications/policy`
  Future<MastodonNotificationPolicy> updatePolicy(
    MastodonNotificationPolicy policy,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications/policy',
      method: 'PATCH',
      data: {
        'for_not_following': policy.forNotFollowing.name,
        'for_not_followers': policy.forNotFollowers.name,
        'for_new_accounts': policy.forNewAccounts.name,
        'for_private_mentions': policy.forPrivateMentions.name,
        'for_limited_accounts': policy.forLimitedAccounts.name,
      },
    );
    return MastodonNotificationPolicy.fromJson(data!);
  }

  /// Fetches the list of filtered notification requests (Mastodon 4.3+).
  ///
  /// `GET /api/v1/notifications/requests`
  ///
  /// Use [maxId] to return requests older than that ID, [sinceId] for
  /// newer requests, and [minId] for immediate forward pagination. [limit]
  /// controls the maximum number of results (uses server default when
  /// omitted).
  Future<MastodonPage<MastodonNotificationRequest>> fetchRequests({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final query = <String, dynamic>{
      if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
      if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
      if (minId != null && minId.isNotEmpty) 'min_id': minId,
      'limit': ?limit,
    };
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/notifications/requests',
      queryParameters: query,
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MastodonNotificationRequest.fromJson)
        .toList(growable: false);
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a notification request by its ID (Mastodon 4.3+).
  ///
  /// `GET /api/v1/notifications/requests/:id`
  Future<MastodonNotificationRequest> fetchRequestById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/notifications/requests/$id',
    );
    return MastodonNotificationRequest.fromJson(data!);
  }

  /// Accepts a notification request (Mastodon 4.3+).
  ///
  /// `POST /api/v1/notifications/requests/:id/accept`
  ///
  /// Future notifications from the accepted account will no longer be filtered.
  Future<void> acceptRequest(String id) async {
    await _http.send<dynamic>(
      '/api/v1/notifications/requests/$id/accept',
      method: 'POST',
    );
  }

  /// Dismisses a notification request (Mastodon 4.3+).
  ///
  /// `POST /api/v1/notifications/requests/:id/dismiss`
  Future<void> dismissRequest(String id) async {
    await _http.send<dynamic>(
      '/api/v1/notifications/requests/$id/dismiss',
      method: 'POST',
    );
  }

  /// Accepts multiple notification requests at once (Mastodon 4.3+).
  ///
  /// `POST /api/v1/notifications/requests/accept`
  Future<void> acceptRequests(List<String> ids) async {
    await _http.send<dynamic>(
      '/api/v1/notifications/requests/accept',
      method: 'POST',
      data: {'id[]': ids},
    );
  }

  /// Dismisses multiple notification requests at once (Mastodon 4.3+).
  ///
  /// `POST /api/v1/notifications/requests/dismiss`
  Future<void> dismissRequests(List<String> ids) async {
    await _http.send<dynamic>(
      '/api/v1/notifications/requests/dismiss',
      method: 'POST',
      data: {'id[]': ids},
    );
  }

  /// Checks the merge status of accepted notification requests (Mastodon 4.3+).
  ///
  /// `GET /api/v1/notifications/requests/merged`
  ///
  /// Returns whether accepted notification requests have been merged
  /// into the notification list.
  Future<bool> checkRequestsMerged() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/notifications/requests/merged',
    );
    return data?['merged'] == true;
  }
}
