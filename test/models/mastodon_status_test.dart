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
          jsonDecode(File('test/fixtures/collection.json').readAsStringSync())
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

  group('MastodonStatus.application', () {
    test('deserializes the reduced application entity', () {
      final file = File('test/fixtures/status.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final status = MastodonStatus.fromJson(json);

      // 投稿APIが返す application は {name, website} のみで、
      // MastodonApplication のような id / scopes / redirect_uris は含まない
      expect(status.application, isNotNull);
      expect(status.application!.name, isNotEmpty);
      expect(status.application!.website, isNull);
    });

    test('is null when the author does not disclose it', () {
      final file = File('test/fixtures/timelines_public.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final json = list.first as Map<String, dynamic>;

      expect(json.containsKey('application'), isFalse);
      expect(MastodonStatus.fromJson(json).application, isNull);
    });
  });

  group('MastodonStatus.card', () {
    test('deserializes a link preview card embedded in the status', () {
      final json =
          jsonDecode(File('test/fixtures/status.json').readAsStringSync())
              as Map<String, dynamic>;
      final card =
          jsonDecode(File('test/fixtures/preview_card.json').readAsStringSync())
              as Map<String, dynamic>;

      final status = MastodonStatus.fromJson({...json, 'card': card});

      expect(status.card, isNotNull);
      expect(status.card!.url, card['url']);
      expect(status.card!.title, card['title']);
      expect(status.card!.type, MastodonPreviewCardType.link);
    });

    test('is null for a status without a link', () {
      final json =
          jsonDecode(File('test/fixtures/status.json').readAsStringSync())
              as Map<String, dynamic>;

      expect(json['card'], isNull);
      expect(MastodonStatus.fromJson(json).card, isNull);
    });
  });

  group('MastodonStatus.filtered', () {
    test('deserializes filter results from a live filtered response', () {
      final file = File('test/fixtures/status_filtered.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final status = MastodonStatus.fromJson(json);

      expect(status.filtered, hasLength(1));

      final result = status.filtered.first;
      expect(result.filter.id, isNotEmpty);
      expect(result.filter.title, isNotEmpty);
      expect(result.filter.context, contains('public'));
      expect(result.filter.filterAction, MastodonFilterAction.warn);
      expect(result.keywordMatches, isNotEmpty);

      // サーバーは status_matches を null で返す（空配列ではない）
      final rawFiltered = json['filtered'] as List<dynamic>;
      expect(
        (rawFiltered.first as Map<String, dynamic>)['status_matches'],
        isNull,
      );
      expect(result.statusMatches, isEmpty);

      // FilterResult 内の filter はルールを含まない形で返る
      expect(result.filter.keywords, isEmpty);
      expect(result.filter.statuses, isEmpty);
    });

    test('is empty for unauthenticated responses that omit the key', () {
      final json =
          jsonDecode(File('test/fixtures/status.json').readAsStringSync())
                as Map<String, dynamic>
            ..remove('filtered');

      expect(MastodonStatus.fromJson(json).filtered, isEmpty);
    });
  });

  group('MastodonStatus quote fields (Mastodon 4.5.0)', () {
    test('deserializes quoteApproval and quotesCount', () {
      final file = File('test/fixtures/status.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final status = MastodonStatus.fromJson(json);

      expect(status.quotesCount, 0);
      expect(status.quoteApproval, isNotNull);
      expect(status.quoteApproval!.automatic, contains('public'));
      expect(status.quoteApproval!.manual, isEmpty);
      expect(status.quoteApproval!.currentUser, 'automatic');
    });

    test('falls back on servers older than 4.5.0', () {
      final json =
          jsonDecode(File('test/fixtures/status.json').readAsStringSync())
                as Map<String, dynamic>
            ..remove('quote_approval')
            ..remove('quotes_count');
      final status = MastodonStatus.fromJson(json);

      expect(status.quoteApproval, isNull);
      expect(status.quotesCount, 0);
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
