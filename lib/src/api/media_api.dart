import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
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

    return _pollUntilReady(attachment.id);
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
      return await _http.sendRaw<Map<String, dynamic>>(
        '/api/v2/media',
        method: 'POST',
        data: formData,
      );
    } on MastodonApiException catch (e) {
      if (!_v2FallbackStatusCodes.contains(e.statusCode)) rethrow;
      final formData = FormData.fromMap(<String, dynamic>{
        'file': MultipartFile.fromBytes(bytes, filename: filename),
        if (description != null && description.isNotEmpty)
          'description': description,
      });
      return _http.sendRaw<Map<String, dynamic>>(
        '/api/v1/media',
        method: 'POST',
        data: formData,
      );
    }
  }

  /// 指定されたIDのメディア添付ファイルを取得する
  ///
  /// `GET /api/v1/media/:id`
  ///
  /// 非同期アップロードの処理状況を確認する際などに使用する。
  /// 処理中の場合は `url` フィールドが `null` となる。
  ///
  /// - [id]: 取得するメディアのID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonMediaAttachment> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/media/$id',
    );
    if (data == null) {
      throw const MastodonApiException(
        statusCode: 0,
        message: 'メディアAPIからのレスポンスが空です',
      );
    }
    return MastodonMediaAttachment.fromJson(data);
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

    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/media/$id',
      method: 'PUT',
      data: body,
    );

    if (data == null) {
      throw const MastodonApiException(
        statusCode: 0,
        message: 'メディアAPIからのレスポンスが空です',
      );
    }

    return MastodonMediaAttachment.fromJson(data);
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
    await _http.send<void>(
      '/api/v1/media/$id',
      method: 'DELETE',
    );
  }

  /// `url`フィールドが非nullになるまでポーリングし、完了後の[MastodonMediaAttachment]を返す
  Future<MastodonMediaAttachment> _pollUntilReady(String mediaId) async {
    for (var i = 0; i < _maxPollAttempts; i++) {
      if (i > 0) {
        await Future<void>.delayed(_pollInterval);
      }
      final data = await _http.send<Map<String, dynamic>>(
        '/api/v1/media/$mediaId',
      );
      if (data != null) {
        final attachment = MastodonMediaAttachment.fromJson(data);
        if (attachment.url != null) {
          return attachment;
        }
      }
    }
    throw MastodonMediaProcessingTimeoutException(mediaId: mediaId);
  }
}
