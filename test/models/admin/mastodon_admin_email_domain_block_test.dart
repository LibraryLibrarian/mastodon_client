import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminEmailDomainBlock.fromJson', () {
    test('deserializes list of email domain blocks from fixture', () {
      final file = File('test/fixtures/admin/email_domain_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map(
            (e) => MastodonAdminEmailDomainBlock.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      expect(blocks, hasLength(1));
    });

    test('first email domain block has correct fields', () {
      final file = File('test/fixtures/admin/email_domain_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map(
            (e) => MastodonAdminEmailDomainBlock.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      final first = blocks.first;
      expect(first.id, '1');
      expect(first.domain, 'bademail.example.com');
      expect(first.createdAt, isNotNull);
      expect(first.createdAt, DateTime.utc(2026, 3, 21, 10, 56, 5, 345));
      expect(first.history, hasLength(7));
    });

    test('first email domain block history entries have correct fields', () {
      final file = File('test/fixtures/admin/email_domain_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map(
            (e) => MastodonAdminEmailDomainBlock.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      final firstHistory = blocks.first.history.first;
      expect(firstHistory.day, '1774051200');
      expect(firstHistory.accounts, '0');
      expect(firstHistory.uses, '0');
    });
  });
}
