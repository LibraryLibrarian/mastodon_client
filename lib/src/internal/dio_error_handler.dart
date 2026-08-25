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
  final resetAt = _tryParseIsoTimestamp(headers?.value('x-ratelimit-reset'));
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

DateTime? _tryParseIsoTimestamp(String? value) {
  if (value == null) return null;
  final trimmed = value.trim();
  final match = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})T'
    r'(\d{2}):(\d{2}):(\d{2})(?:\.\d+)?'
    r'(Z|[+-](\d{2}):(\d{2}))$',
  ).firstMatch(trimmed);
  if (match == null) return null;

  final year = int.parse(match[1]!);
  final month = int.parse(match[2]!);
  final day = int.parse(match[3]!);
  final hour = int.parse(match[4]!);
  final minute = int.parse(match[5]!);
  final second = int.parse(match[6]!);
  final offsetHour = int.tryParse(match[8] ?? '') ?? 0;
  final offsetMinute = int.tryParse(match[9] ?? '') ?? 0;
  if (!_isValidDateTime(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
      ) ||
      offsetHour > 23 ||
      offsetMinute > 59) {
    return null;
  }

  return DateTime.tryParse(trimmed)?.toUtc();
}

DateTime? _tryParseHttpDate(String value, DateTime now) {
  final trimmed = value.trim();
  final imfFixdate = RegExp(
    r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), '
    r'(\d{2}) ([A-Za-z]{3}) (\d{4}) '
    r'(\d{2}):(\d{2}):(\d{2}) GMT$',
  ).firstMatch(trimmed);
  if (imfFixdate != null) {
    return _buildHttpDate(
      weekday: imfFixdate[1]!,
      year: int.parse(imfFixdate[4]!),
      month: imfFixdate[3]!,
      day: int.parse(imfFixdate[2]!),
      hour: int.parse(imfFixdate[5]!),
      minute: int.parse(imfFixdate[6]!),
      second: int.parse(imfFixdate[7]!),
    );
  }

  final rfc850Date = RegExp(
    r'^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday), '
    r'(\d{2})-([A-Za-z]{3})-(\d{2}) '
    r'(\d{2}):(\d{2}):(\d{2}) GMT$',
  ).firstMatch(trimmed);
  if (rfc850Date != null) {
    final currentCentury = now.year - (now.year % 100);
    var year = currentCentury + int.parse(rfc850Date[4]!);
    var result = _buildHttpDate(
      year: year,
      month: rfc850Date[3]!,
      day: int.parse(rfc850Date[2]!),
      hour: int.parse(rfc850Date[5]!),
      minute: int.parse(rfc850Date[6]!),
      second: int.parse(rfc850Date[7]!),
    );
    if (result == null) return null;
    if (result.isAfter(_addYears(now, 50))) {
      year -= 100;
      result = _buildHttpDate(
        year: year,
        month: rfc850Date[3]!,
        day: int.parse(rfc850Date[2]!),
        hour: int.parse(rfc850Date[5]!),
        minute: int.parse(rfc850Date[6]!),
        second: int.parse(rfc850Date[7]!),
      );
    }
    return _hasMatchingWeekday(result, rfc850Date[1]!) ? result : null;
  }

  final asctimeDate = RegExp(
    r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun) ([A-Za-z]{3}) +([0-9]{1,2}) '
    r'(\d{2}):(\d{2}):(\d{2}) (\d{4})$',
  ).firstMatch(trimmed);
  if (asctimeDate == null) return null;
  return _buildHttpDate(
    weekday: asctimeDate[1]!,
    year: int.parse(asctimeDate[7]!),
    month: asctimeDate[2]!,
    day: int.parse(asctimeDate[3]!),
    hour: int.parse(asctimeDate[4]!),
    minute: int.parse(asctimeDate[5]!),
    second: int.parse(asctimeDate[6]!),
  );
}

DateTime? _buildHttpDate({
  String? weekday,
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
  if (monthNumber == null ||
      !_isValidDateTime(
        year: year,
        month: monthNumber,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
      )) {
    return null;
  }

  final result = DateTime.utc(year, monthNumber, day, hour, minute, second);
  return weekday == null || _hasMatchingWeekday(result, weekday)
      ? result
      : null;
}

bool _isValidDateTime({
  required int year,
  required int month,
  required int day,
  required int hour,
  required int minute,
  required int second,
}) {
  if (month < 1 ||
      month > 12 ||
      day < 1 ||
      hour > 23 ||
      minute > 59 ||
      second > 59) {
    return false;
  }
  final result = DateTime.utc(year, month, day, hour, minute, second);
  return result.year == year && result.month == month && result.day == day;
}

bool _hasMatchingWeekday(DateTime? date, String weekday) {
  if (date == null) return false;
  const weekdays = {
    'Mon': DateTime.monday,
    'Monday': DateTime.monday,
    'Tue': DateTime.tuesday,
    'Tuesday': DateTime.tuesday,
    'Wed': DateTime.wednesday,
    'Wednesday': DateTime.wednesday,
    'Thu': DateTime.thursday,
    'Thursday': DateTime.thursday,
    'Fri': DateTime.friday,
    'Friday': DateTime.friday,
    'Sat': DateTime.saturday,
    'Saturday': DateTime.saturday,
    'Sun': DateTime.sunday,
    'Sunday': DateTime.sunday,
  };
  return weekdays[weekday] == date.weekday;
}

DateTime _addYears(DateTime date, int years) {
  final targetYear = date.year + years;
  final lastDayOfMonth = DateTime.utc(targetYear, date.month + 1, 0).day;
  final targetDay = date.day > lastDayOfMonth ? lastDayOfMonth : date.day;
  return DateTime.utc(
    targetYear,
    date.month,
    targetDay,
    date.hour,
    date.minute,
    date.second,
    date.millisecond,
    date.microsecond,
  );
}
