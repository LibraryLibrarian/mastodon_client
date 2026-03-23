import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminIpBlock.fromJson', () {
    test('deserializes list of IP blocks from fixture', () {
      final file = File('test/fixtures/admin/ip_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map((e) => MastodonAdminIpBlock.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(blocks, hasLength(1));
    });

    test('first IP block has correct fields', () {
      final file = File('test/fixtures/admin/ip_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map((e) => MastodonAdminIpBlock.fromJson(e as Map<String, dynamic>))
          .toList();

      final first = blocks.first;
      expect(first.id, '1');
      expect(first.ip, '192.168.99.0/24');
      expect(first.severity, MastodonAdminIpBlockSeverity.noAccess);
      expect(first.comment, 'Test IP block');
      expect(first.createdAt, isNotNull);
      expect(first.createdAt, DateTime.utc(2026, 3, 21, 10, 56, 5, 439));
      expect(first.expiresAt, isNull);
    });
  });
}
