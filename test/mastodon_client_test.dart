import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  test('MastodonClient can be instantiated', () {
    final client = MastodonClient(
      baseUrl: 'https://mastodon.social',
      accessToken: 'test_token',
    );
    expect(client, isNotNull);
  });

  test('MastodonClient can be instantiated without access token', () {
    final client = MastodonClient(baseUrl: 'https://mastodon.social');
    expect(client, isNotNull);
  });

  test('capability detection is reachable through the public client', () {
    final client = MastodonClient(
      baseUrl: 'https://mastodon.social',
      enableLog: false,
    );

    final Future<MastodonServerCapabilities> Function() detect =
        client.instance.detectCapabilities;

    expect(detect, isNotNull);
  });

  test('MastodonClient.streaming is lazy and cached', () async {
    final client = MastodonClient(
      baseUrl: 'https://mastodon.social',
      accessToken: 'test_token',
      enableLog: false,
    );

    final first = client.streaming;
    final second = client.streaming;

    expect(identical(first, second), isTrue);
    expect(first.state, MastodonStreamingConnectionState.disconnected);
    await client.dispose();
  });

  test('dispose does not create streaming when it was never used', () async {
    final client = MastodonClient(
      baseUrl: 'https://mastodon.social',
      accessToken: 'test_token',
      enableLog: false,
    );

    await client.dispose();

    expect(() => client.streaming, throwsStateError);
  });

  test('streaming requires an access token', () async {
    final client = MastodonClient(
      baseUrl: 'https://mastodon.social',
      enableLog: false,
    );

    expect(() => client.streaming, throwsStateError);
    await client.dispose();
  });
}
