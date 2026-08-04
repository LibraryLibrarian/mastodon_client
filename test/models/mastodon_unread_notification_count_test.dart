import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonUnreadNotificationCount.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/unread_notification_count.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonUnreadNotificationCount.fromJson(json);

      expect(obj.count, 5);
    });
  });
}
