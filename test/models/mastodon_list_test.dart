import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonList.fromJson', () {
    test('deserializes single list from fixture', () {
      final file = File('test/fixtures/list.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final list = MastodonList.fromJson(json);

      expect(list.id, equals('1'));
      expect(list.title, equals('Test List'));
      expect(list.repliesPolicy, equals('list'));
      expect(list.exclusive, isFalse);
    });

    test('deserializes list array from lists.json fixture', () {
      final file = File('test/fixtures/lists.json');
      final jsonList = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final lists = jsonList
          .map((e) => MastodonList.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(lists, hasLength(1));

      final first = lists.first;
      expect(first.id, equals('1'));
      expect(first.title, equals('Test List'));
      expect(first.repliesPolicy, equals('list'));
      expect(first.exclusive, isFalse);
    });
  });
}
