import 'package:dio/dio.dart';

import '../exception/mastodon_exception.dart';

/// [DioException]を[MastodonException]に変換する
///
/// 全APIクラスで共通して使用する内部ユーティリティ
MastodonException convertDioException(DioException e, [String? endpoint]) {
  final statusCode = e.response?.statusCode;

  if (statusCode != null) {
    final serverMessage = _extractMessage(e.response?.data);
    final retryAfter = _parseRetryAfter(e.response);
    return switch (statusCode) {
      401 => MastodonUnauthorizedException(
        message: serverMessage ?? 'Unauthorized',
        endpoint: endpoint,
        raw: e,
      ),
      403 => MastodonForbiddenException(
        message: serverMessage ?? 'Forbidden',
        endpoint: endpoint,
        raw: e,
      ),
      404 => MastodonNotFoundException(
        message: serverMessage ?? 'Not found',
        endpoint: endpoint,
        raw: e,
      ),
      422 => MastodonValidationException(
        serverMessage: serverMessage,
        endpoint: endpoint,
        raw: e,
      ),
      429 => MastodonRateLimitException(
        message: serverMessage ?? 'Rate limited',
        endpoint: endpoint,
        raw: e,
        retryAfter: retryAfter,
      ),
      >= 500 => MastodonServerException(
        statusCode: statusCode,
        message: serverMessage ?? 'Server error',
        endpoint: endpoint,
        raw: e,
      ),
      _ => MastodonApiException(
        statusCode: statusCode,
        message: serverMessage ?? e.message ?? 'Unknown API error',
        endpoint: endpoint,
        raw: e,
      ),
    };
  }

  // ネットワークエラー（タイムアウト・接続不可など）
  return MastodonNetworkException(
    message: e.message ?? 'Network error',
    endpoint: endpoint,
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

Duration? _parseRetryAfter(Response<dynamic>? response) {
  final ra = response?.headers.value('retry-after');
  if (ra != null) {
    final seconds = int.tryParse(ra.trim());
    if (seconds != null) {
      return Duration(seconds: seconds);
    }
  }
  return null;
}
