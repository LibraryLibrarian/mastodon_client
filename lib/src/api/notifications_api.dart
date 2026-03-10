import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_notification.dart';

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
}
