import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonTag.fromJson', () {
    test('deserializes single tag from tag.json fixture', () {
      final file = File('test/fixtures/tag.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final tag = MastodonTag.fromJson(json);

      expect(tag.id, equals('1'));
      expect(tag.name, equals('mastodon'));
      expect(tag.url, equals('https://localhost:3001/tags/mastodon'));
      expect(tag.following, isFalse);
      expect(tag.featuring, isTrue);
      expect(tag.history, hasLength(7));
      expect(tag.history.first.day, equals('1774051200'));
      expect(tag.history.first.uses, equals('1'));
      expect(tag.history.first.accounts, equals('1'));
      expect(tag.history[1].day, equals('1773964800'));
      expect(tag.history[1].uses, equals('0'));
    });

    test('deserializes list from followed_tags.json fixture', () {
      final file = File('test/fixtures/followed_tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final tags = list
          .map((e) => MastodonTag.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(tags, hasLength(1));

      final tag = tags.first;
      expect(tag.id, equals('1'));
      expect(tag.name, equals('mastodon'));
      expect(tag.url, equals('https://localhost:3001/tags/mastodon'));
      expect(tag.following, isTrue);
      expect(tag.featuring, isTrue);
      expect(tag.history, hasLength(7));
    });
  });
}
