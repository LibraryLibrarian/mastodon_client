import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonFilter.fromJson', () {
    test('deserializes single filter from fixture', () {
      final file = File('test/fixtures/filter.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final filter = MastodonFilter.fromJson(json);

      expect(filter.id, equals('1'));
      expect(filter.title, equals('Test Filter'));
      expect(filter.context, equals(['home', 'public']));
      expect(filter.filterAction, equals(MastodonFilterAction.warn));
      expect(filter.expiresAt, isNull);
      expect(filter.keywords, hasLength(1));
      expect(filter.keywords.first.id, equals('1'));
      expect(filter.keywords.first.keyword, equals('badword'));
      expect(filter.keywords.first.wholeWord, isTrue);
      expect(filter.statuses, isEmpty);
    });

    test('deserializes list from filters.json fixture', () {
      final file = File('test/fixtures/filters.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final filters = list
          .map((e) => MastodonFilter.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(filters, hasLength(1));

      final filter = filters.first;
      expect(filter.id, equals('1'));
      expect(filter.title, equals('Test Filter'));
      expect(filter.context, equals(['home', 'public']));
      expect(filter.filterAction, equals(MastodonFilterAction.warn));
      expect(filter.keywords, hasLength(1));
      expect(filter.statuses, isEmpty);
    });

    test('filterAction falls back to warn for a value not yet known to '
        'this client', () {
      final file = File('test/fixtures/filter.json');
      final json = (jsonDecode(file.readAsStringSync()) as Map<String, dynamic>)
        ..['filter_action'] = 'someFutureActionNotInEnum';

      final filter = MastodonFilter.fromJson(json);

      expect(filter.filterAction, MastodonFilterAction.warn);
    });
  });

  group('MastodonFilterKeyword.fromJson', () {
    test('deserializes list from filter_keywords.json fixture', () {
      final file = File('test/fixtures/filter_keywords.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final keywords = list
          .map((e) => MastodonFilterKeyword.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(keywords, hasLength(1));

      final kw = keywords.first;
      expect(kw.id, equals('1'));
      expect(kw.keyword, equals('badword'));
      expect(kw.wholeWord, isTrue);
    });
  });

  group('MastodonFilterResult.fromJson', () {
    test('deserializes a filter result from a live filtered status', () {
      final file = File('test/fixtures/status_filtered.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final results = (json['filtered'] as List<dynamic>)
          .map((e) => MastodonFilterResult.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(results, hasLength(1));

      final result = results.first;
      expect(result.filter.id, isNotEmpty);
      expect(result.filter.title, isNotEmpty);
      expect(result.filter.filterAction, MastodonFilterAction.warn);
      expect(result.keywordMatches, isNotEmpty);
      expect(result.statusMatches, isEmpty);
    });

    test('status_matches null is coerced to an empty list', () {
      // 実サーバーは status_matches を null で返す。デフォルト値が無いと
      // ここでパースが落ちる
      final result = MastodonFilterResult.fromJson(<String, dynamic>{
        'filter': <String, dynamic>{
          'id': '1',
          'title': 'spoilers',
          'context': <String>['home'],
          'expires_at': null,
          'filter_action': 'hide',
        },
        'keyword_matches': <String>['spoiler'],
        'status_matches': null,
      });

      expect(result.filter.filterAction, MastodonFilterAction.hide);
      expect(result.keywordMatches, <String>['spoiler']);
      expect(result.statusMatches, isEmpty);
    });

    test('the nested filter never carries its rules', () {
      // FilterResult 内の filter は rules_requested なしで直列化されるため
      // keywords / statuses は返らない。ルールは v2 filters API で取得する
      final result = MastodonFilterResult.fromJson(<String, dynamic>{
        'filter': <String, dynamic>{
          'id': '1',
          'title': 'spoilers',
          'context': <String>['home'],
          'filter_action': 'warn',
        },
      });

      expect(result.filter.keywords, isEmpty);
      expect(result.filter.statuses, isEmpty);
      expect(result.keywordMatches, isEmpty);
      expect(result.statusMatches, isEmpty);
    });
  });
}
