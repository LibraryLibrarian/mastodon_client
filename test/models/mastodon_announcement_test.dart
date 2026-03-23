import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAnnouncement.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/announcements.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonAnnouncement.fromJson(
        list.first as Map<String, dynamic>,
      );

      expect(obj.id, '1');
      expect(obj.content, '<p>Welcome to our test Mastodon instance!</p>');
      expect(obj.allDay, false);
      expect(obj.read, false);
      expect(obj.emojis, isEmpty);
      expect(obj.reactions, isEmpty);
      expect(obj.tags, isEmpty);
      expect(obj.mentions, isEmpty);
      expect(obj.statuses, isEmpty);
      expect(obj.startsAt, isNotNull);
      expect(obj.endsAt, isNotNull);
      expect(obj.publishedAt, isNotNull);
      expect(obj.updatedAt, isNotNull);
    });

    test('deserializes list of announcements', () {
      final file = File('test/fixtures/announcements.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final announcements = list
          .map((e) => MastodonAnnouncement.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(announcements.length, 1);
      expect(announcements.first.id, '1');
    });
  });
}
