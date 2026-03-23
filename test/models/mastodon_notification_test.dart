import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonNotification.fromJson (list) - notifications.json', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/notifications.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final notifications = list
          .map((e) => MastodonNotification.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(notifications, isNotEmpty);

      // first notification: mention
      final mention = notifications.first;
      expect(mention.id, '6');
      expect(mention.type, MastodonNotificationType.mention);
      expect(mention.account.id, '116266789448809503');
      expect(mention.account.username, 'testuser2');
      expect(mention.status, isNotNull);
      expect(mention.status!.id, '116266792208918608');
      expect(mention.status!.visibility, MastodonVisibility.public);
      expect(mention.status!.mentions, hasLength(1));
      expect(mention.status!.mentions.first.username, 'testadmin');

      // second notification: reblog
      final reblog = notifications[1];
      expect(reblog.id, '5');
      expect(reblog.type, MastodonNotificationType.reblog);
      expect(reblog.account.username, 'testuser2');
    });
  });
}
