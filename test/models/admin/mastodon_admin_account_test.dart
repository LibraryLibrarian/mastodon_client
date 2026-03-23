import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminAccount.fromJson', () {
    test('deserializes single account from fixture', () {
      final file = File('test/fixtures/admin/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminAccount.fromJson(json);

      expect(obj.id, '116266741324121431');
      expect(obj.username, 'testadmin');
      expect(obj.domain, isNull);
      expect(obj.email, 'admin@localhost');
      expect(obj.ip, isNull);
      expect(obj.confirmed, isTrue);
      expect(obj.approved, isTrue);
      expect(obj.suspended, isFalse);
      expect(obj.silenced, isFalse);
      expect(obj.disabled, isFalse);
      expect(obj.sensitized, isFalse);
      expect(obj.ips, isEmpty);
      expect(obj.createdAt, DateTime.utc(2026, 3, 21, 10, 41, 21, 51));
    });

    test('deserializes nested account field', () {
      final file = File('test/fixtures/admin/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminAccount.fromJson(json);

      expect(obj.account, isNotNull);
      expect(obj.account!.id, '116266741324121431');
      expect(obj.account!.username, 'testadmin');
      expect(obj.account!.acct, 'testadmin');
    });

    test('deserializes role field', () {
      final file = File('test/fixtures/admin/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminAccount.fromJson(json);

      expect(obj.role, isNotNull);
      expect(obj.role!.id, '3');
      expect(obj.role!.name, 'Owner');
      expect(obj.role!.permissions, '2097151');
      expect(obj.role!.color, '');
      expect(obj.role!.highlighted, isTrue);
    });

    test('deserializes list of accounts from fixture', () {
      final file = File('test/fixtures/admin/accounts.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final accounts = list
          .map((e) => MastodonAdminAccount.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(accounts, hasLength(2));

      final first = accounts.first;
      expect(first.id, '116266789448809503');
      expect(first.username, 'testuser2');
      expect(first.email, 'user2@localhost');
      expect(first.confirmed, isTrue);
      expect(first.approved, isTrue);
      expect(first.role!.id, '-99');
      expect(first.role!.name, '');
      expect(first.role!.highlighted, isFalse);

      final second = accounts[1];
      expect(second.id, '116266741324121431');
      expect(second.username, 'testadmin');
    });
  });
}
