import 'package:dio/dio.dart';

import '../exception/mastodon_exception.dart';

/// Converts a [DioException] to a [MastodonException].
///
/// Internal utility used by all API classes.
MastodonException convertDioException(DioException e, [String? endpoint]) {
  return convertDioExceptionAt(e, DateTime.now().toUtc(), endpoint);
}

/// Converts a [DioException] using [now] as the current time.
///
/// This variant keeps date-based rate-limit parsing deterministic in tests.
MastodonException convertDioExceptionAt(
  DioException e,
  DateTime now, [
  String? endpoint,
]) {
  final statusCode = e.response?.statusCode;

  if (statusCode != null) {
    final serverMessage = _extractMessage(e.response?.data);
    final rateLimit = _parseRateLimit(e.response, now.toUtc());
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
        retryAfter: rateLimit.retryAfter,
        limit: rateLimit.limit,
        remaining: rateLimit.remaining,
        resetAt: rateLimit.resetAt,
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

({Duration? retryAfter, int? limit, int? remaining, DateTime? resetAt})
_parseRateLimit(Response<dynamic>? response, DateTime now) {
  final headers = response?.headers;
  final resetAt = DateTime.tryParse(
    headers?.value('x-ratelimit-reset')?.trim() ?? '',
  )?.toUtc();
  final retryAfter = _parseRetryAfter(headers?.value('retry-after'), now);

  return (
    retryAfter: retryAfter ?? _durationUntil(resetAt, now),
    limit: _parseNonNegativeInt(headers?.value('x-ratelimit-limit')),
    remaining: _parseNonNegativeInt(headers?.value('x-ratelimit-remaining')),
    resetAt: resetAt,
  );
}

Duration? _parseRetryAfter(String? value, DateTime now) {
  if (value == null) return null;

  final seconds = _parseNonNegativeInt(value);
  if (seconds != null) return Duration(seconds: seconds);

  return _durationUntil(_tryParseHttpDate(value, now), now);
}

int? _parseNonNegativeInt(String? value) {
  final parsed = int.tryParse(value?.trim() ?? '');
  return parsed != null && parsed >= 0 ? parsed : null;
}

Duration? _durationUntil(DateTime? target, DateTime now) {
  if (target == null) return null;
  final difference = target.toUtc().difference(now.toUtc());
  return difference.isNegative ? Duration.zero : difference;
}

DateTime? _tryParseHttpDate(String value, DateTime now) {
  final trimmed = value.trim();
  final imfFixdate = RegExp(
    r'^[A-Za-z]{3}, (\d{2}) ([A-Za-z]{3}) (\d{4}) '
    r'(\d{2}):(\d{2}):(\d{2}) GMT$',
  ).firstMatch(trimmed);
  if (imfFixdate != null) {
    return _buildHttpDate(
      year: int.parse(imfFixdate[3]!),
      month: imfFixdate[2]!,
      day: int.parse(imfFixdate[1]!),
      hour: int.parse(imfFixdate[4]!),
      minute: int.parse(imfFixdate[5]!),
      second: int.parse(imfFixdate[6]!),
    );
  }

  final rfc850Date = RegExp(
    r'^[A-Za-z]+, (\d{2})-([A-Za-z]{3})-(\d{2}) '
    r'(\d{2}):(\d{2}):(\d{2}) GMT$',
  ).firstMatch(trimmed);
  if (rfc850Date != null) {
    var year = 2000 + int.parse(rfc850Date[3]!);
    if (year - now.year > 50) year -= 100;
    return _buildHttpDate(
      year: year,
      month: rfc850Date[2]!,
      day: int.parse(rfc850Date[1]!),
      hour: int.parse(rfc850Date[4]!),
      minute: int.parse(rfc850Date[5]!),
      second: int.parse(rfc850Date[6]!),
    );
  }

  final asctimeDate = RegExp(
    r'^[A-Za-z]{3} ([A-Za-z]{3}) +([0-9]{1,2}) '
    r'(\d{2}):(\d{2}):(\d{2}) (\d{4})$',
  ).firstMatch(trimmed);
  if (asctimeDate == null) return null;
  return _buildHttpDate(
    year: int.parse(asctimeDate[6]!),
    month: asctimeDate[1]!,
    day: int.parse(asctimeDate[2]!),
    hour: int.parse(asctimeDate[3]!),
    minute: int.parse(asctimeDate[4]!),
    second: int.parse(asctimeDate[5]!),
  );
}

DateTime? _buildHttpDate({
  required int year,
  required String month,
  required int day,
  required int hour,
  required int minute,
  required int second,
}) {
  const months = {
    'Jan': 1,
    'Feb': 2,
    'Mar': 3,
    'Apr': 4,
    'May': 5,
    'Jun': 6,
    'Jul': 7,
    'Aug': 8,
    'Sep': 9,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12,
  };
  final monthNumber = months[month];
  if (monthNumber == null || hour > 23 || minute > 59 || second > 59) {
    return null;
  }

  final result = DateTime.utc(year, monthNumber, day, hour, minute, second);
  if (result.year != year || result.month != monthNumber || result.day != day) {
    return null;
  }
  return result;
}
