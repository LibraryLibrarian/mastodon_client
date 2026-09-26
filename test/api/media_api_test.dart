import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/api/media_api.dart';
import 'package:mastodon_client/src/client/mastodon_http_client.dart';
import 'package:test/test.dart';

void main() {
  group('MediaApi.upload', () {
    test('returns a completed attachment from HTTP 200', () async {
      final adapter = _QueueAdapter(<_StubResponse>[
        _StubResponse(200, _attachmentJson(url: 'https://example/media.mp4')),
      ]);
      final api = _createApi(adapter);

      final attachment = await api.upload(
        Uint8List.fromList(<int>[1, 2, 3]),
        'video.mp4',
      );

      expect(attachment.id, 'media-1');
      expect(attachment.url, 'https://example/media.mp4');
      expect(adapter.requests, hasLength(1));
      expect(adapter.requests.single.method, 'POST');
      expect(adapter.requests.single.path, '/api/v2/media');
    });

    test(
      'returns an in-progress attachment from HTTP 202 without polling',
      () async {
        final adapter = _QueueAdapter(<_StubResponse>[
          _StubResponse(202, _attachmentJson()),
        ]);
        final api = _createApi(adapter);

        final attachment = await api.upload(
          Uint8List.fromList(<int>[1, 2, 3]),
          'video.mp4',
        );

        expect(attachment.id, 'media-1');
        expect(attachment.url, isNull);
        expect(adapter.requests, hasLength(1));
        expect(adapter.requests.single.method, 'POST');
        expect(adapter.requests.single.path, '/api/v2/media');
      },
    );
  });

  group('MediaApi.fetchById', () {
    test('returns an in-progress attachment from HTTP 206', () async {
      final adapter = _QueueAdapter(<_StubResponse>[
        _StubResponse(206, _attachmentJson()),
      ]);
      final api = _createApi(adapter);

      final attachment = await api.fetchById('media-1');

      expect(attachment.url, isNull);
      expect(adapter.requests.single.method, 'GET');
      expect(adapter.requests.single.path, '/api/v1/media/media-1');
    });

    test('returns a completed attachment from HTTP 200', () async {
      final adapter = _QueueAdapter(<_StubResponse>[
        _StubResponse(200, _attachmentJson(url: 'https://example/media.mp4')),
      ]);
      final api = _createApi(adapter);

      final attachment = await api.fetchById('media-1');

      expect(attachment.url, 'https://example/media.mp4');
    });

    test('maps HTTP 422 to MastodonValidationException', () async {
      final adapter = _QueueAdapter(<_StubResponse>[
        const _StubResponse(422, <String, dynamic>{
          'error': 'Error processing media',
        }),
      ]);
      final api = _createApi(adapter);

      await expectLater(
        api.fetchById('media-1'),
        throwsA(
          isA<MastodonValidationException>()
              .having(
                (error) => error.serverMessage,
                'serverMessage',
                'Error processing media',
              )
              .having(
                (error) => error.endpoint,
                'endpoint',
                '/api/v1/media/media-1',
              ),
        ),
      );
    });
  });
}

MediaApi _createApi(HttpClientAdapter adapter) => MediaApi(
  MastodonHttpClient(
    baseUrl: 'https://mastodon.example',
    enableLog: false,
    httpClientAdapter: adapter,
  ),
);

Map<String, dynamic> _attachmentJson({String? url}) => <String, dynamic>{
  'id': 'media-1',
  'type': 'video',
  'url': url,
};

class _StubResponse {
  const _StubResponse(this.statusCode, this.body);

  final int statusCode;
  final Map<String, dynamic> body;
}

class _QueueAdapter implements HttpClientAdapter {
  _QueueAdapter(Iterable<_StubResponse> responses)
    : _responses = responses.toList();

  final List<_StubResponse> _responses;
  final List<RequestOptions> requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (_responses.isEmpty) {
      throw StateError('Unexpected request: ${options.method} ${options.path}');
    }
    final response = _responses.removeAt(0);
    return ResponseBody.fromString(
      jsonEncode(response.body),
      response.statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
