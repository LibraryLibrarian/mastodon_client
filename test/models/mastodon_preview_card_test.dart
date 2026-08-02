import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonPreviewCard.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/preview_card.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final card = MastodonPreviewCard.fromJson(json);

      expect(card.url, equals('https://joinmastodon.org/'));
      expect(card.title, equals('Mastodon - Decentralized social media'));
      expect(
        card.description,
        equals(
          'Learn more about Mastodon, the radically different, free and'
          ' open-source decentralized social media platform.',
        ),
      );
      expect(card.type, equals(MastodonPreviewCardType.link));
      expect(card.authorName, equals(''));
      expect(card.authorUrl, equals(''));
      expect(card.providerName, equals(''));
      expect(card.providerUrl, equals(''));
      expect(card.html, equals(''));
      expect(card.width, equals(588));
      expect(card.height, equals(392));
      expect(
        card.image,
        equals(
          'https://localhost:3001/system/cache/preview_cards/images/000/000/001/original/1b696f88e9ce0a2e.png',
        ),
      );
      expect(card.embedUrl, equals(''));
      expect(
        card.blurhash,
        equals('U44UXbj_D~aus^fRayfRD#aw-rj{ajfQoffR'),
      );
      expect(card.authors, isEmpty);
    });
  });
}
