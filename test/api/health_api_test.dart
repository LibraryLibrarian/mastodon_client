import 'package:mastodon_client/src/api/health_api.dart';
import 'package:mastodon_client/src/client/mastodon_http_client.dart';
import 'package:test/test.dart';

void main() {
  group('HealthApi.checkStreaming', () {
    test('requests the plain-text streaming health endpoint', () async {
      final http = _FakeMastodonHttpClient('OK');
      final api = HealthApi(http);

      expect(await api.checkStreaming(), isTrue);
      expect(http.path, '/api/v1/streaming/health');
      expect(http.responseType, String);
    });

    test('returns false for an unexpected response body', () async {
      final api = HealthApi(_FakeMastodonHttpClient('not OK'));

      expect(await api.checkStreaming(), isFalse);
    });

    for (final body in ['OK\n', ' \tOK\r\n']) {
      test(
        'accepts surrounding whitespace in ${body.escapeForTestName()}',
        () async {
          final api = HealthApi(_FakeMastodonHttpClient(body));

          expect(await api.checkStreaming(), isTrue);
        },
      );
    }
  });
}

extension on String {
  String escapeForTestName() => replaceAll('\n', r'\n').replaceAll('\r', r'\r');
}

class _FakeMastodonHttpClient extends MastodonHttpClient {
  _FakeMastodonHttpClient(this.response)
    : super(baseUrl: 'https://mastodon.example', enableLog: false);

  final Object? response;
  String? path;
  Type? responseType;

  @override
  Future<T?> send<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    this.path = path;
    responseType = T;
    return response as T?;
  }
}
