import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonSearchResult.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/search.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final result = MastodonSearchResult.fromJson(json);

      expect(result.accounts, hasLength(1));
      expect(result.accounts.first.id, isNotEmpty);
      expect(result.accounts.first.username, 'md_eve');
      expect(result.accounts.first.acct, 'md_eve');
      expect(result.statuses, isEmpty);
      expect(result.hashtags, isEmpty);
    });
  });
}
