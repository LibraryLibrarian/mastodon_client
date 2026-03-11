import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_media_attachment.dart';

/// メディアアップロードに関するAPI
class MediaApi {
  const MediaApi(this._http);

  final MastodonHttpClient _http;

  static const Set<int> _v2FallbackStatusCodes = <int>{404, 405, 501};
  static const int _maxPollAttempts = 8;
  static const Duration _pollInterval = Duration(milliseconds: 500);

  /// メディアをアップロードして[MastodonMediaAttachment]を返す
  ///
  /// `POST /api/v2/media`を優先、未対応サーバー（404 / 405 / 501）では
  /// `POST /api/v1/media`にフォールバックする
  ///
  /// サーバーが非同期処理（HTTP 202）を返した場合は `GET /api/v1/media/{id}` を
  /// 最大 [_maxPollAttempts] 回ポーリングし、`url` フィールドが非 nullになるまで待機
  ///
  /// タイムアウト時は[MastodonMediaProcessingTimeoutException]をthrow
  ///
  /// - [bytes]: アップロードするファイルのバイト列
  /// - [filename]: マルチパートリクエストで使用するファイル名
  /// - [description]: メディアの代替テキスト（省略可）
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonMediaAttachment> upload(
    Uint8List bytes,
    String filename, {
    String? description,
  }) async {
    try {
      final response = await _uploadWithFallback(
        bytes: bytes,
        filename: filename,
        description: description,
      );

      final data = response.data;
      if (data == null) {
        throw const MastodonApiException(
          statusCode: 0,
          message: 'メディアAPIからのレスポンスが空です',
        );
      }

      final attachment = MastodonMediaAttachment.fromJson(data);

      final shouldPoll = response.statusCode == 202 && attachment.url == null;
      if (!shouldPoll) {
        return attachment;
      }

      return await _pollUntilReady(attachment.id);
    } on MastodonException {
      rethrow;
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// v2を試みて、未対応サーバーならv1にフォールバック
  Future<Response<Map<String, dynamic>>> _uploadWithFallback({
    required Uint8List bytes,
    required String filename,
    String? description,
  }) async {
    try {
      final formData = FormData.fromMap(<String, dynamic>{
        'file': MultipartFile.fromBytes(bytes, filename: filename),
        if (description != null && description.isNotEmpty)
          'description': description,
      });
      return await _http.dio.post<Map<String, dynamic>>(
        '/api/v2/media',
        data: formData,
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == null || !_v2FallbackStatusCodes.contains(statusCode)) {
        rethrow;
      }
      final formData = FormData.fromMap(<String, dynamic>{
        'file': MultipartFile.fromBytes(bytes, filename: filename),
        if (description != null && description.isNotEmpty)
          'description': description,
      });
      return _http.dio.post<Map<String, dynamic>>(
        '/api/v1/media',
        data: formData,
      );
    }
  }

  /// メディア添付ファイルの属性を更新して[MastodonMediaAttachment]を返す
  ///
  /// `PUT /api/v1/media/:id`
  ///
  /// - [id]: 更新対象のメディアID
  /// - [thumbnail]: カスタムサムネイル画像のバイト列
  /// - [thumbnailFilename]: サムネイルのファイル名（[thumbnail] 指定時は必須）
  /// - [description]: 代替テキスト（スクリーンリーダー用）
  /// - [focus]: フォーカルポイント（`"x,y"` 形式、各値は -1.0〜1.0）
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonMediaAttachment> update(
    String id, {
    Uint8List? thumbnail,
    String? thumbnailFilename,
    String? description,
    String? focus,
  }) async {
    try {
      final Object body;
      if (thumbnail != null) {
        body = FormData.fromMap(<String, dynamic>{
          'thumbnail': MultipartFile.fromBytes(
            thumbnail,
            filename: thumbnailFilename ?? 'thumbnail',
          ),
          'description': ?description,
          'focus': ?focus,
        });
      } else {
        body = <String, dynamic>{
          'description': ?description,
          'focus': ?focus,
        };
      }

      final response = await _http.dio.put<Map<String, dynamic>>(
        '/api/v1/media/$id',
        data: body,
      );

      final data = response.data;
      if (data == null) {
        throw const MastodonApiException(
          statusCode: 0,
          message: 'メディアAPIからのレスポンスが空です',
        );
      }

      return MastodonMediaAttachment.fromJson(data);
    } on MastodonException {
      rethrow;
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// メディア添付ファイルを削除
  ///
  /// `DELETE /api/v1/media/:id`
  ///
  /// まだステータスに紐づけられていないメディアのみ削除可能
  ///
  /// - [id]: 削除対象のメディアID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<void> delete(String id) async {
    try {
      await _http.dio.delete<void>(
        '/api/v1/media/$id',
      );
    } on MastodonException {
      rethrow;
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// `url`フィールドが非nullになるまでポーリングし、完了後の[MastodonMediaAttachment]を返す
  Future<MastodonMediaAttachment> _pollUntilReady(String mediaId) async {
    for (var i = 0; i < _maxPollAttempts; i++) {
      if (i > 0) {
        await Future<void>.delayed(_pollInterval);
      }
      try {
        final response = await _http.dio.get<Map<String, dynamic>>(
          '/api/v1/media/$mediaId',
        );
        final data = response.data;
        if (data != null) {
          final attachment = MastodonMediaAttachment.fromJson(data);
          if (attachment.url != null) {
            return attachment;
          }
        }
      } on DioException catch (e) {
        throw convertDioException(e);
      }
    }
    throw MastodonMediaProcessingTimeoutException(mediaId: mediaId);
  }
}
