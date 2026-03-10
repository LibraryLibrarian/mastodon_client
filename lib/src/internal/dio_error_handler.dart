import 'package:dio/dio.dart';

import '../exception/mastodon_exception.dart';

/// [DioException]を[MastodonException]に変換する
///
/// 全APIクラスで共通して使用する内部ユーティリティ
MastodonException convertDioException(DioException e) {
  final statusCode = e.response?.statusCode;

  if (statusCode != null) {
    final serverMessage = _extractMessage(e.response?.data);
    return switch (statusCode) {
      401 => MastodonUnauthorizedException(
        message: serverMessage ?? 'Unauthorized',
      ),
      403 => MastodonForbiddenException(
        message: serverMessage ?? 'Forbidden',
      ),
      404 => MastodonNotFoundException(
        message: serverMessage ?? 'Not found',
      ),
      422 => MastodonValidationException(
        serverMessage: serverMessage,
      ),
      >= 500 => MastodonServerException(
        statusCode: statusCode,
        message: serverMessage ?? 'Server error',
      ),
      _ => MastodonApiException(
        statusCode: statusCode,
        message: serverMessage ?? e.message ?? 'Unknown API error',
      ),
    };
  }

  // ネットワークエラー（タイムアウト・接続不可など）
  return MastodonNetworkException(
    message: e.message ?? 'Network error',
    cause: e,
  );
}

String? _extractMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    final error = data['error'];
    if (error is String) return error;
  }
  return null;
}
