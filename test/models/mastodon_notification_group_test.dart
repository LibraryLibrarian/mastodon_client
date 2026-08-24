import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonNotificationGroup.fromJson', () {
    // fixture から notification_groups を取り出して各要素を直接デシリアライズする
    List<Map<String, dynamic>> loadGroups() {
      final file = File('test/fixtures/grouped_notifications.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      return (json['notification_groups'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
    }

    test('coerces int most_recent_notification_id to String', () {
      // fixture 中の most_recent_notification_id は int で返るインスタンスが
      // 存在する（commit 24f39af で flexibleIdFromJson を適用済み）
      final raw = loadGroups().first;
      expect(raw['most_recent_notification_id'], isA<int>());

      final group = MastodonNotificationGroup.fromJson(raw);
      expect(group.mostRecentNotificationId, equals('6'));
    });

    test('deserializes a mention group', () {
      final group = MastodonNotificationGroup.fromJson(loadGroups()[0]);

      expect(group.groupKey, equals('ungrouped-6'));
      expect(group.notificationsCount, equals(1));
      expect(group.type, equals(MastodonNotificationType.mention));
      expect(group.pageMinId, equals('6'));
      expect(group.pageMaxId, equals('6'));
      expect(
        group.latestPageNotificationAt,
        equals(DateTime.utc(2026, 3, 21, 10, 54, 17, 412)),
      );
      expect(group.sampleAccountIds, equals(['116266789448809503']));
      expect(group.statusId, equals('116266792208918608'));
      expect(group.report, isNull);
      expect(group.event, isNull);
      expect(group.moderationWarning, isNull);
    });

    test('deserializes a follow group without status_id', () {
      final group = MastodonNotificationGroup.fromJson(loadGroups()[3]);

      expect(group.groupKey, equals('follow-492802'));
      expect(group.type, equals(MastodonNotificationType.follow));
      expect(group.statusId, isNull);
    });

    test('deserializes an admin.sign_up group', () {
      final group = MastodonNotificationGroup.fromJson(loadGroups()[4]);

      expect(group.groupKey, equals('admin.sign_up-492802'));
      expect(group.type, equals(MastodonNotificationType.adminSignUp));
      expect(group.statusId, isNull);
    });

    test('falls back to unknown when type is missing', () {
      // _readType により type が欠落していても 'unknown' にフォールバックする
      final base = Map<String, dynamic>.from(loadGroups()[0])..remove('type');

      final group = MastodonNotificationGroup.fromJson(base);
      expect(group.type, equals(MastodonNotificationType.unknown));
    });

    test('deserializes an annual report event', () {
      final json = Map<String, dynamic>.from(loadGroups()[0])
        ..['type'] = 'annual_report'
        ..['annual_report'] = {'year': '2026'}
        ..remove('status_id');

      final group = MastodonNotificationGroup.fromJson(json);

      expect(group.type, MastodonNotificationType.annualReport);
      expect(group.annualReport?.year, '2026');
    });

    test('deserializes collection data and fallback text', () {
      final json = Map<String, dynamic>.from(loadGroups()[0])
        ..['type'] = 'collection_update'
        ..['collection'] = {'id': '42', 'name': 'Friends'}
        ..['fallback'] = {
          'title': 'Collection updated',
          'summary': 'Sign in to view it',
          'description': null,
        }
        ..remove('status_id');

      final group = MastodonNotificationGroup.fromJson(json);

      expect(group.type, MastodonNotificationType.collectionUpdate);
      expect(group.collection?.name, 'Friends');
      expect(group.fallback?.summary, 'Sign in to view it');
    });
  });
}
