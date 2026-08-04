import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonWeeklyActivity.fromJson', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/instance_activity.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final activities = list
          .map(
            (e) => MastodonWeeklyActivity.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      expect(activities, hasLength(12));

      // 最新週（インデックス 0）
      final first = activities.first;
      expect(first.week, equals('1774270755'));
      expect(first.statuses, equals('0'));
      expect(first.logins, equals('1'));
      expect(first.registrations, equals('0'));

      // 2番目の週（アクティビティあり）
      final second = activities[1];
      expect(second.week, equals('1773665955'));
      expect(second.statuses, equals('7'));
      expect(second.logins, equals('5'));
      expect(second.registrations, equals('5'));

      // 最後の週
      final last = activities.last;
      expect(last.week, equals('1767617955'));
      expect(last.statuses, equals('0'));
      expect(last.logins, equals('0'));
      expect(last.registrations, equals('0'));
    });
  });
}
