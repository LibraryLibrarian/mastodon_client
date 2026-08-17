@Tags(['e2e'])
library;

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

import 'e2e_env.dart';

/// fediverse_e2e 環境(mastodon.test)に対する Streaming API のE2Eテスト
void main() {
  final env = E2eEnv.tryLoad();
  if (env == null) {
    test('mastodon streaming e2e', () {}, skip: E2eEnv.skipReason);
    return;
  }

  late MastodonClient client;
  late MastodonStreaming streaming;

  setUpAll(() {
    client = env.createMastodonClient();
    streaming = env.createMastodonStreaming();
  });

  tearDownAll(() async {
    await streaming.dispose();
    await client.dispose();
  });

  group('health', () {
    test('streaming health returns OK without authentication', () async {
      expect(await client.health.checkStreaming(), isTrue);
    });
  });

  group('connection', () {
    test('connect reaches the connected state', () async {
      await streaming.connect();
      expect(streaming.isConnected, isTrue);
    });
  });

  group('user stream', () {
    test('delivers an update for a status posted over REST', () async {
      await streaming.connect();
      final subscription = await streaming.subscribe(
        const MastodonStream.user(),
      );
      addTearDown(subscription.cancel);

      final marker = 'e2e streaming ${DateTime.now().millisecondsSinceEpoch}';
      final received = subscription.statuses
          .firstWhere((status) => status.content.contains(marker))
          .timeout(const Duration(seconds: 60));

      // 購読が確立してから投稿しないとイベントを取りこぼす
      final result = await client.statuses.create(
        MastodonStatusCreateRequest(status: marker),
      );
      final created = (result as MastodonStatusCreated).status;
      addTearDown(() => client.statuses.delete(created.id));

      expect((await received).id, created.id);
    });

    test('reports a subscription error for an unknown stream', () async {
      await streaming.connect();

      await expectLater(
        streaming.subscribeRaw('definitely-not-a-stream'),
        throwsA(
          isA<MastodonStreamingSubscriptionException>().having(
            (error) => error.status,
            'status',
            400,
          ),
        ),
      );
    });
  });
}
