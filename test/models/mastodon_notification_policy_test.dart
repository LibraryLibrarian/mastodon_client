import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonNotificationPolicy.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/notification_policy.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonNotificationPolicy.fromJson(json);

      expect(obj.forNotFollowing, NotificationFilterAction.accept);
      expect(obj.forNotFollowers, NotificationFilterAction.accept);
      expect(obj.forNewAccounts, NotificationFilterAction.accept);
      expect(obj.forPrivateMentions, NotificationFilterAction.filter);
      expect(obj.forLimitedAccounts, NotificationFilterAction.filter);
      expect(obj.summary, isNotNull);
    });

    test('deserializes nested summary', () {
      final file = File('test/fixtures/notification_policy.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonNotificationPolicy.fromJson(json);
      final summary = obj.summary!;

      expect(summary.pendingRequestsCount, 0);
      expect(summary.pendingNotificationsCount, 0);
    });
  });
}
