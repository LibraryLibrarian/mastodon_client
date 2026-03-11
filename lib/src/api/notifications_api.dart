import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_notification.dart';
import '../models/mastodon_notification_policy.dart';
import '../models/mastodon_notification_request.dart';
import '../models/mastodon_unread_notification_count.dart';

/// 通知に関するAPI
class NotificationsApi {
  const NotificationsApi(this._http);

  final MastodonHttpClient _http;

  /// ログイン中ユーザーの通知一覧を取得
  ///
  /// `GET /api/v1/notifications`
  ///
  /// - [limit]: 取得件数（最大 30、デフォルト 20）
  /// - [sinceId]: このID以降の通知を取得する（新しい方向）
  /// - [maxId]: このID以前の通知を取得する（古い方向）
  Future<List<MastodonNotification>> fetch({
    int limit = 20,
    String? sinceId,
    String? maxId,
  }) async {
    try {
      final query = <String, dynamic>{
        'limit': limit,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
      };
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/notifications',
        queryParameters: query,
      );
      return (response.data ?? [])
          .whereType<Map<String, dynamic>>()
          .map(MastodonNotification.fromJson)
          .toList(growable: false);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定IDの通知を取得
  ///
  /// `GET /api/v1/notifications/:id`
  ///
  /// - [id]: 取得する通知のID
  Future<MastodonNotification> fetchById(String id) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/notifications/$id',
      );
      return MastodonNotification.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// すべての通知をクリア
  ///
  /// `POST /api/v1/notifications/clear`
  Future<void> clear() async {
    try {
      await _http.dio.post<dynamic>('/api/v1/notifications/clear');
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定 ID の通知を削除
  ///
  /// `POST /api/v1/notifications/:id/dismiss`
  ///
  /// - [id]: 削除する通知のID
  Future<void> dismiss(String id) async {
    try {
      await _http.dio.post<dynamic>('/api/v1/notifications/$id/dismiss');
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 未読通知の件数を取得（Mastodon 4.3+）
  ///
  /// `GET /api/v1/notifications/unread_count`
  ///
  /// - [limit]: カウントの上限（最大 1000、デフォルト 100）
  /// - [types]: 集計対象の通知タイプ一覧
  /// - [excludeTypes]: 集計から除外する通知タイプ一覧
  /// - [accountId]: 特定のアカウントからの通知のみを集計
  Future<MastodonUnreadNotificationCount> fetchUnreadCount({
    int? limit,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
  }) async {
    try {
      final query = <String, dynamic>{
        'limit': ?limit,
        if (types != null && types.isNotEmpty) 'types[]': types,
        if (excludeTypes != null && excludeTypes.isNotEmpty)
          'exclude_types[]': excludeTypes,
        if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
      };
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/notifications/unread_count',
        queryParameters: query,
      );
      return MastodonUnreadNotificationCount.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 通知ポリシーを取得（Mastodon 4.3+）
  ///
  /// `GET /api/v2/notifications/policy`
  Future<MastodonNotificationPolicy> fetchPolicy() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v2/notifications/policy',
      );
      return MastodonNotificationPolicy.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 通知ポリシーを更新（Mastodon 4.3+）
  ///
  /// `PATCH /api/v2/notifications/policy`
  ///
  /// - [policy]: 更新する通知ポリシー
  Future<MastodonNotificationPolicy> updatePolicy(
    MastodonNotificationPolicy policy,
  ) async {
    try {
      final response = await _http.dio.patch<Map<String, dynamic>>(
        '/api/v2/notifications/policy',
        data: {
          'for_not_following': policy.forNotFollowing.name,
          'for_not_followers': policy.forNotFollowers.name,
          'for_new_accounts': policy.forNewAccounts.name,
          'for_private_mentions': policy.forPrivateMentions.name,
          'for_limited_accounts': policy.forLimitedAccounts.name,
        },
      );
      return MastodonNotificationPolicy.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// フィルタリングされた通知リクエストの一覧を取得（Mastodon 4.3+）
  ///
  /// `GET /api/v1/notifications/requests`
  ///
  /// - [maxId]: この ID 以前のリクエストを取得する（古い方向）
  /// - [sinceId]: この ID 以降のリクエストを取得する（新しい方向）
  /// - [minId]: この ID 直後のリクエストを取得する（新しい方向、即時）
  /// - [limit]: 取得件数（最大 80、デフォルト 40）
  Future<List<MastodonNotificationRequest>> fetchRequests({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    try {
      final query = <String, dynamic>{
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
        'limit': ?limit,
      };
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/notifications/requests',
        queryParameters: query,
      );
      return (response.data ?? [])
          .whereType<Map<String, dynamic>>()
          .map(MastodonNotificationRequest.fromJson)
          .toList(growable: false);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定IDの通知リクエストを取得（Mastodon 4.3+）
  ///
  /// `GET /api/v1/notifications/requests/:id`
  ///
  /// - [id]: 取得する通知リクエストのID
  Future<MastodonNotificationRequest> fetchRequestById(String id) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/notifications/requests/$id',
      );
      return MastodonNotificationRequest.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 通知リクエストを承認（Mastodon 4.3+）
  ///
  /// `POST /api/v1/notifications/requests/:id/accept`
  ///
  /// 承認されたアカウントからの今後の通知はフィルタリングされなくなる。
  ///
  /// - [id]: 承認する通知リクエストの ID
  Future<void> acceptRequest(String id) async {
    try {
      await _http.dio.post<dynamic>(
        '/api/v1/notifications/requests/$id/accept',
      );
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 通知リクエストを却下（Mastodon 4.3+）
  ///
  /// `POST /api/v1/notifications/requests/:id/dismiss`
  ///
  /// - [id]: 却下する通知リクエストの ID
  Future<void> dismissRequest(String id) async {
    try {
      await _http.dio.post<dynamic>(
        '/api/v1/notifications/requests/$id/dismiss',
      );
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 複数の通知リクエストを一括承認（Mastodon 4.3+）
  ///
  /// `POST /api/v1/notifications/requests/accept`
  ///
  /// - [ids]: 承認する通知リクエストの ID リスト
  Future<void> acceptRequests(List<String> ids) async {
    try {
      await _http.dio.post<dynamic>(
        '/api/v1/notifications/requests/accept',
        data: {'id': ids},
      );
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 複数の通知リクエストを一括却下（Mastodon 4.3+）
  ///
  /// `POST /api/v1/notifications/requests/dismiss`
  ///
  /// - [ids]: 却下する通知リクエストの ID リスト
  Future<void> dismissRequests(List<String> ids) async {
    try {
      await _http.dio.post<dynamic>(
        '/api/v1/notifications/requests/dismiss',
        data: {'id': ids},
      );
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 承認済み通知リクエストのマージ状態を確認（Mastodon 4.3+）
  ///
  /// `GET /api/v1/notifications/requests/merged`
  ///
  /// 承認された通知リクエストが通知一覧にマージされたかどうかを返す。
  Future<bool> checkRequestsMerged() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/notifications/requests/merged',
      );
      return response.data?['merged'] == true;
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }
}
