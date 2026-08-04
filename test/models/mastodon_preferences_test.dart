import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonPreferences.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/preferences.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonPreferences.fromJson(json);

      expect(obj.postingDefaultVisibility, 'public');
      expect(obj.postingDefaultSensitive, false);
      expect(obj.postingDefaultLanguage, 'en');
      expect(obj.postingDefaultQuotePolicy, 'public');
      expect(obj.readingExpandMedia, 'default');
      expect(obj.readingExpandSpoilers, false);
    });
  });
}
