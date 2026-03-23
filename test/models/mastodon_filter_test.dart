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
  });

  group('MastodonFilterKeyword.fromJson', () {
    test('deserializes list from filter_keywords.json fixture', () {
      final file = File('test/fixtures/filter_keywords.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final keywords = list
          .map(
            (e) => MastodonFilterKeyword.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      expect(keywords, hasLength(1));

      final kw = keywords.first;
      expect(kw.id, equals('1'));
      expect(kw.keyword, equals('badword'));
      expect(kw.wholeWord, isTrue);
    });
  });
}
