import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonCredentialAccount.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/verify_credentials.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final account = MastodonCredentialAccount.fromJson(json);

      expect(account.id, '116266741324121431');
      expect(account.username, 'testadmin');
      expect(account.acct, 'testadmin');
      expect(account.displayName, '');
      expect(account.locked, false);
      expect(account.bot, false);
      expect(account.discoverable, true);
      expect(account.followersCount, 1);
      expect(account.followingCount, 1);
      expect(account.statusesCount, 5);
      expect(account.url, 'https://localhost:3001/@testadmin');
      expect(
        account.avatarUrl,
        'https://localhost:3001/avatars/original/missing.png',
      );
      expect(
        account.headerUrl,
        'https://localhost:3001/headers/original/missing.png',
      );
      expect(account.fields, isEmpty);
      expect(account.emojis, isEmpty);

      // source
      expect(account.source, isNotNull);
      final source = account.source!;
      expect(source.privacy, 'public');
      expect(source.sensitive, false);
      expect(source.language, isNull);
      expect(source.followRequestsCount, 0);
      expect(source.quotePolicy, 'public');

      // role
      expect(account.role, isNotNull);
      final role = account.role!;
      expect(role.id, '3');
      expect(role.name, 'Owner');
      expect(role.permissions, '2097151');
      expect(role.highlighted, true);
    });
  });
}
