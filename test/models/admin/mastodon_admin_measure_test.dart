import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminMeasure.fromJson', () {
    test('deserializes list of measures from fixture', () {
      final file = File('test/fixtures/admin/measures.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final measures = list
          .map((e) => MastodonAdminMeasure.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(measures, hasLength(1));
    });

    test('first measure has correct top-level fields', () {
      final file = File('test/fixtures/admin/measures.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final measures = list
          .map((e) => MastodonAdminMeasure.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = measures.first;
      expect(first.key, 'active_users');
      expect(first.unit, isNull);
      expect(first.total, '0');
      expect(first.previousTotal, '0');
      expect(first.humanValue, isNull);
    });

    test('first measure data has correct entries', () {
      final file = File('test/fixtures/admin/measures.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final measures = list
          .map((e) => MastodonAdminMeasure.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = measures.first;
      expect(first.data, hasLength(21));

      final firstData = first.data.first;
      expect(firstData.date, '2026-03-01T00:00:00Z');
      expect(firstData.value, '0');

      // last data entry has value '2'
      final lastData = first.data.last;
      expect(lastData.date, '2026-03-21T00:00:00Z');
      expect(lastData.value, '2');
    });
  });
}
