@Tags(['e2e'])
library;

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

import 'e2e_env.dart';

/// fediverse_e2e 環境(fedibird.test)に対する互換性テスト。
///
/// Fedibird は Mastodon 3.4 系のフォークであり、mastodon_client が前提と
/// している 4.x のエンドポイントには存在しないものがある。
/// ここでは「動くもの」と「動かないもの」の両方を実サーバーで固定し、
/// アプリ側が機能判定を行う際の根拠とする。
void main() {
  final env = E2eEnv.tryLoad();
  if (env == null) {
    test('fedibird compat e2e', () {}, skip: E2eEnv.skipReason);
    return;
  }
  if (!env.hasFedibird) {
    test('fedibird compat e2e', () {}, skip: E2eEnv.fedibirdSkipReason);
    return;
  }

  late MastodonClient client;
  late MastodonClient adminClient;

  setUpAll(() {
    client = env.createFedibirdClient();
    adminClient = env.createFedibirdClient(admin: true);
  });

  group('instance', () {
    test('v1 instance works and reports 3.4.1', () async {
      // fetchV1はMastodon 4.0で非推奨だが、3.4系サーバーでは唯一の手段。
      // 非推奨を理由に削除するとFedibird対応が壊れる
      // ignore: deprecated_member_use_from_same_package
      final instance = await client.instance.fetchV1();
      expect(instance.uri, 'fedibird.test');
      expect(instance.version, '3.4.1');
    });

    test('v2 instance is NOT available (added in Mastodon 4.0)', () async {
      // アプリ側は instance.fetch() の 404 を機能判定に使える
      await expectLater(
        client.instance.fetch(),
        throwsA(isA<MastodonNotFoundException>()),
      );
    });

    test('peers and rules work', () async {
      final peers = await client.instance.fetchPeers();
      expect(peers, contains('mastodon.test'));
      final rules = await client.instance.fetchRules();
      expect(rules, isA<List<MastodonInstanceRule>>());
    });

    test('domain_blocks is NOT available', () async {
      await expectLater(
        client.instance.fetchDomainBlocks(),
        throwsA(isA<MastodonNotFoundException>()),
      );
    });
  });

  group('core APIs that work', () {
    test('verifyCredentials returns the authenticated user', () async {
      final me = await client.accounts.verifyCredentials();
      expect(me.username, 'e2e_carol');
    });

    test('status create -> fetch -> delete round trip', () async {
      final marker = 'e2e fedibird ${DateTime.now().millisecondsSinceEpoch}';
      final result = await client.statuses.create(
        MastodonStatusCreateRequest(status: marker),
      );
      final created = (result as MastodonStatusCreated).status;
      expect(created.content, contains(marker));

      final fetched = await client.statuses.fetch(created.id);
      expect(fetched.id, created.id);

      await client.statuses.delete(created.id);
    });

    test('home timeline, notifications, custom emojis', () async {
      final timeline = await client.timelines.fetchHome(limit: 5);
      expect(timeline.items, isA<List<MastodonStatus>>());

      final notifications = await client.notifications.fetch(limit: 5);
      expect(notifications.items, isNotNull);

      final emojis = await client.customEmojis.fetch();
      expect(emojis, isA<List<MastodonCustomEmoji>>());
    });

    test('markers, preferences, lists, bookmarks', () async {
      expect(await client.preferences.fetch(), isNotNull);
      expect(await client.lists.fetch(), isA<List<MastodonList>>());
      final bookmarks = await client.bookmarks.fetch();
      expect(bookmarks.items, isA<List<MastodonStatus>>());
    });
  });

  group('APIs that are NOT available on 3.4', () {
    test('v2 filters are NOT available (v1 filters exist on the server)',
        () async {
      await expectLater(
        client.filters.fetch(),
        throwsA(isA<MastodonNotFoundException>()),
      );
    });

    test('all trends endpoints are NOT available', () async {
      // 3.4 は旧来の `/api/v1/trends` (タグを返す) のみを持ち、
      // ライブラリが使う tags/statuses/links の分割パスは 4.0 以降
      await expectLater(
        client.trends.fetchTags(),
        throwsA(isA<MastodonNotFoundException>()),
      );
      await expectLater(
        client.trends.fetchStatuses(),
        throwsA(isA<MastodonNotFoundException>()),
      );
      await expectLater(
        client.trends.fetchLinks(),
        throwsA(isA<MastodonNotFoundException>()),
      );
    });

    test('followed tags are NOT available', () async {
      await expectLater(
        client.followedTags.fetch(),
        throwsA(isA<MastodonNotFoundException>()),
      );
    });
  });

  group('admin APIs', () {
    test('admin accounts and reports work', () async {
      final accounts = await adminClient.adminAccounts.fetch();
      expect(
        accounts.items.map((a) => a.username),
        containsAll(['e2e_admin', 'e2e_carol']),
      );
      final reports = await adminClient.adminReports.fetch();
      expect(reports.items, isNotNull);
    });

    test('admin v2 accounts and later admin APIs are NOT available',
        () async {
      await expectLater(
        adminClient.adminAccounts.fetchV2(),
        throwsA(isA<MastodonNotFoundException>()),
      );
      await expectLater(
        adminClient.adminDomainBlocks.fetch(),
        throwsA(isA<MastodonNotFoundException>()),
      );
      await expectLater(
        adminClient.adminIpBlocks.fetch(),
        throwsA(isA<MastodonNotFoundException>()),
      );
    });
  });

  group('federation', () {
    test('resolves remote users from both other servers', () async {
      final mastodonResult = await client.search.search(
        'e2e_bob@mastodon.test',
        type: 'accounts',
        resolve: true,
      );
      expect(mastodonResult.accounts.first.acct, 'e2e_bob@mastodon.test');

      final misskeyResult = await client.search.search(
        'e2e_alice@misskey.test',
        type: 'accounts',
        resolve: true,
      );
      expect(misskeyResult.accounts.first.acct, 'e2e_alice@misskey.test');
    });

    test('peers include both federated servers', () async {
      final peers = await client.instance.fetchPeers();
      expect(peers, containsAll(['mastodon.test', 'misskey.test']));
    });
  });
}
