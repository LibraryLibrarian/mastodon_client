import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminReport.fromJson', () {
    test('deserializes list of reports from fixture', () {
      final file = File('test/fixtures/admin/reports.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final reports = list
          .map((e) => MastodonAdminReport.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(reports, hasLength(1));
    });

    test('first report has correct top-level fields', () {
      final file = File('test/fixtures/admin/reports.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final reports = list
          .map((e) => MastodonAdminReport.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = reports.first;
      expect(first.id, '1');
      expect(first.actionTaken, isFalse);
      expect(first.actionTakenAt, isNull);
      expect(first.category, 'other');
      expect(first.comment, 'Test report for fixtures');
      expect(first.forwarded, isFalse);
      expect(first.createdAt, isNotNull);
      expect(first.updatedAt, isNotNull);
      expect(first.statuses, isEmpty);
      expect(first.rules, isEmpty);
    });

    test('first report has correct account field', () {
      final file = File('test/fixtures/admin/reports.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final reports = list
          .map((e) => MastodonAdminReport.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = reports.first;
      expect(first.account, isNotNull);
      expect(first.account!.id, '116266741324121431');
      expect(first.account!.username, 'testadmin');
      expect(first.account!.email, 'admin@localhost');
    });

    test('first report has correct target_account field', () {
      final file = File('test/fixtures/admin/reports.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final reports = list
          .map((e) => MastodonAdminReport.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = reports.first;
      expect(first.targetAccount, isNotNull);
      expect(first.targetAccount!.id, '116266789448809503');
      expect(first.targetAccount!.username, 'testuser2');
      expect(first.targetAccount!.email, 'user2@localhost');
      expect(first.assignedAccount, isNull);
      expect(first.actionTakenByAccount, isNull);
    });
  });
}
