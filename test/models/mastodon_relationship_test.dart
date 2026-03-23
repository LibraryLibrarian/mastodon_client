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
          .map(
            (e) => MastodonRelationship.fromJson(e as Map<String, dynamic>),
          )
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
    });
  });
}
