import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/api/push_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  group('PushApi.create', () {
    test('nests alerts and policy in data', () async {
      final http = RecordingHttpClient([_subscriptionResponse]);
      final api = PushApi(http);

      await api.create(
        const MastodonPushSubscriptionRequest(
          endpoint: 'https://push.example/subscription',
          p256dh: 'public-key',
          auth: 'auth-secret',
          standard: true,
          alerts: MastodonPushAlertSettings(
            mention: true,
            followRequest: false,
          ),
          policy: 'followed',
        ),
      );

      expect(http.requests.single.method, 'POST');
      expect(http.requests.single.path, '/api/v1/push/subscription');
      expect(http.requests.single.data, {
        'subscription': {
          'endpoint': 'https://push.example/subscription',
          'keys': {'p256dh': 'public-key', 'auth': 'auth-secret'},
          'standard': true,
        },
        'data': {
          'alerts': {'mention': true, 'follow_request': false},
          'policy': 'followed',
        },
      });
    });
  });

  group('PushApi.update', () {
    test('nests a policy-only update in data', () async {
      final http = RecordingHttpClient([_subscriptionResponse]);
      final api = PushApi(http);

      await api.update(
        const MastodonPushSubscriptionUpdateRequest(policy: 'followed'),
      );

      expect(http.requests.single.data, {
        'data': {'policy': 'followed'},
      });
    });

    test('nests policy in data alongside alerts', () async {
      final http = RecordingHttpClient([_subscriptionResponse]);
      final api = PushApi(http);

      await api.update(
        const MastodonPushSubscriptionUpdateRequest(
          alerts: MastodonPushAlertSettings(mention: true, reblog: false),
          policy: 'follower',
        ),
      );

      expect(http.requests.single.method, 'PUT');
      expect(http.requests.single.path, '/api/v1/push/subscription');
      expect(http.requests.single.data, {
        'data': {
          'alerts': {'mention': true, 'reblog': false},
          'policy': 'follower',
        },
      });
    });

    test('rejects an update without alerts or policy', () async {
      final http = RecordingHttpClient();
      final api = PushApi(http);

      await expectLater(
        api.update(const MastodonPushSubscriptionUpdateRequest()),
        throwsArgumentError,
      );
      expect(http.requests, isEmpty);
    });

    test('allows explicitly disabling all alerts and resetting policy', () {
      const request = MastodonPushSubscriptionUpdateRequest(
        alerts: MastodonPushAlertSettings(),
      );

      expect(request.toJson(), {
        'data': {'alerts': <String, dynamic>{}},
      });
    });
  });
}

const _subscriptionResponse = <String, dynamic>{
  'id': '1',
  'endpoint': 'https://push.example/subscription',
  'server_key': 'server-key',
  'alerts': <String, dynamic>{},
  'policy': 'all',
};
