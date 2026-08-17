import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  test('represents all twelve official stream names', () {
    final streams = <MastodonStream>[
      const MastodonStream.user(),
      const MastodonStream.userNotification(),
      const MastodonStream.public(),
      const MastodonStream.public(local: true),
      const MastodonStream.public(remote: true),
      const MastodonStream.public(onlyMedia: true),
      const MastodonStream.public(local: true, onlyMedia: true),
      const MastodonStream.public(remote: true, onlyMedia: true),
      const MastodonStream.hashtag('dart'),
      const MastodonStream.hashtag('dart', local: true),
      const MastodonStream.direct(),
      const MastodonStream.list('42'),
    ];

    expect(streams.map((stream) => stream.name), [
      'user',
      'user:notification',
      'public',
      'public:local',
      'public:remote',
      'public:media',
      'public:local:media',
      'public:remote:media',
      'hashtag',
      'hashtag:local',
      'direct',
      'list',
    ]);
  });

  test('rejects local and remote public flags together', () {
    expect(
      () => MastodonStream.public(local: true, remote: true),
      throwsA(isA<AssertionError>()),
    );
  });

  test('normalizes hashtag reference-counting keys', () {
    const upper = MastodonStream.hashtag('Dart');
    const lower = MastodonStream.hashtag('dart');

    expect(upper.params, {'tag': 'Dart'});
    expect(upper.key, lower.key);
  });

  test('uses the list ID in the list parameter and structured key', () {
    const stream = MastodonStream.list('42');

    expect(stream.params, {'list': '42'});
    expect(stream.key, MastodonStream.keyFor('list', const {'list': '42'}));
  });

  test('builds keys from channel names and normalized parameters', () {
    expect(
      MastodonStream.keyFor('hashtag', const {'tag': 'Dart'}),
      MastodonStream.keyFor('hashtag', const {'tag': 'dart'}),
    );
    expect(
      MastodonStream.keyFor('hashtag', const {'tag': 'dart'}),
      isNot(MastodonStream.keyFor('hashtag:dart', const {})),
    );
    expect(
      const MastodonStream.public(local: true).key,
      MastodonStream.keyFor('public:local', const {}),
    );
  });
}
