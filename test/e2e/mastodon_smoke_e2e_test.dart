@Tags(['e2e'])
library;

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

import 'e2e_env.dart';

/// fediverse_e2e 環境(mastodon.test)に対する単一サーバーのスモークテスト
void main() {
  final env = E2eEnv.tryLoad();
  if (env == null) {
    test('mastodon smoke e2e', () {}, skip: E2eEnv.skipReason);
    return;
  }

  late MastodonClient client;

  setUpAll(() {
    client = env.createMastodonClient();
  });

  group('instance', () {
    test('fetch returns instance metadata', () async {
      final instance = await client.instance.fetch();
      expect(instance.domain, 'mastodon.test');
      expect(instance.version, isNotEmpty);
    });
  });

  group('accounts', () {
    test('verifyCredentials returns the authenticated user', () async {
      final me = await client.accounts.verifyCredentials();
      expect(me.username, 'e2e_bob');
    });
  });

  group('statuses', () {
    test('create -> fetch -> delete round trip', () async {
      final marker = 'e2e smoke ${DateTime.now().millisecondsSinceEpoch}';
      final result = await client.statuses.create(
        MastodonStatusCreateRequest(status: marker),
      );
      expect(result, isA<MastodonStatusCreated>());
      final created = (result as MastodonStatusCreated).status;
      expect(created.content, contains(marker));

      final fetched = await client.statuses.fetch(created.id);
      expect(fetched.id, created.id);

      await client.statuses.delete(created.id);
    });

    test('home timeline returns statuses', () async {
      final page = await client.timelines.fetchHome(limit: 5);
      expect(page.items, isA<List<MastodonStatus>>());
    });
  });

  group('admin', () {
    test('adminAccounts.fetch works with an admin-scoped token', () async {
      final adminClient = env.createMastodonClient(admin: true);
      final page = await adminClient.adminAccounts.fetch();
      expect(
        page.items.map((a) => a.username),
        containsAll(['e2e_admin', 'e2e_bob']),
      );
    });
  });
}
