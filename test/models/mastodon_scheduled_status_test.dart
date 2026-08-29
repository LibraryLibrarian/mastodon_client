import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonScheduledStatus.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/scheduled_statuses.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonScheduledStatus.fromJson(
        list.first as Map<String, dynamic>,
      );

      expect(obj.id, '1');
      expect(obj.scheduledAt, isNotNull);
      expect(obj.scheduledAt, DateTime.parse('2026-03-25T12:00:00.000Z'));
      expect(obj.mediaAttachments, isEmpty);
      expect(obj.params, isNotNull);
    });

    test('deserializes params correctly', () {
      final file = File('test/fixtures/scheduled_statuses.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonScheduledStatus.fromJson(
        list.first as Map<String, dynamic>,
      );
      final params = obj.params!;

      expect(params.text, 'This is a scheduled post');
      expect(params.visibility, 'public');
      expect(params.sensitive, isNull);
      expect(params.spoilerText, isNull);
      expect(params.language, isNull);
      expect(params.mediaIds, isNull);
      expect(params.inReplyToId, isNull);
      expect(params.poll, isNull);
      expect(params.quotedStatusId, isNull);
      expect(params.quoteApprovalPolicy, 'public');
      expect(params.applicationId, '2');
      expect(params.withRateLimit, isFalse);
      expect(params.allowedMentions, isNull);
      expect(params.scheduledAt, isNull);
      expect(params.idempotency, isNull);
    });

    test('normalizes scheduled status IDs from mixed JSON values', () {
      final params = MastodonScheduledStatusParams.fromJson(<String, dynamic>{
        'text': 'Scheduled quote',
        'quoted_status_id': '123',
        'quote_approval_policy': 'followers',
        'application_id': 456,
        'with_rate_limit': false,
        'allowed_mentions': <dynamic>[789, '1011'],
        'scheduled_at': '2026-03-25T12:00:00.000Z',
      });

      expect(params.quotedStatusId, '123');
      expect(params.quoteApprovalPolicy, 'followers');
      expect(params.applicationId, '456');
      expect(params.withRateLimit, isFalse);
      expect(params.allowedMentions, <String>['789', '1011']);
      expect(params.scheduledAt, DateTime.parse('2026-03-25T12:00:00.000Z'));
    });

    test('handles absent, null, and unexpected allowed_mentions', () {
      final absent = MastodonScheduledStatusParams.fromJson(
        const <String, dynamic>{'text': 'Absent'},
      );
      final nullValue = MastodonScheduledStatusParams.fromJson(
        const <String, dynamic>{'text': 'Null', 'allowed_mentions': null},
      );
      final unexpected = MastodonScheduledStatusParams.fromJson(
        const <String, dynamic>{'text': 'Unexpected', 'allowed_mentions': '1'},
      );

      expect(absent.allowedMentions, isNull);
      expect(absent.quotedStatusId, isNull);
      expect(nullValue.allowedMentions, isNull);
      expect(unexpected.allowedMentions, isNull);
    });

    test('retains every params key from the fixture', () {
      final file = File('test/fixtures/scheduled_statuses.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final json =
          (list.first as Map<String, dynamic>)['params']
              as Map<String, dynamic>;
      final roundTrip = MastodonScheduledStatusParams.fromJson(json).toJson();

      expect(json.keys.toSet().difference(roundTrip.keys.toSet()), isEmpty);
    });

    test('deserializes list of scheduled statuses', () {
      final file = File('test/fixtures/scheduled_statuses.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final statuses = list
          .map(
            (e) => MastodonScheduledStatus.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      expect(statuses.length, 1);
    });
  });
}
