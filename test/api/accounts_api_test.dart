import 'package:dio/dio.dart';
import 'package:mastodon_client/src/api/accounts_api.dart';
import 'package:mastodon_client/src/client/mastodon_http_client.dart';
import 'package:mastodon_client/src/exception/mastodon_exception.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  group('AccountsApi account collections', () {
    test('returns an empty page for a successful empty response', () async {
      final api = AccountsApi(RecordingHttpClient([<dynamic>[]]));

      final page = await api.fetchFollowers('42');

      expect(page.items, isEmpty);
    });

    for (final testCase
        in <({String name, String path, _AccountPageCall call})>[
          (
            name: 'fetchFollowers',
            path: '/api/v1/accounts/42/followers',
            call: (api) => api.fetchFollowers('42'),
          ),
          (
            name: 'fetchFollowing',
            path: '/api/v1/accounts/42/following',
            call: (api) => api.fetchFollowing('42'),
          ),
          (
            name: 'fetchEndorsements',
            path: '/api/v1/accounts/42/endorsements',
            call: (api) => api.fetchEndorsements('42'),
          ),
        ]) {
      test('${testCase.name} propagates HTTP 403', () async {
        final api = AccountsApi(_ForbiddenHttpClient());

        await expectLater(
          testCase.call(api),
          throwsA(
            isA<MastodonForbiddenException>()
                .having((error) => error.message, 'message', 'Scope denied')
                .having((error) => error.endpoint, 'endpoint', testCase.path),
          ),
        );
      });
    }
  });
}

typedef _AccountPageCall = Future<Object?> Function(AccountsApi api);

class _ForbiddenHttpClient extends MastodonHttpClient {
  _ForbiddenHttpClient()
    : super(baseUrl: 'https://mastodon.example', enableLog: false);

  @override
  Future<Response<T>> sendRaw<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) {
    throw MastodonForbiddenException(message: 'Scope denied', endpoint: path);
  }
}
