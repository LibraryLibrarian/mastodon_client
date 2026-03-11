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
  /// - [minId]: このID以降で最も古い投稿から取得する（前方ページネーション）
  Future<List<MastodonStatus>> fetchHome({
    int limit = 20,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/home',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
  );

  /// ローカルタイムラインを取得する
  ///
  /// `GET /api/v1/timelines/public?local=true`
  ///
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  /// - [minId]: このID以降で最も古い投稿から取得する（前方ページネーション）
  Future<List<MastodonStatus>> fetchLocal({
    int limit = 20,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/public',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {'local': true},
  );

  /// 連合タイムラインを取得する
  ///
  /// `GET /api/v1/timelines/public`
  ///
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  /// - [minId]: このID以降で最も古い投稿から取得する（前方ページネーション）
  Future<List<MastodonStatus>> fetchFederated({
    int limit = 20,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/public',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
  );

  /// 指定したハッシュタグのタイムラインを取得する
  ///
  /// `GET /api/v1/timelines/tag/:hashtag`
  ///
  /// - [hashtag]: 検索するハッシュタグ（`#` を除いた文字列）
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  /// - [minId]: このID以降で最も古い投稿から取得する（前方ページネーション）
  /// - [localOnly]: `true` の場合、ローカルの投稿のみを返す
  /// - [remoteOnly]: `true` の場合、リモートの投稿のみを返す
  /// - [onlyMedia]: `true` の場合、メディア添付のある投稿のみを返す
  /// - [any]: これらのハッシュタグのいずれかを含む投稿も対象に加える
  /// - [all]: これらのハッシュタグをすべて含む投稿のみを対象にする
  /// - [none]: これらのハッシュタグをいずれかでも含む投稿を除外する
  Future<List<MastodonStatus>> fetchHashtag(
    String hashtag, {
    int limit = 20,
    String? sinceId,
    String? maxId,
    String? minId,
    bool localOnly = false,
    bool remoteOnly = false,
    bool onlyMedia = false,
    List<String>? any,
    List<String>? all,
    List<String>? none,
  }) => _fetchTimeline(
    '/api/v1/timelines/tag/$hashtag',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {
      if (localOnly) 'local': true,
      if (remoteOnly) 'remote': true,
      if (onlyMedia) 'only_media': true,
      if (any != null && any.isNotEmpty) 'any[]': any,
      if (all != null && all.isNotEmpty) 'all[]': all,
      if (none != null && none.isNotEmpty) 'none[]': none,
    },
  );

  /// 指定したリストのタイムラインを取得する
  ///
  /// `GET /api/v1/timelines/list/:list_id`
  ///
  /// - [listId]: 対象リストのID
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  /// - [minId]: このID以降で最も古い投稿から取得する（前方ページネーション）
  Future<List<MastodonStatus>> fetchList(
    String listId, {
    int limit = 20,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/list/$listId',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
  );

  /// 指定したURLに関連する投稿のタイムラインを取得する
  ///
  /// `GET /api/v1/timelines/link`
  ///
  /// - [url]: タイムラインを取得する対象のURL（必須）
  /// - [limit]: 取得件数（最大 40）
  /// - [sinceId]: このID以降の投稿を取得する（新しい方向）
  /// - [maxId]: このID以前の投稿を取得する（古い方向）
  /// - [minId]: このID以降で最も古い投稿から取得する（前方ページネーション）
  Future<List<MastodonStatus>> fetchLink(
    String url, {
    int limit = 20,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/link',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {'url': url},
  );

  Future<List<MastodonStatus>> _fetchTimeline(
    String path, {
    required int limit,
    String? sinceId,
    String? maxId,
    String? minId,
    Map<String, dynamic>? extraQuery,
  }) async {
    try {
      final query = <String, dynamic>{
        'limit': limit,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
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
