import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminTag.fromJson', () {
    test('deserializes list of tags from fixture', () {
      final file = File('test/fixtures/admin/tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final tags = list
          .map((e) => MastodonAdminTag.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(tags, hasLength(3));
    });

    test('first tag has correct fields', () {
      final file = File('test/fixtures/admin/tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final tags = list
          .map((e) => MastodonAdminTag.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = tags.first;
      expect(first.id, '3');
      expect(first.name, 'flutter');
      expect(first.url, 'https://localhost:3001/tags/flutter');
      expect(first.trendable, isFalse);
      expect(first.usable, isTrue);
      expect(first.requiresReview, isTrue);
      expect(first.listable, isTrue);
    });

    test('first tag has correct history entries', () {
      final file = File('test/fixtures/admin/tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final tags = list
          .map((e) => MastodonAdminTag.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = tags.first;
      expect(first.history, hasLength(7));
      expect(first.history.first.day, '1774051200');
      expect(first.history.first.accounts, '1');
      expect(first.history.first.uses, '1');
    });

    test('third tag (mastodon) has correct fields', () {
      final file = File('test/fixtures/admin/tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final tags = list
          .map((e) => MastodonAdminTag.fromJson(e as Map<String, dynamic>))
          .toList();

      final third = tags[2];
      expect(third.id, '1');
      expect(third.name, 'mastodon');
      expect(third.url, 'https://localhost:3001/tags/mastodon');
      expect(third.trendable, isFalse);
      expect(third.usable, isTrue);
      expect(third.requiresReview, isTrue);
      expect(third.listable, isTrue);
    });
  });
}
