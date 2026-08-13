import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonWebPushSubscription.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/web_push_subscription.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      final subscription = MastodonWebPushSubscription.fromJson(json);

      expect(subscription.id, equals('1'));
      expect(subscription.endpoint, equals('https://example.com/push'));
      expect(subscription.standard, isFalse);
      expect(subscription.policy, equals('all'));
      expect(
        subscription.serverKey,
        equals(
          'BElU32nVl4v6dZV8NfneXy7KeWCl8wX-mJX5b4n7pY10bCf7QsmARTctqT'
          'ax9_nEknkoMyfBwQ56hwZk_4PJ72o=',
        ),
      );

      final alerts = subscription.alerts;
      expect(alerts.mention, isTrue);
      expect(alerts.reblog, isTrue);
      expect(alerts.follow, isTrue);
      expect(alerts.favourite, isTrue);
      expect(alerts.poll, isTrue);
      // fixture にないフィールドはデフォルト false
      expect(alerts.quote, isFalse);
      expect(alerts.status, isFalse);
      expect(alerts.followRequest, isFalse);
      expect(alerts.update, isFalse);
      expect(alerts.adminSignUp, isFalse);
      expect(alerts.adminReport, isFalse);
    });
  });
}
