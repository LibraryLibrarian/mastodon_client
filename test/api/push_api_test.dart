import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/api/push_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  group('MastodonPushAlertSettings', () {
    test('serializes all 17 official notification types', () {
      const alerts = MastodonPushAlertSettings(
        mention: true,
        quote: false,
        status: true,
        reblog: false,
        follow: true,
        followRequest: false,
        favourite: true,
        poll: false,
        update: true,
        severedRelationships: false,
        moderationWarning: true,
        annualReport: false,
        quotedUpdate: true,
        addedToCollection: false,
        collectionUpdate: true,
        adminSignUp: false,
        adminReport: true,
      );

      expect(alerts.toJson(), _allAlertsJson);
    });
  });

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
            severedRelationships: true,
            annualReport: false,
            addedToCollection: true,
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
          'alerts': {
            'mention': true,
            'follow_request': false,
            'severed_relationships': true,
            'annual_report': false,
            'added_to_collection': true,
          },
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
          alerts: MastodonPushAlertSettings(
            mention: true,
            moderationWarning: true,
            collectionUpdate: false,
          ),
          policy: 'follower',
        ),
      );

      expect(http.requests.single.method, 'PUT');
      expect(http.requests.single.path, '/api/v1/push/subscription');
      expect(http.requests.single.data, {
        'data': {
          'alerts': {
            'mention': true,
            'moderation_warning': true,
            'collection_update': false,
          },
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

const _allAlertsJson = <String, dynamic>{
  'mention': true,
  'quote': false,
  'status': true,
  'reblog': false,
  'follow': true,
  'follow_request': false,
  'favourite': true,
  'poll': false,
  'update': true,
  'severed_relationships': false,
  'moderation_warning': true,
  'annual_report': false,
  'quoted_update': true,
  'added_to_collection': false,
  'collection_update': true,
  'admin.sign_up': false,
  'admin.report': true,
};
