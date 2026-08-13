import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonOEmbed.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/oembed.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonOEmbed.fromJson(json);

      expect(obj.type, 'rich');
      expect(obj.version, '1.0');
      expect(obj.authorName, 'testadmin');
      expect(obj.authorUrl, 'https://localhost:3001/@testadmin');
      expect(obj.providerName, 'localhost:3001');
      expect(obj.providerUrl, 'https://localhost:3001/');
      expect(obj.cacheAge, 86400);
      expect(obj.width, 400);
      expect(obj.height, isNull);
      expect(obj.html, contains('mastodon-embed'));
    });
  });
}
