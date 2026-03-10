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
