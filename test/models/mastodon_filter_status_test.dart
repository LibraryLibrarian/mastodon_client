import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonFilterStatus.fromJson', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/filter_statuses.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final filterStatuses = list
          .map((e) => MastodonFilterStatus.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(filterStatuses, hasLength(1));

      final first = filterStatuses.first;
      expect(first.id, equals('1'));
      expect(first.statusId, equals('116266764647790665'));
    });
  });
}
