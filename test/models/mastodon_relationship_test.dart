import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonRelationship.fromJson', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/relationships.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final relationships = list
          .map((e) => MastodonRelationship.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(relationships, hasLength(1));

      final rel = relationships.first;
      expect(rel.id, equals('116266789448809503'));
      expect(rel.following, isTrue);
      expect(rel.showingReblogs, isTrue);
      expect(rel.notifying, isFalse);
      expect(rel.followedBy, isTrue);
      expect(rel.blocking, isFalse);
      expect(rel.blockedBy, isFalse);
      expect(rel.muting, isFalse);
      expect(rel.mutingNotifications, isFalse);
      expect(rel.requested, isFalse);
      expect(rel.requestedBy, isFalse);
      expect(rel.domainBlocking, isFalse);
      expect(rel.endorsed, isFalse);
      expect(rel.note, equals(''));
      expect(rel.languages, isNull);
      expect(rel.mutingExpiresAt, isNull);
    });

    test('mutingExpiresAt deserializes a timed mute', () {
      final file = File('test/fixtures/relationships.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final json = list.first as Map<String, dynamic>
        ..['muting'] = true
        ..['muting_expires_at'] = '2026-08-05T12:00:00.000Z';

      final rel = MastodonRelationship.fromJson(json);

      expect(rel.muting, isTrue);
      expect(rel.mutingExpiresAt, DateTime.utc(2026, 8, 5, 12));
    });

    test('mutingExpiresAt is null for an indefinite mute', () {
      final file = File('test/fixtures/relationships.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final json = list.first as Map<String, dynamic>
        ..['muting'] = true
        ..['muting_expires_at'] = null;

      expect(MastodonRelationship.fromJson(json).mutingExpiresAt, isNull);
    });
  });
}
