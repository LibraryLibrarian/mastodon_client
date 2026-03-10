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

  /// 指定した投稿をブーストする
  ///
  /// `POST /api/v1/statuses/{id}/reblog`
  ///
  /// 返り値は**ブースト投稿（Wrapper）**であり、元投稿とは異なる点に注意
  ///
  /// - [MastodonStatus.id]: ブースト投稿自体の新しいID（元投稿のIDとは異なる）
  /// - [MastodonStatus.account]: ブーストした自分のアカウント
  /// - [MastodonStatus.createdAt]: ブーストした日時
  /// - [MastodonStatus.content]: 空文字（`""`）
  /// - [MastodonStatus.reblog]: **元投稿がまるごと格納される**（このフィールドが主役）
  ///   - [MastodonStatus.reblog]`.id`: 元投稿のID
  ///   - [MastodonStatus.reblog]`.reblogsCount`: ブースト後の更新済みブースト数
  /// - [MastodonStatus.reblogged]: `true`
  /// - [MastodonStatus.visibility]: [visibility] で指定した公開範囲
  ///
  /// - [id]: ブーストする投稿のID
  /// - [visibility]: ブーストの公開範囲（省略時はサーバーのデフォルト）
  Future<MastodonStatus> boost(String id, {String? visibility}) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/statuses/$id/reblog',
        data: <String, dynamic>{'visibility': ?visibility},
      );
      return MastodonStatus.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定した投稿のブーストを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unreblog`
  ///
  /// 返り値は[boost]とは異なり**元投稿そのもの**であり、Wrapperではない
  ///
  /// - [MastodonStatus.id]: 元投稿のID（ブースト投稿のIDとは異なる）
  /// - [MastodonStatus.account]: 元投稿者のアカウント
  /// - [MastodonStatus.content]: 元投稿の本文
  /// - [MastodonStatus.reblog]: `null`
  /// - [MastodonStatus.reblogged]: `false`
  /// - [MastodonStatus.reblogsCount]: ブースト解除後の更新済みブースト数
  ///
  /// - [id]: ブーストを解除する投稿のID
  Future<MastodonStatus> unboost(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/statuses/$id/unreblog',
        data: <String, dynamic>{},
      );
      return MastodonStatus.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定した投稿をお気に入りに追加する
  ///
  /// `POST /api/v1/statuses/{id}/favourite`
  ///
  /// 返り値は**元投稿そのもの**（お気に入り後の更新済み状態）
  ///
  /// - [MastodonStatus.favourited]: `true`
  /// - [MastodonStatus.favouritesCount]: お気に入り追加後の更新済みお気に入り数
  ///
  /// - [id]: お気に入りに追加する投稿のID
  Future<MastodonStatus> favourite(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/statuses/$id/favourite',
        data: <String, dynamic>{},
      );
      return MastodonStatus.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定した投稿のお気に入りを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unfavourite`
  ///
  /// 返り値は**元投稿そのもの**（お気に入り解除後の更新済み状態）
  ///
  /// - [MastodonStatus.favourited]: `false`
  /// - [MastodonStatus.favouritesCount]: お気に入り解除後の更新済みお気に入り数
  ///
  /// - [id]: お気に入りを解除する投稿のID
  Future<MastodonStatus> unfavourite(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/statuses/$id/unfavourite',
        data: <String, dynamic>{},
      );
      return MastodonStatus.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }
}
