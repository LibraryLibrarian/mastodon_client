import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminCohort.fromJson', () {
    test('deserializes list of cohorts from fixture', () {
      final file = File('test/fixtures/admin/retention.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final cohorts = list
          .map((e) => MastodonAdminCohort.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(cohorts, isNotEmpty);
    });

    test('first cohort has correct top-level fields', () {
      final file = File('test/fixtures/admin/retention.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final cohorts = list
          .map((e) => MastodonAdminCohort.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = cohorts.first;
      expect(first.frequency, 'day');
      expect(first.period, isNotNull);
      // period corresponds to "2026-03-01T00:00:00+00:00"
      expect(first.period!.year, 2026);
      expect(first.period!.month, 3);
      expect(first.period!.day, 1);
    });

    test('first cohort data entries have correct fields', () {
      final file = File('test/fixtures/admin/retention.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final cohorts = list
          .map((e) => MastodonAdminCohort.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = cohorts.first;
      expect(first.data, isNotEmpty);

      final firstData = first.data.first;
      expect(firstData.date, isNotNull);
      expect(firstData.date!.year, 2026);
      expect(firstData.date!.month, 3);
      expect(firstData.date!.day, 1);
      expect(firstData.rate, 0.0);
      expect(firstData.value, '0');
    });
  });
}
