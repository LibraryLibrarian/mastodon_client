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

      expect(obj.id, isNotEmpty);
      expect(obj.username, 'e2e_admin');
      expect(obj.domain, isNull);
      // メールアドレスは採取時に redact.py がマスクする
      expect(obj.email, 'redacted@example.test');
      expect(obj.ip, isNull);
      expect(obj.confirmed, isTrue);
      expect(obj.approved, isTrue);
      expect(obj.suspended, isFalse);
      expect(obj.silenced, isFalse);
      expect(obj.disabled, isFalse);
      expect(obj.sensitized, isFalse);
      expect(obj.ips, isEmpty);
      expect(obj.createdAt, isA<DateTime>());
    });

    test('deserializes nested account field', () {
      final file = File('test/fixtures/admin/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminAccount.fromJson(json);

      expect(obj.account, isNotNull);
      expect(obj.account!.id, obj.id);
      expect(obj.account!.username, 'e2e_admin');
      expect(obj.account!.acct, 'e2e_admin');
    });

    test('deserializes role field', () {
      final file = File('test/fixtures/admin/account.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminAccount.fromJson(json);

      expect(obj.role, isNotNull);
      expect(obj.role!.id, '3');
      expect(obj.role!.name, 'Owner');
      expect(obj.role!.permissions, isNotEmpty);
      expect(obj.role!.color, '');
      expect(obj.role!.highlighted, isTrue);
      // Mastodon 4.6.0 で追加。ロールごとのコレクション作成上限
      expect(obj.role!.collectionLimit, 10);
    });

    test('role id is coerced from int (instances returning numeric ids)', () {
      // flexibleIdFromJson の導入理由そのものの検証。実サーバーは文字列で
      // 返すため fixture では通らない経路
      final obj = MastodonAdminAccount.fromJson(const {
        'id': '1',
        'username': 'numeric_role',
        'role': {'id': 3, 'name': 'Owner'},
      });

      expect(obj.role!.id, '3');
      expect(obj.role!.name, 'Owner');
    });

    test('deserializes legacy string role (Mastodon 3.x / Fedibird)', () {
      // 3.x系は role をオブジェクトではなく文字列で返すため、
      // オブジェクト前提のキャストではデシリアライズに失敗していた
      final file = File('test/fixtures/admin/account_v3_legacy_role.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminAccount.fromJson(json);

      expect(obj.role, isNotNull);
      expect(obj.role!.name, 'user');
      expect(obj.role!.id, isNull);
      expect(obj.username, 'e2e_carol');
    });

    test('role is null when the field is absent', () {
      final obj = MastodonAdminAccount.fromJson(const {
        'id': '1',
        'username': 'nobody',
      });
      expect(obj.role, isNull);
    });

    test('deserializes list of accounts from fixture', () {
      final file = File('test/fixtures/admin/accounts.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final accounts = list
          .map((e) => MastodonAdminAccount.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(accounts, isNotEmpty);

      final first = accounts.first;
      expect(first.id, isNotEmpty);
      expect(first.username, isNotEmpty);
      expect(first.confirmed, isTrue);
      expect(first.approved, isTrue);
      expect(first.role, isNotNull);

      expect(
        accounts.map((a) => a.username),
        containsAll(['md_eve', 'e2e_bob']),
      );
    });
  });
}
