import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../models/mastodon_media_attachment.dart';

/// Media upload API.
class MediaApi {
  const MediaApi(this._http);

  final MastodonHttpClient _http;

  static const Set<int> _v2FallbackStatusCodes = <int>{404, 405, 501};
  static const int _maxPollAttempts = 8;
  static const Duration _pollInterval = Duration(milliseconds: 500);

  /// Uploads media and returns a [MastodonMediaAttachment].
  ///
  /// Prefers `POST /api/v2/media` and falls back to `POST /api/v1/media`
  /// for unsupported servers (404 / 405 / 501).
  ///
  /// When the server returns async processing (HTTP 202), polls
  /// `GET /api/v1/media/{id}` up to [_maxPollAttempts] times until
  /// the `url` field becomes non-null.
  ///
  /// Throws [MastodonMediaProcessingTimeoutException] on timeout.
  ///
  /// [bytes] is the raw file data and [filename] is the multipart filename.
  /// [description] provides optional alt text. Supply [thumbnail] with
  /// an optional [thumbnailFilename] to set a custom thumbnail. [focus]
  /// is a focal point string in `"x,y"` format (each value between
  /// -1.0 and 1.0).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonMediaAttachment> upload(
    Uint8List bytes,
    String filename, {
    String? description,
    Uint8List? thumbnail,
    String? thumbnailFilename,
    String? focus,
  }) async {
    final response = await _uploadWithFallback(
      bytes: bytes,
      filename: filename,
      description: description,
      thumbnail: thumbnail,
      thumbnailFilename: thumbnailFilename,
      focus: focus,
    );

    final data = response.data;
    if (data == null) {
      throw const MastodonApiException(
        statusCode: 0,
        message: 'Empty response from media API',
      );
    }

    final attachment = MastodonMediaAttachment.fromJson(data);

    final shouldPoll = response.statusCode == 202 && attachment.url == null;
    if (!shouldPoll) {
      return attachment;
    }

    return _pollUntilReady(attachment.id);
  }

  /// Tries v2 first, falls back to v1 for unsupported servers.
  Future<Response<Map<String, dynamic>>> _uploadWithFallback({
    required Uint8List bytes,
    required String filename,
    String? description,
    Uint8List? thumbnail,
    String? thumbnailFilename,
    String? focus,
  }) async {
    FormData buildFormData() => FormData.fromMap(<String, dynamic>{
      'file': MultipartFile.fromBytes(bytes, filename: filename),
      if (description != null && description.isNotEmpty)
        'description': description,
      if (thumbnail != null)
        'thumbnail': MultipartFile.fromBytes(
          thumbnail,
          filename: thumbnailFilename ?? 'thumbnail',
        ),
      if (focus != null && focus.isNotEmpty) 'focus': focus,
    });

    try {
      return await _http.sendRaw<Map<String, dynamic>>(
        '/api/v2/media',
        method: 'POST',
        data: buildFormData(),
      );
    } on MastodonApiException catch (e) {
      if (!_v2FallbackStatusCodes.contains(e.statusCode)) rethrow;
      return _http.sendRaw<Map<String, dynamic>>(
        '/api/v1/media',
        method: 'POST',
        data: buildFormData(),
      );
    }
  }

  /// Fetches a media attachment by its ID.
  ///
  /// `GET /api/v1/media/:id`
  ///
  /// Used to check the processing status of async uploads.
  /// The `url` field is `null` while processing is in progress.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonMediaAttachment> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/media/$id',
    );
    if (data == null) {
      throw const MastodonApiException(
        statusCode: 0,
        message: 'Empty response from media API',
      );
    }
    return MastodonMediaAttachment.fromJson(data);
  }

  /// Updates the attributes of a media attachment and returns a
  /// [MastodonMediaAttachment].
  ///
  /// `PUT /api/v1/media/:id`
  ///
  /// [thumbnail] replaces the thumbnail image; when provided, supply
  /// [thumbnailFilename] as the multipart filename. [description] is the
  /// alt text for screen readers. [focus] is a focal point string in
  /// `"x,y"` format (each value between -1.0 and 1.0).
  ///
  /// Throws a `MastodonException` on failure.
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
        message: 'Empty response from media API',
      );
    }

    return MastodonMediaAttachment.fromJson(data);
  }

  /// Deletes a media attachment.
  ///
  /// `DELETE /api/v1/media/:id`
  ///
  /// Only media not yet attached to a status can be deleted.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/media/$id',
      method: 'DELETE',
    );
  }

  /// Polls until the `url` field becomes non-null and returns the completed
  /// [MastodonMediaAttachment].
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
