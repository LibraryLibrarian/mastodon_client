@Tags(['e2e'])
library;

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

import 'e2e_env.dart';

/// fediverse_e2e 環境の連合(mastodon.test ⇄ misskey.test)を使うテスト
void main() {
  final env = E2eEnv.tryLoad();
  if (env == null) {
    test('mastodon federation e2e', () {}, skip: E2eEnv.skipReason);
    return;
  }

  late MastodonClient client;

  setUpAll(() {
    client = env.createMastodonClient();
  });

  group('search', () {
    test('resolves a remote Misskey user via WebFinger', () async {
      final result = await client.search.search(
        'e2e_alice@misskey.test',
        type: 'accounts',
        resolve: true,
      );
      expect(result.accounts, isNotEmpty);
      final account = result.accounts.first;
      expect(account.acct, 'e2e_alice@misskey.test');
    });
  });

  group('instance peers', () {
    test('fetchPeers includes misskey.test', () async {
      final peers = await client.instance.fetchPeers();
      expect(peers, contains('misskey.test'));
    });
  });

  group('note delivery', () {
    test('a remote Misskey note reaches the home timeline', () async {
      // e2e_bob は e2e_alice(misskey.test) をフォローしている前提
      // (fediverse_e2e の make check で相互フォロー済み)。
      // Misskey側で投稿する代わりに、既存のリモート投稿がホームTLに
      // 現れることを確認する(投稿起点の確認は misskey_client 側E2Eが担う)
      final page = await pollUntil(() async {
        final result = await client.timelines.fetchHome(limit: 40);
        final hasRemote = result.items.any(
          (s) => s.account.acct == 'e2e_alice@misskey.test',
        );
        return hasRemote ? result : null;
      });
      expect(page.items, isNotEmpty);
    });
  });
}
