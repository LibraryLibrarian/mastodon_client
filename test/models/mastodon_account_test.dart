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

      expect(account.id, isNotEmpty);
      expect(account.username, 'md_eve');
      expect(account.acct, 'md_eve');
      expect(account.locked, false);
      expect(account.bot, false);
      expect(account.followersCount, isNonNegative);
      expect(account.followingCount, isNonNegative);
      expect(account.statusesCount, isPositive);
      expect(account.url, 'https://mastodon.test/@md_eve');
      expect(account.avatarUrl, startsWith('https://mastodon.test/'));
      expect(account.avatarStaticUrl, startsWith('https://mastodon.test/'));
      expect(account.headerUrl, startsWith('https://mastodon.test/'));
      expect(account.emojis, isEmpty);
      expect(account.noindex, false);
      expect(account.discoverable, true);
    });

    test('deserializes fields added in Mastodon 4.6.0', () {
      final file = File('test/fixtures/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final account = MastodonAccount.fromJson(json);

      // 4.6.0 で追加されたフィールドが実応答から結線されていることを確認する。
      // 空文字列やfalseだとデフォルト値と区別が付かないため、値が入る
      // feature_approval / show_* を明示的に検証している
      expect(account.avatarDescription, isNotNull);
      expect(account.headerDescription, isNotNull);
      expect(account.showFeatured, isTrue);
      expect(account.showMedia, isTrue);
      expect(account.showMediaReplies, isTrue);

      final approval = account.featureApproval;
      expect(approval, isNotNull);
      // automatic/manual は Collection の配列ではなく可視性スコープ名の
      // 文字列配列（実データ採取で判明した実装詳細）
      expect(approval!.automatic, contains('public'));
      expect(approval.manual, isEmpty);
      expect(approval.currentUser, 'automatic');
    });

    test('featureApproval is null on servers older than 4.6.0', () {
      final account = MastodonAccount.fromJson(const {
        'id': '1',
        'username': 'legacy',
        'acct': 'legacy',
        'url': 'https://legacy.test/@legacy',
      });

      expect(account.featureApproval, isNull);
      expect(account.avatarDescription, isNull);
      expect(account.showMedia, isNull);
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
