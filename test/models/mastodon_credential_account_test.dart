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

    test('role id is coerced from int (instances returning numeric ids)', () {
      // flexibleIdFromJson の導入理由そのものの検証。実サーバーは文字列で
      // 返すため fixture では通らない経路
      final role = MastodonRole.fromJson(const {'id': 3, 'name': 'Owner'});

      expect(role.id, '3');
      expect(role.name, 'Owner');
    });

    test('role id is null when the server omits it', () {
      final role = MastodonRole.fromJson(const {'name': 'Owner'});

      expect(role.id, isNull);
      expect(role.name, 'Owner');
    });
  });

  group('MastodonCredentialAccount - parity with MastodonAccount', () {
    Map<String, dynamic> loadCredentials() =>
        jsonDecode(
              File('test/fixtures/verify_credentials.json').readAsStringSync(),
            )
            as Map<String, dynamic>;

    test('deserializes uri, indexable and group', () {
      final account = MastodonCredentialAccount.fromJson(loadCredentials());

      expect(account.uri, startsWith('https://mastodon.test/ap/users/'));
      expect(account.uri, isNot(account.url));
      expect(account.indexable, false);
      expect(account.group, false);
    });

    test('deserializes the 4.6.0 fields that were added to '
        'MastodonAccount only', () {
      final account = MastodonCredentialAccount.fromJson(loadCredentials());

      expect(account.avatarDescription, '');
      expect(account.headerDescription, '');
      expect(account.showFeatured, true);
      expect(account.showMedia, true);
      expect(account.showMediaReplies, true);

      expect(account.featureApproval, isNotNull);
      expect(account.featureApproval!.automatic, isEmpty);
      expect(account.featureApproval!.manual, isEmpty);
      expect(account.featureApproval!.currentUser, 'denied');
    });

    test('deserializes roles alongside the full role', () {
      final account = MastodonCredentialAccount.fromJson(loadCredentials());

      // roles は縮約形（id/name/color）、role は権限まで含む完全形
      expect(account.roles, hasLength(1));
      expect(account.roles.first.name, 'Owner');
      expect(account.roles.first.permissions, isNull);
      expect(account.role!.name, 'Owner');
      expect(account.role!.permissions, isNotEmpty);
    });

    test('every key MastodonAccount reads is also read here', () {
      final json = loadCredentials();
      final asAccount = MastodonAccount.fromJson(json);
      final asCredentials = MastodonCredentialAccount.fromJson(json);

      // PR #9 で片側にだけフィールドを足したことによるドリフトの再発防止
      expect(asCredentials.uri, asAccount.uri);
      expect(asCredentials.indexable, asAccount.indexable);
      expect(asCredentials.group, asAccount.group);
      expect(asCredentials.avatarDescription, asAccount.avatarDescription);
      expect(asCredentials.headerDescription, asAccount.headerDescription);
      expect(asCredentials.showFeatured, asAccount.showFeatured);
      expect(asCredentials.showMedia, asAccount.showMedia);
      expect(asCredentials.showMediaReplies, asAccount.showMediaReplies);
      expect(asCredentials.hideCollections, asAccount.hideCollections);
      expect(asCredentials.noindex, asAccount.noindex);
      expect(
        asCredentials.roles.map((r) => r.name),
        asAccount.roles.map((r) => r.name),
      );
      expect(
        asCredentials.featureApproval!.currentUser,
        asAccount.featureApproval!.currentUser,
      );
    });
  });
}
