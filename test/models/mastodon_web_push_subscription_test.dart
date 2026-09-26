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
      expect(alerts.severedRelationships, isFalse);
      expect(alerts.moderationWarning, isFalse);
      expect(alerts.annualReport, isFalse);
      expect(alerts.addedToCollection, isFalse);
      expect(alerts.collectionUpdate, isFalse);
    });
  });

  group('MastodonPushAlerts', () {
    test('deserializes all 17 official notification types', () {
      final alerts = MastodonPushAlerts.fromJson(_allAlertsJson);

      expect(alerts.mention, isTrue);
      expect(alerts.quote, isFalse);
      expect(alerts.status, isTrue);
      expect(alerts.reblog, isFalse);
      expect(alerts.follow, isTrue);
      expect(alerts.followRequest, isFalse);
      expect(alerts.favourite, isTrue);
      expect(alerts.poll, isFalse);
      expect(alerts.update, isTrue);
      expect(alerts.severedRelationships, isFalse);
      expect(alerts.moderationWarning, isTrue);
      expect(alerts.annualReport, isFalse);
      expect(alerts.quotedUpdate, isTrue);
      expect(alerts.addedToCollection, isFalse);
      expect(alerts.collectionUpdate, isTrue);
      expect(alerts.adminSignUp, isFalse);
      expect(alerts.adminReport, isTrue);
    });

    test('uses false for every omitted notification type', () {
      const alerts = MastodonPushAlerts();

      expect(alerts.toJson().values, everyElement(isFalse));
    });

    test('serializes all 17 official notification types', () {
      final alerts = MastodonPushAlerts.fromJson(_allAlertsJson);

      expect(alerts.toJson(), _allAlertsJson);
    });
  });
}

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
