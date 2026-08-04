import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminDomainAllow.fromJson', () {
    test('deserializes list of domain allows from fixture', () {
      final file = File('test/fixtures/admin/domain_allows.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final allows = list
          .map(
            (e) => MastodonAdminDomainAllow.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      expect(allows, hasLength(1));
    });

    test('first domain allow has correct fields', () {
      final file = File('test/fixtures/admin/domain_allows.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final allows = list
          .map(
            (e) => MastodonAdminDomainAllow.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      final first = allows.first;
      expect(first.id, '1');
      expect(first.domain, 'good.example.com');
      expect(first.createdAt, isNotNull);
      expect(first.createdAt, DateTime.utc(2026, 3, 21, 10, 56, 5, 250));
    });
  });
}
