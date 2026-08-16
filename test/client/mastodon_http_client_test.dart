import 'package:mastodon_client/src/client/mastodon_http_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonHttpClient configuration', () {
    test('retains values while preserving Dio options', () {
      final client = MastodonHttpClient(
        baseUrl: 'https://mastodon.example',
        accessToken: 'test-token',
        enableLog: false,
      );

      expect(client.baseUrl, 'https://mastodon.example');
      expect(client.accessToken, 'test-token');
      expect(client.enableLog, isFalse);
      expect(client.dio.options.baseUrl, 'https://mastodon.example');
      expect(client.dio.options.headers['Authorization'], 'Bearer test-token');
    });

    test('retains a null access token without adding authorization', () {
      final client = MastodonHttpClient(
        baseUrl: 'https://mastodon.example',
        enableLog: true,
      );

      expect(client.accessToken, isNull);
      expect(client.enableLog, isTrue);
      expect(client.dio.options.headers, isNot(contains('Authorization')));
    });
  });
}
