// ignore_for_file: deprecated_member_use_from_same_package

import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/api/admin/admin_ip_blocks_api.dart';
import 'package:mastodon_client/src/api/filters_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  const filterResponse = <String, dynamic>{
    'id': '1',
    'title': 'Test filter',
    'context': <String>['home'],
    'filter_action': 'warn',
    'keywords': <dynamic>[],
    'statuses': <dynamic>[],
  };
  const filterV1Response = <String, dynamic>{
    'id': '1',
    'phrase': 'spoiler',
    'context': <String>['home'],
    'irreversible': false,
    'whole_word': false,
  };
  const ipBlockResponse = <String, dynamic>{
    'id': '1',
    'ip': '192.0.2.0/24',
    'severity': 'no_access',
  };

  test(
    'FiltersApi.update distinguishes set, clear, reset, and omission',
    () async {
      final http = RecordingHttpClient(const [
        filterResponse,
        filterResponse,
        filterResponse,
        filterResponse,
      ]);
      final api = FiltersApi(http);

      await api.update('1', expiresIn: const Optional(3600));
      await api.update('1', expiresIn: const Optional.null_());
      await api.update('1', expiresIn: const Optional(7200));
      await api.update('1');

      expect(http.requests.map((request) => request.data), [
        {'expires_in': 3600},
        {'expires_in': null},
        {'expires_in': 7200},
        <String, dynamic>{},
      ]);
    },
  );

  test(
    'FiltersApi.updateV1 distinguishes set, clear, reset, and omission',
    () async {
      final http = RecordingHttpClient(const [
        filterV1Response,
        filterV1Response,
        filterV1Response,
        filterV1Response,
      ]);
      final api = FiltersApi(http);

      await api.updateV1(
        '1',
        phrase: 'spoiler',
        context: const ['home'],
        expiresIn: const Optional(3600),
      );
      await api.updateV1(
        '1',
        phrase: 'spoiler',
        context: const ['home'],
        expiresIn: const Optional.null_(),
      );
      await api.updateV1(
        '1',
        phrase: 'spoiler',
        context: const ['home'],
        expiresIn: const Optional(7200),
      );
      await api.updateV1('1', phrase: 'spoiler', context: const ['home']);

      expect(http.requests.map((request) => request.data), [
        {
          'phrase': 'spoiler',
          'context': ['home'],
          'expires_in': 3600,
        },
        {
          'phrase': 'spoiler',
          'context': ['home'],
          'expires_in': null,
        },
        {
          'phrase': 'spoiler',
          'context': ['home'],
          'expires_in': 7200,
        },
        {
          'phrase': 'spoiler',
          'context': ['home'],
        },
      ]);
    },
  );

  test('AdminIpBlocksApi.update distinguishes set, clear, and reset', () async {
    final http = RecordingHttpClient(const [
      ipBlockResponse,
      ipBlockResponse,
      ipBlockResponse,
    ]);
    final api = AdminIpBlocksApi(http);

    await api.update(
      '1',
      const MastodonAdminIpBlockUpdateRequest(expiresIn: Optional(3600)),
    );
    await api.update(
      '1',
      const MastodonAdminIpBlockUpdateRequest(expiresIn: Optional.null_()),
    );
    await api.update(
      '1',
      const MastodonAdminIpBlockUpdateRequest(expiresIn: Optional(7200)),
    );

    expect(http.requests.map((request) => request.data), [
      {'expires_in': 3600},
      {'expires_in': null},
      {'expires_in': 7200},
    ]);
  });

  test('MastodonAdminIpBlockUpdateRequest omits an unspecified expiration', () {
    expect(
      const MastodonAdminIpBlockUpdateRequest().toJson(),
      isNot(contains('expires_in')),
    );
  });
}
