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

  group('convertDioException - retry-after header (429)', () {
    test('parses a numeric retry-after header into a Duration', () {
      final result = convertDioException(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['60'],
          },
        ),
      );
      final rateLimit = result as MastodonRateLimitException;
      expect(rateLimit.retryAfter, const Duration(seconds: 60));
    });

    test('retryAfter is null when the header is absent', () {
      final result = convertDioException(_errorWithStatus(429));
      expect((result as MastodonRateLimitException).retryAfter, isNull);
    });

    test('retryAfter is null when the header is not a valid integer', () {
      final result = convertDioException(
        _errorWithStatus(
          429,
          headers: {
            'retry-after': ['Wed, 21 Oct 2026 07:28:00 GMT'],
          },
        ),
      );
      expect((result as MastodonRateLimitException).retryAfter, isNull);
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
