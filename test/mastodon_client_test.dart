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
}
