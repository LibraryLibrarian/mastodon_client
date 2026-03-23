import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonFeaturedTag.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/featured_tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonFeaturedTag.fromJson(
        list.first as Map<String, dynamic>,
      );

      expect(obj.id, '1');
      expect(obj.name, 'mastodon');
      expect(obj.url, 'https://localhost:3001/@testadmin/tagged/mastodon');
      expect(obj.statusesCount, 1);
      expect(obj.lastStatusAt, isNotNull);
    });

    test('deserializes list of featured tags', () {
      final file = File('test/fixtures/featured_tags.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final tags = list
          .map((e) => MastodonFeaturedTag.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(tags.length, 1);
      expect(tags.first.name, 'mastodon');
    });
  });
}
