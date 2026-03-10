import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_status_context.dart';

/// 投稿（Status）に関するAPI
class StatusesApi {
  const StatusesApi(this._http);

  final MastodonHttpClient _http;

  /// 投稿を単体取得
  ///
  /// `GET /api/v1/statuses/{id}`
  ///
  /// - [id]: 取得する投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> fetch(String id) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/statuses/$id',
      );
      return MastodonStatus.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 投稿のコンテキスト（祖先・子孫）を取得
  ///
  /// `GET /api/v1/statuses/{id}/context`
  ///
  /// - [id]: 対象投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatusContext> fetchContext(String id) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/statuses/$id/context',
      );
      return MastodonStatusContext.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }
}
