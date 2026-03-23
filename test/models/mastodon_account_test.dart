import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAccount.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final account = MastodonAccount.fromJson(json);

      expect(account.id, '116266741324121431');
      expect(account.username, 'testadmin');
      expect(account.acct, 'testadmin');
      expect(account.displayName, '');
      expect(account.locked, false);
      expect(account.bot, false);
      expect(account.followersCount, 0);
      expect(account.followingCount, 0);
      expect(account.statusesCount, 5);
      expect(account.url, 'https://localhost:3001/@testadmin');
      expect(
        account.avatarUrl,
        'https://localhost:3001/avatars/original/missing.png',
      );
      expect(
        account.avatarStaticUrl,
        'https://localhost:3001/avatars/original/missing.png',
      );
      expect(
        account.headerUrl,
        'https://localhost:3001/headers/original/missing.png',
      );
      expect(account.fields, isEmpty);
      expect(account.emojis, isEmpty);
      expect(account.noindex, false);
      expect(account.discoverable, isNull);
    });
  });

  group('MastodonAccount.fromJson (list) - account_followers.json', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/account_followers.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final accounts = list
          .map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(accounts, hasLength(1));

      final first = accounts.first;
      expect(first.id, '116266789448809503');
      expect(first.username, 'testuser2');
      expect(first.acct, 'testuser2');
      expect(first.followersCount, 1);
      expect(first.followingCount, 1);
      expect(first.statusesCount, 2);
      expect(first.discoverable, true);
      expect(first.url, 'https://localhost:3001/@testuser2');
    });
  });

  group('MastodonAccount.fromJson (list) - account_search.json', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/account_search.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final accounts = list
          .map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(accounts, hasLength(1));

      final first = accounts.first;
      expect(first.id, '116266741324121431');
      expect(first.username, 'testadmin');
      expect(first.acct, 'testadmin');
      expect(first.statusesCount, 5);
      expect(first.locked, false);
      expect(first.bot, false);
    });
  });
}
