import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonCustomEmoji.fromJson', () {
    test('deserializes list from custom_emojis.json fixture', () {
      final file = File('test/fixtures/custom_emojis.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final emojis = list
          .map(
            (e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      expect(emojis, hasLength(1));

      final emoji = emojis.first;
      expect(emoji.shortcode, equals('test_emoji'));
      expect(
        emoji.url,
        equals(
          'https://localhost:3001/system/custom_emojis/images/000/000/001/original/81f156882693b7ac.png',
        ),
      );
      expect(
        emoji.staticUrl,
        equals(
          'https://localhost:3001/system/custom_emojis/images/000/000/001/static/81f156882693b7ac.png',
        ),
      );
      expect(emoji.visibleInPicker, isTrue);
      expect(emoji.category, isNull);
    });
  });
}
