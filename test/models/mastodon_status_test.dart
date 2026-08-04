import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonStatus.fromJson - status.json', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/status.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final status = MastodonStatus.fromJson(json);

      expect(status.id, isNotEmpty);
      expect(status.sensitive, false);
      expect(status.spoilerText, '');
      expect(status.visibility, MastodonVisibility.public);
      expect(status.content, isNotEmpty);
      expect(status.favourited, true);
      expect(status.reblogged, true);
      expect(status.bookmarked, true);
      expect(status.pinned, true);
      expect(status.reblog, isNull);
      expect(status.poll, isNull);
      expect(status.mediaAttachments, isEmpty);
      expect(status.mentions, isEmpty);
      expect(status.tags, isNotEmpty);
      expect(status.uri, startsWith('https://mastodon.test/'));
      expect(status.url, startsWith('https://mastodon.test/'));

      // nested account
      expect(status.account.id, isNotEmpty);
      expect(status.account.username, 'md_eve');
    });

    test('taggedCollections is present in the response and parses empty', () {
      final file = File('test/fixtures/status.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      // 閉域環境ではコレクションにタグ付けされた投稿を作れないため、
      // ここではフィールドが実応答に存在することと空配列になることを固定する
      expect(json.containsKey('tagged_collections'), isTrue);
      expect(MastodonStatus.fromJson(json).taggedCollections, isEmpty);
    });
  });

  group('MastodonStatus.taggedCollections (Mastodon 4.6.0)', () {
    test('deserializes tagged collections', () {
      final file = File('test/fixtures/status.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final collection =
          jsonDecode(
                File('test/fixtures/collection.json').readAsStringSync(),
              )
              as Map<String, dynamic>;

      final status = MastodonStatus.fromJson({
        ...json,
        'tagged_collections': <Map<String, dynamic>>[collection],
      });

      expect(status.taggedCollections, hasLength(1));
      expect(status.taggedCollections.first.id, collection['id']);
      expect(status.taggedCollections.first.name, collection['name']);
    });

    test('defaults to an empty list on servers older than 4.6.0', () {
      final file = File('test/fixtures/status.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>
        ..remove('tagged_collections');

      expect(MastodonStatus.fromJson(json).taggedCollections, isEmpty);
    });
  });

  group('MastodonStatus.fromJson - status_with_poll.json', () {
    test('deserializes poll from fixture', () {
      final file = File('test/fixtures/status_with_poll.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final status = MastodonStatus.fromJson(json);

      expect(status.id, '116266784798524453');
      expect(status.content, '<p>What is your favorite language?</p>');
      expect(status.poll, isNotNull);

      final poll = status.poll!;
      expect(poll.id, '1');
      expect(poll.expired, false);
      expect(poll.multiple, false);
      expect(poll.votesCount, 0);
      expect(poll.voted, true);
      expect(poll.options, hasLength(3));
      expect(poll.options.first.title, 'Dart');
      expect(poll.options[1].title, 'Kotlin');
      expect(poll.options[2].title, 'Swift');
    });
  });

  group('MastodonStatus.fromJson (list) - timelines_home.json', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/timelines_home.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final statuses = list
          .map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(statuses, isNotEmpty);

      final first = statuses.first;
      expect(first.id, isNotEmpty);
      expect(first.visibility, MastodonVisibility.public);
      expect(first.sensitive, false);
      expect(first.account.username, isNotEmpty);
      expect(first.tags, hasLength(greaterThanOrEqualTo(0)));
    });
  });

  group('MastodonStatusContext.fromJson - status_context.json', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/status_context.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final context = MastodonStatusContext.fromJson(json);

      expect(context.ancestors, isEmpty);
      expect(context.descendants, hasLength(1));

      final descendant = context.descendants.first;
      expect(descendant.id, isNotEmpty);
      expect(descendant.content, isNotEmpty);
      expect(descendant.inReplyToId, isNotEmpty);
      expect(descendant.inReplyToAccountId, isNotEmpty);
      expect(descendant.visibility, MastodonVisibility.public);
      expect(descendant.account.acct, contains('@'));
    });
  });

  group('MastodonStatus.fromJson - unknown visibility', () {
    test('visibility falls back to public for a value not yet known to '
        'this client', () {
      final file = File('test/fixtures/status.json');
      final json = (jsonDecode(file.readAsStringSync()) as Map<String, dynamic>)
        ..['visibility'] = 'someFutureVisibilityNotInEnum';

      final status = MastodonStatus.fromJson(json);

      expect(status.visibility, MastodonVisibility.public);
    });
  });
}
