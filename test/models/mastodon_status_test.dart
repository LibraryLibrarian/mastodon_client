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

      expect(status.id, '116266764647790665');
      expect(status.sensitive, false);
      expect(status.spoilerText, '');
      expect(status.visibility, MastodonVisibility.public);
      expect(status.language, 'en');
      expect(
        status.content,
        '<p>Hello, this is a test post for API testing!</p>',
      );
      expect(status.reblogsCount, 1);
      expect(status.favouritesCount, 1);
      expect(status.repliesCount, 1);
      expect(status.favourited, true);
      expect(status.reblogged, true);
      expect(status.bookmarked, true);
      expect(status.pinned, true);
      expect(status.reblog, isNull);
      expect(status.poll, isNull);
      expect(status.mediaAttachments, isEmpty);
      expect(status.mentions, isEmpty);
      expect(status.tags, isEmpty);
      expect(
        status.uri,
        'https://localhost:3001/ap/users/116266741324121431/statuses/116266764647790665',
      );
      expect(
        status.url,
        'https://localhost:3001/@testadmin/116266764647790665',
      );

      // nested account
      expect(status.account.id, '116266741324121431');
      expect(status.account.username, 'testadmin');
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
      expect(first.id, '116266784829412747');
      expect(first.visibility, MastodonVisibility.public);
      expect(first.language, 'en');
      expect(first.sensitive, false);
      expect(first.account.username, 'testadmin');
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
      expect(descendant.id, '116266784787341685');
      expect(descendant.content, '<p>This is a reply for testing context</p>');
      expect(descendant.inReplyToId, '116266764647790665');
      expect(descendant.inReplyToAccountId, '116266741324121431');
      expect(descendant.visibility, MastodonVisibility.public);
      expect(descendant.account.username, 'testadmin');
    });
  });
}
