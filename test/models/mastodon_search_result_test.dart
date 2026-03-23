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
      expect(result.accounts.first.id, equals('116266741324121431'));
      expect(result.accounts.first.username, equals('testadmin'));
      expect(result.accounts.first.acct, equals('testadmin'));
      expect(result.accounts.first.followersCount, equals(0));
      expect(result.accounts.first.followingCount, equals(0));
      expect(result.accounts.first.statusesCount, equals(5));
      expect(result.statuses, isEmpty);
      expect(result.hashtags, isEmpty);
    });
  });
}
