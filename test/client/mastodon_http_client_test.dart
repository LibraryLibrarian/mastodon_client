import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mastodon_client/mastodon_client.dart';
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
      expect(client.dio.options.connectTimeout, isNull);
      expect(client.dio.options.receiveTimeout, isNull);
      expect(client.dio.options.sendTimeout, isNull);
    });

    test('MastodonClient requests do not add timeout defaults', () async {
      final adapter = _CaptureAdapter();
      final client = MastodonClient(
        baseUrl: 'https://mastodon.example',
        enableLog: false,
        httpClientAdapter: adapter,
      );

      await client.health.check();

      expect(adapter.request?.connectTimeout, isNull);
      expect(adapter.request?.receiveTimeout, isNull);
      expect(adapter.request?.sendTimeout, isNull);
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

class _CaptureAdapter implements HttpClientAdapter {
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromString(
      '{}',
      200,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
