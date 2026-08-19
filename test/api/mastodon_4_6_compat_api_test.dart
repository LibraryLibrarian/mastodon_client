import 'package:mastodon_client/src/api/accounts_api.dart';
import 'package:mastodon_client/src/api/grouped_notifications_api.dart';
import 'package:mastodon_client/src/api/notifications_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  test('notification list requests send supported_types[]', () async {
    final http = RecordingHttpClient([
      <dynamic>[],
      {
        'accounts': <dynamic>[],
        'partial_accounts': <dynamic>[],
        'statuses': <dynamic>[],
        'notification_groups': <dynamic>[],
      },
    ]);

    await NotificationsApi(
      http,
    ).fetch(supportedTypes: const ['mention', 'follow']);
    await GroupedNotificationsApi(
      http,
    ).fetch(supportedTypes: const ['mention', 'follow']);

    expect(http.requests[0].queryParameters?['supported_types[]'], [
      'mention',
      'follow',
    ]);
    expect(http.requests[1].queryParameters?['supported_types[]'], [
      'mention',
      'follow',
    ]);
  });

  test('account statuses request sends exclude_direct', () async {
    final http = RecordingHttpClient([<dynamic>[]]);

    await AccountsApi(http).fetchStatuses('42', excludeDirect: true);

    expect(http.requests.single.path, '/api/v1/accounts/42/statuses');
    expect(http.requests.single.queryParameters?['exclude_direct'], isTrue);
  });
}
