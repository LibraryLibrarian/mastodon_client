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

      expect(account.id, isNotEmpty);
      expect(account.username, 'e2e_admin');
      expect(account.acct, 'e2e_admin');
      expect(account.locked, false);
      expect(account.bot, false);
      expect(account.url, 'https://mastodon.test/@e2e_admin');
      expect(
        account.avatarUrl,
        'https://mastodon.test/avatars/original/missing.png',
      );
      expect(
        account.headerUrl,
        'https://mastodon.test/headers/original/missing.png',
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
      expect(role.id, isNotEmpty);
      expect(role.name, 'Owner');
      expect(role.permissions, isNotEmpty);
      expect(role.highlighted, true);
    });
  });
}
