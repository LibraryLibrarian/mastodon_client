import 'dart:convert';
import 'dart:io';

import 'package:mastodon_client/src/api/mutes_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  test('fetch returns muted accounts with their expiration', () async {
    final fixture =
        jsonDecode(File('test/fixtures/mutes.json').readAsStringSync())
            as List<dynamic>;
    final http = RecordingHttpClient([fixture]);

    final page = await MutesApi(
      http,
    ).fetch(limit: 40, maxId: '100', sinceId: '10');

    expect(page.items, hasLength(1));
    expect(page.items.single.account.username, 'e2e_admin');
    expect(
      page.items.single.muteExpiresAt,
      DateTime.utc(2026, 9, 7, 15, 47, 31, 818),
    );
    expect(http.requests.single.path, '/api/v1/mutes');
    expect(http.requests.single.queryParameters, {
      'limit': 40,
      'max_id': '100',
      'since_id': '10',
    });
  });
}
