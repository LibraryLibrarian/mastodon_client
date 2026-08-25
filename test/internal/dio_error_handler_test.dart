import 'package:dio/dio.dart';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/internal/dio_error_handler.dart';
import 'package:test/test.dart';

/// [statusCode] と [data] を持つ [DioException] を組み立てる。
///
/// [headers] を渡すとレスポンスヘッダー(例: retry-after)を模擬できる。
DioException _errorWithStatus(
  int statusCode, {
  dynamic data,
  Map<String, List<String>>? headers,
}) {
  final options = RequestOptions(path: '/api/v1/statuses');
  return DioException(
    requestOptions: options,
    response: Response<dynamic>(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
      headers: Headers.fromMap(headers ?? const {}),
    ),
    type: DioExceptionType.badResponse,
  );
}

DioException _networkError(DioExceptionType type, {String? message}) {
  return DioException(
    requestOptions: RequestOptions(path: '/api/v1/statuses'),
    type: type,
    message: message,
  );
}

void main() {
  group('convertDioException - status code mapping', () {
    test('401 maps to MastodonUnauthorizedException', () {
      final result = convertDioException(_errorWithStatus(401));
      expect(result, isA<MastodonUnauthorizedException>());
      expect((result as MastodonApiException).statusCode, 401);
    });

    test('403 maps to MastodonForbiddenException', () {
      final result = convertDioException(_errorWithStatus(403));
      expect(result, isA<MastodonForbiddenException>());
    });

    test('404 maps to MastodonNotFoundException', () {
      final result = convertDioException(_errorWithStatus(404));
      expect(result, isA<MastodonNotFoundException>());
    });

    test('422 maps to MastodonValidationException', () {
      final result = convertDioException(_errorWithStatus(422));
      expect(result, isA<MastodonValidationException>());
    });

    test('429 maps to MastodonRateLimitException', () {
      final result = convertDioException(_errorWithStatus(429));
      expect(result, isA<MastodonRateLimitException>());
    });

    test('500 maps to MastodonServerException with statusCode preserved', () {
      final result = convertDioException(_errorWithStatus(500));
      expect(result, isA<MastodonServerException>());
      expect((result as MastodonServerException).statusCode, 500);
    });

    test('503 (any 5xx) maps to MastodonServerException', () {
      final result = convertDioException(_errorWithStatus(503));
      expect(result, isA<MastodonServerException>());
      expect((result as MastodonServerException).statusCode, 503);
    });

    test('unmapped status codes fall back to MastodonApiException', () {
      final result = convertDioException(_errorWithStatus(418));
      expect(result, isA<MastodonApiException>());
      expect(result, isNot(isA<MastodonUnauthorizedException>()));
      expect((result as MastodonApiException).statusCode, 418);
    });
  });

  group('convertDioException - error body parsing', () {
    test('extracts message from {"error": "..."} response body', () {
      final result = convertDioException(
        _errorWithStatus(401, data: {'error': 'The access token is invalid'}),
      );
      expect(
        (result as MastodonApiException).message,
        'The access token is invalid',
      );
    });

    test('422 carries the raw server message in serverMessage', () {
      final result =
          convertDioException(
                _errorWithStatus(
                  422,
                  data: {'error': 'Validation failed: Text is too long'},
                ),
              )
              as MastodonValidationException;
      expect(result.serverMessage, 'Validation failed: Text is too long');
    });

    test('falls back to the default message when error is not a string', () {
      final result = convertDioException(
        _errorWithStatus(401, data: {'error': 404}),
      );
      expect((result as MastodonApiException).message, 'Unauthorized');
    });

    test('falls back to the default message when data is not a Map', () {
      final result = convertDioException(
        _errorWithStatus(500, data: '<html>Internal Server Error</html>'),
      );
      expect((result as MastodonApiException).message, 'Server error');
    });

    test('falls back to the default message when data is null', () {
      final result = convertDioException(_errorWithStatus(404));
      expect((result as MastodonApiException).message, 'Not found');
    });

    test('unmapped status codes fall back to the DioException message when '
        'no server message is present', () {
      final options = RequestOptions(path: '/api/v1/statuses');
      final exception = DioException(
        requestOptions: options,
        response: Response<dynamic>(requestOptions: options, statusCode: 418),
        type: DioExceptionType.badResponse,
        message: "I'm a teapot",
      );
      final result = convertDioException(exception);
      expect((result as MastodonApiException).message, "I'm a teapot");
    });
  });

  group('convertDioException - rate-limit headers (429)', () {
    final now = DateTime.utc(2026, 8, 26, 12);

    test('parses a numeric retry-after header into a Duration', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['60'],
          },
        ),
        now,
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(rateLimit.retryAfter, const Duration(seconds: 60));
    });

    test('retryAfter is null when rate-limit headers are absent', () {
      final result = convertDioExceptionAt(_errorWithStatus(429), now);
      expect((result as MastodonRateLimitException).retryAfter, isNull);
    });

    test('parses an IMF-fixdate retry-after header', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['Wed, 26 Aug 2026 12:01:30 GMT'],
          },
        ),
        now,
      );
      expect(
        (result as MastodonRateLimitException).retryAfter,
        const Duration(seconds: 90),
      );
    });

    for (final retryAfter in [
      'Wednesday, 26-Aug-26 12:01:30 GMT',
      'Wed Aug 26 12:01:30 2026',
    ]) {
      test('parses the obsolete HTTP-date form: $retryAfter', () {
        final result = convertDioExceptionAt(
          _errorWithStatus(
            429,
            headers: {
              'retry-after': [retryAfter],
            },
          ),
          now,
        );
        expect(
          (result as MastodonRateLimitException).retryAfter,
          const Duration(seconds: 90),
        );
      });
    }

    test('keeps an RFC850 date exactly 50 years in the future', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['Wednesday, 26-Aug-76 12:00:00 GMT'],
          },
        ),
        now,
      );
      expect(
        (result as MastodonRateLimitException).retryAfter,
        DateTime.utc(2076, 8, 26, 12).difference(now),
      );
    });

    test(
      'moves an RFC850 instant over the 50-year boundary back a century',
      () {
        final result = convertDioExceptionAt(
          _errorWithStatus(
            429,
            headers: {
              'retry-after': ['Thursday, 26-Aug-76 12:00:01 GMT'],
            },
          ),
          now,
        );
        expect(
          (result as MastodonRateLimitException).retryAfter,
          Duration.zero,
        );
      },
    );

    test('moves an RFC850 date over the 50-year boundary back a century', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['Friday, 27-Aug-76 12:00:00 GMT'],
          },
        ),
        now,
      );
      expect((result as MastodonRateLimitException).retryAfter, Duration.zero);
    });

    for (final retryAfter in [
      'Foo, 26 Aug 2026 12:01:00 GMT',
      'Thu, 26 Aug 2026 12:01:00 GMT',
    ]) {
      test(
        'falls back when retry-after has an invalid weekday: $retryAfter',
        () {
          final result = convertDioExceptionAt(
            _errorWithStatus(
              429,
              headers: {
                'retry-after': [retryAfter],
                'x-ratelimit-reset': ['2026-08-26T12:02:00Z'],
              },
            ),
            now,
          );
          expect(
            (result as MastodonRateLimitException).retryAfter,
            const Duration(minutes: 2),
          );
        },
      );
    }

    test('falls back to x-ratelimit-reset when retry-after is invalid', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['invalid'],
            'x-ratelimit-reset': ['2026-08-26T12:02:00.000000Z'],
          },
        ),
        now,
      );
      expect(
        (result as MastodonRateLimitException).retryAfter,
        const Duration(minutes: 2),
      );
    });

    test('parses Mastodon rate-limit metadata', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'x-ratelimit-limit': ['300'],
            'x-ratelimit-remaining': ['0'],
            'x-ratelimit-reset': ['2026-08-26T12:02:00.123456Z'],
          },
        ),
        now,
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(
        rateLimit.retryAfter,
        const Duration(minutes: 2, microseconds: 123456),
      );
      expect(rateLimit.limit, 300);
      expect(rateLimit.remaining, 0);
      expect(rateLimit.resetAt, DateTime.utc(2026, 8, 26, 12, 2, 0, 123, 456));
    });

    test('accepts an explicit offset in x-ratelimit-reset', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'x-ratelimit-reset': ['2026-08-26T21:02:00+09:00'],
          },
        ),
        now,
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(rateLimit.retryAfter, const Duration(minutes: 2));
      expect(rateLimit.resetAt, DateTime.utc(2026, 8, 26, 12, 2));
    });

    for (final reset in ['2026-08-26T12:02:00', '2026-02-30T12:02:00Z']) {
      test('rejects a non-strict x-ratelimit-reset value: $reset', () {
        final result = convertDioExceptionAt(
          _errorWithStatus(
            429,
            headers: {
              'x-ratelimit-reset': [reset],
            },
          ),
          now,
        );
        final rateLimit = result as MastodonRateLimitException;
        expect(rateLimit.retryAfter, isNull);
        expect(rateLimit.resetAt, isNull);
      });
    }

    test('uses retry-after when x-ratelimit-reset is not strict ISO', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['30'],
            'x-ratelimit-reset': ['2026-08-26T12:02:00'],
          },
        ),
        now,
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(rateLimit.retryAfter, const Duration(seconds: 30));
      expect(rateLimit.resetAt, isNull);
    });

    test('clamps a past x-ratelimit-reset to zero', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'x-ratelimit-reset': ['2026-08-26T11:59:59.999999Z'],
          },
        ),
        now,
      );
      expect((result as MastodonRateLimitException).retryAfter, Duration.zero);
    });

    test('prefers a valid retry-after over x-ratelimit-reset', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['60'],
            'x-ratelimit-reset': ['2026-08-26T12:02:00Z'],
          },
        ),
        now,
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(rateLimit.retryAfter, const Duration(minutes: 1));
      expect(rateLimit.resetAt, DateTime.utc(2026, 8, 26, 12, 2));
    });

    test('ignores malformed rate-limit metadata', () {
      final result = convertDioExceptionAt(
        _errorWithStatus(
          429,
          headers: {
            'x-ratelimit-limit': ['many'],
            'x-ratelimit-remaining': ['-1'],
            'x-ratelimit-reset': ['later'],
          },
        ),
        now,
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(rateLimit.retryAfter, isNull);
      expect(rateLimit.limit, isNull);
      expect(rateLimit.remaining, isNull);
      expect(rateLimit.resetAt, isNull);
    });
  });

  group('convertDioException - network errors (no response)', () {
    test('connectionError maps to MastodonNetworkException', () {
      final result = convertDioException(
        _networkError(DioExceptionType.connectionError),
      );
      expect(result, isA<MastodonNetworkException>());
    });

    test('connectionTimeout maps to MastodonNetworkException', () {
      final result = convertDioException(
        _networkError(DioExceptionType.connectionTimeout),
      );
      expect(result, isA<MastodonNetworkException>());
    });

    test('receiveTimeout maps to MastodonNetworkException', () {
      final result = convertDioException(
        _networkError(DioExceptionType.receiveTimeout),
      );
      expect(result, isA<MastodonNetworkException>());
    });

    test('cancel maps to MastodonNetworkException', () {
      final result = convertDioException(
        _networkError(DioExceptionType.cancel),
      );
      expect(result, isA<MastodonNetworkException>());
    });

    test('preserves the original DioException as cause', () {
      final original = _networkError(
        DioExceptionType.connectionError,
        message: 'Failed host lookup',
      );
      final result = convertDioException(original) as MastodonNetworkException;
      expect(result.cause, same(original));
      expect(result.message, 'Failed host lookup');
    });

    test('endpoint is carried through to the resulting exception', () {
      final result = convertDioException(
        _networkError(DioExceptionType.connectionError),
        '/api/v1/timelines/home',
      );
      expect(
        (result as MastodonNetworkException).endpoint,
        '/api/v1/timelines/home',
      );
    });
  });
}
