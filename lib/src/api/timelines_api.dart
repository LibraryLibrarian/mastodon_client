import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_status.dart';

/// タイムライン取得に関するAPI
class TimelinesApi {
  const TimelinesApi(this._http);

  final MastodonHttpClient _http;

  /// ホームタイムラインを取得する
  ///
  /// `GET /api/v1/timelines/home`
  ///
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  Future<List<MastodonStatus>> fetchHome({
    int limit = 20,
    String? sinceId,
    String? maxId,
  }) => _fetchTimeline(
    '/api/v1/timelines/home',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
  );

  /// ローカルタイムラインを取得する
  ///
  /// `GET /api/v1/timelines/public?local=true`
  ///
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  Future<List<MastodonStatus>> fetchLocal({
    int limit = 20,
    String? sinceId,
    String? maxId,
  }) => _fetchTimeline(
    '/api/v1/timelines/public',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    extraQuery: {'local': true},
  );

  /// 連合タイムラインを取得する
  ///
  /// `GET /api/v1/timelines/public`
  ///
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  Future<List<MastodonStatus>> fetchFederated({
    int limit = 20,
    String? sinceId,
    String? maxId,
  }) => _fetchTimeline(
    '/api/v1/timelines/public',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
  );

  Future<List<MastodonStatus>> _fetchTimeline(
    String path, {
    required int limit,
    String? sinceId,
    String? maxId,
    Map<String, dynamic>? extraQuery,
  }) async {
    try {
      final query = <String, dynamic>{
        'limit': limit,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        ...?extraQuery,
      };
      final response = await _http.dio.get<List<dynamic>>(
        path,
        queryParameters: query,
      );
      return (response.data ?? [])
          .whereType<Map<String, dynamic>>()
          .map(MastodonStatus.fromJson)
          .toList(growable: false);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }
}
