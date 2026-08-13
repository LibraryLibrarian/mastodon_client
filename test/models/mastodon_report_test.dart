import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

// アカウントのインライン JSON ヘルパー
Map<String, dynamic> _minimalAccountJson({
  String id = '116266741324121431',
  String username = 'testuser',
}) => <String, dynamic>{
  'id': id,
  'username': username,
  'acct': username,
  'display_name': 'Test User',
  'locked': false,
  'bot': false,
  'created_at': '2024-01-01T00:00:00.000Z',
  'note': '',
  'url': 'https://mastodon.example/@$username',
  'avatar': 'https://mastodon.example/avatars/original/missing.png',
  'avatar_static': 'https://mastodon.example/avatars/original/missing.png',
  'header': 'https://mastodon.example/headers/original/missing.png',
  'header_static': 'https://mastodon.example/headers/original/missing.png',
  'followers_count': 10,
  'following_count': 5,
  'statuses_count': 42,
  'emojis': <dynamic>[],
  'fields': <dynamic>[],
};

void main() {
  group('MastodonReport.fromJson', () {
    test('deserializes full report with target account', () {
      final json = <String, dynamic>{
        'id': '48914',
        'action_taken': false,
        'action_taken_at': null,
        'category': 'spam',
        'comment': 'This account is sending spam.',
        'forwarded': true,
        'created_at': '2024-03-15T12:00:00.000Z',
        'status_ids': ['109876543210', '109876543211'],
        'rule_ids': ['2'],
        'target_account': _minimalAccountJson(
          id: '987654321',
          username: 'spammer',
        ),
      };
      final report = MastodonReport.fromJson(json);

      expect(report.id, '48914');
      expect(report.actionTaken, isFalse);
      expect(report.actionTakenAt, isNull);
      expect(report.category, 'spam');
      expect(report.comment, 'This account is sending spam.');
      expect(report.forwarded, isTrue);
      expect(report.createdAt, isNotNull);
      expect(report.createdAt, DateTime.utc(2024, 3, 15, 12));
      expect(report.statusIds, ['109876543210', '109876543211']);
      expect(report.ruleIds, ['2']);
      expect(report.targetAccount, isNotNull);
      expect(report.targetAccount!.id, '987654321');
      expect(report.targetAccount!.username, 'spammer');
    });

    test('deserializes report with action taken', () {
      final json = <String, dynamic>{
        'id': '48915',
        'action_taken': true,
        'action_taken_at': '2024-03-16T08:30:00.000Z',
        'category': 'violation',
        'comment': 'Violates rule 1.',
        'forwarded': false,
        'created_at': '2024-03-15T18:00:00.000Z',
        'status_ids': null,
        'rule_ids': ['1'],
        'target_account': null,
      };
      final report = MastodonReport.fromJson(json);

      expect(report.id, '48915');
      expect(report.actionTaken, isTrue);
      expect(report.actionTakenAt, isNotNull);
      expect(report.actionTakenAt, DateTime.utc(2024, 3, 16, 8, 30));
      expect(report.category, 'violation');
      expect(report.comment, 'Violates rule 1.');
      expect(report.forwarded, isFalse);
      expect(report.statusIds, isNull);
      expect(report.ruleIds, ['1']);
      expect(report.targetAccount, isNull);
    });

    test('actionTaken defaults to false when omitted', () {
      final json = <String, dynamic>{
        'id': '99999',
        'category': 'other',
        'comment': '',
        'forwarded': false,
      };
      final report = MastodonReport.fromJson(json);

      expect(report.actionTaken, isFalse);
      expect(report.category, 'other');
      expect(report.comment, '');
    });

    test('category defaults to other when omitted', () {
      final json = <String, dynamic>{
        'id': '11111',
        'action_taken': false,
        'comment': 'No category given.',
        'forwarded': false,
      };
      final report = MastodonReport.fromJson(json);

      expect(report.category, 'other');
    });
  });
}
