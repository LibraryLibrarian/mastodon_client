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
