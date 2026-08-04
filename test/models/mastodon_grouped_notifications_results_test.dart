import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonGroupedNotificationsResults.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/grouped_notifications.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      final result = MastodonGroupedNotificationsResults.fromJson(json);

      // accounts
      expect(result.accounts, hasLength(1));
      expect(result.accounts.first.id, equals('116266789448809503'));
      expect(result.accounts.first.username, equals('testuser2'));
      expect(result.accounts.first.acct, equals('testuser2'));

      // statuses
      expect(result.statuses, hasLength(2));
      expect(result.statuses.first.id, equals('116266792208918608'));
      expect(
        result.statuses.first.visibility,
        equals(MastodonVisibility.public),
      );
      expect(result.statuses.first.sensitive, isFalse);

      // partial_accounts は fixture に含まれないのでデフォルト空リスト
      expect(result.partialAccounts, isEmpty);

      // notification_groups
      expect(result.notificationGroups, hasLength(5));

      final mention = result.notificationGroups[0];
      expect(mention.groupKey, equals('ungrouped-6'));
      expect(mention.notificationsCount, equals(1));
      expect(mention.type, equals(MastodonNotificationType.mention));
      expect(mention.mostRecentNotificationId, equals('6'));
      expect(mention.pageMinId, equals('6'));
      expect(mention.pageMaxId, equals('6'));
      expect(mention.latestPageNotificationAt, isNotNull);
      expect(
        mention.latestPageNotificationAt,
        equals(DateTime.utc(2026, 3, 21, 10, 54, 17, 412)),
      );
      expect(mention.sampleAccountIds, equals(['116266789448809503']));
      expect(mention.statusId, equals('116266792208918608'));

      final reblog = result.notificationGroups[1];
      expect(reblog.groupKey, equals('reblog-116266764647790665-492802'));
      expect(reblog.type, equals(MastodonNotificationType.reblog));
      expect(reblog.statusId, equals('116266764647790665'));

      final follow = result.notificationGroups[3];
      expect(follow.groupKey, equals('follow-492802'));
      expect(follow.type, equals(MastodonNotificationType.follow));
      expect(follow.statusId, isNull);
      expect(follow.report, isNull);
      expect(follow.event, isNull);
      expect(follow.moderationWarning, isNull);

      final adminSignUp = result.notificationGroups[4];
      expect(adminSignUp.type, equals(MastodonNotificationType.adminSignUp));
    });
  });
}
