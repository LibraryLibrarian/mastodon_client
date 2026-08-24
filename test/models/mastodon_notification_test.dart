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
      expect(mention.id, isNotEmpty);
      expect(mention.type, MastodonNotificationType.mention);
      expect(mention.account.id, isNotEmpty);
      expect(mention.account.username, isNotEmpty);
      expect(mention.status, isNotNull);
      expect(mention.status!.id, isNotEmpty);
      expect(mention.status!.visibility, MastodonVisibility.public);
      expect(mention.status!.mentions, hasLength(1));
      expect(mention.status!.mentions.first.username, isNotEmpty);

      // second notification: reblog
      final reblog = notifications[1];
      expect(reblog.id, isNotEmpty);
      expect(reblog.type, MastodonNotificationType.reblog);
      expect(reblog.account.username, isNotEmpty);
    });

    test('groupKey links a v1 notification to its v2 group', () {
      final file = File('test/fixtures/notifications.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final notifications = list
          .map((e) => MastodonNotification.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(notifications.first.groupKey, isNotEmpty);

      // グループ化されなかった通知には ungrouped-<id> が割り当てられる
      final ungrouped = notifications.firstWhere(
        (n) => n.groupKey!.startsWith('ungrouped-'),
      );
      expect(ungrouped.groupKey, 'ungrouped-${ungrouped.id}');
    });

    test('groupKey is null on servers older than 4.3.0', () {
      final file = File('test/fixtures/notifications.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final json = list.first as Map<String, dynamic>..remove('group_key');

      expect(MastodonNotification.fromJson(json).groupKey, isNull);
    });

    test('deserializes Mastodon 4.6 collection notification fallback', () {
      final file = File('test/fixtures/notifications.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final json = Map<String, dynamic>.from(list.first as Map<String, dynamic>)
        ..['type'] = 'added_to_collection'
        ..['collection'] = {'id': '42', 'name': 'Friends'}
        ..['fallback'] = {
          'title': '<span>Alice</span> added you to a collection',
          'summary': '<a href="/">Sign in</a> to view it',
          'description': null,
        };

      final notification = MastodonNotification.fromJson(json);

      expect(notification.type, MastodonNotificationType.addedToCollection);
      expect(notification.collection?.id, '42');
      expect(notification.fallback?.title, contains('Alice'));
      expect(notification.fallback?.description, isNull);
    });
  });
}
