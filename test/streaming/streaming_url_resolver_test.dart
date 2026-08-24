import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/streaming/streaming_url_resolver.dart';
import 'package:test/test.dart';

void main() {
  const resolver = StreamingUrlResolver();

  group('StreamingUrlResolver source selection', () {
    test('prefers the v2 URL and supports a separate host', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2('wss://v2-stream.example'),
        instanceV1: _v1('wss://v1-stream.example'),
      );

      expect(uri, Uri.parse('wss://v2-stream.example/api/v1/streaming'));
    });

    test('falls back to the v1 URL when v2 has no URL', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2(null),
        instanceV1: _v1('wss://v1-stream.example'),
      );

      expect(uri, Uri.parse('wss://v1-stream.example/api/v1/streaming'));
    });

    test('falls back to the REST host when instance URLs are absent', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example:8443/rest/path',
        instance: _v2(null),
        instanceV1: _v1(null),
      );

      expect(uri, Uri.parse('wss://rest.example:8443/api/v1/streaming'));
    });

    test('treats blank instance URLs as absent', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2('  '),
        instanceV1: _v1(' streaming.example '),
      );

      expect(uri, Uri.parse('wss://streaming.example/api/v1/streaming'));
    });
  });

  group('StreamingUrlResolver normalization', () {
    test('converts HTTP schemes and preserves WebSocket schemes', () {
      final cases = <String, String>{
        'http://stream.example': 'ws://stream.example/api/v1/streaming',
        'https://stream.example': 'wss://stream.example/api/v1/streaming',
        'ws://stream.example': 'ws://stream.example/api/v1/streaming',
        'wss://stream.example': 'wss://stream.example/api/v1/streaming',
      };

      for (final entry in cases.entries) {
        expect(
          resolver.resolve(
            baseUrl: 'https://rest.example',
            instance: _v2(entry.key),
          ),
          Uri.parse(entry.value),
          reason: entry.key,
        );
      }
    });

    test('assumes HTTPS when the scheme is omitted', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2('stream.example:9443'),
      );

      expect(uri, Uri.parse('wss://stream.example:9443/api/v1/streaming'));
    });

    test('removes a trailing slash before appending the path', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2('https://stream.example/custom///'),
      );

      expect(uri, Uri.parse('wss://stream.example/custom/api/v1/streaming'));
    });

    test('does not duplicate an existing streaming path', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2('https://stream.example/api/v1/streaming/'),
      );

      expect(uri, Uri.parse('wss://stream.example/api/v1/streaming'));
    });

    test('appends the streaming path to an existing prefix', () {
      final uri = resolver.resolve(
        baseUrl: 'https://rest.example',
        instance: _v2('https://stream.example/mastodon'),
      );

      expect(uri, Uri.parse('wss://stream.example/mastodon/api/v1/streaming'));
    });
  });
}

MastodonInstance _v2(String? streamingUrl) => MastodonInstance(
  domain: 'rest.example',
  title: 'Test',
  version: '4.6.3',
  configuration: MastodonInstanceConfiguration(
    urls: MastodonInstanceUrls(streaming: streamingUrl),
  ),
  rules: const [],
);

MastodonInstanceV1 _v1(String? streamingUrl) => MastodonInstanceV1(
  uri: 'rest.example',
  title: 'Test',
  version: '3.5.0',
  rules: const [],
  urls: MastodonInstanceV1Urls(streamingApi: streamingUrl),
  registrations: false,
  approvalRequired: false,
  invitesEnabled: false,
);
