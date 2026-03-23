import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminCanonicalEmailBlock.fromJson', () {
    test('deserializes list of canonical email blocks from fixture', () {
      final file = File('test/fixtures/admin/canonical_email_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map(
            (e) => MastodonAdminCanonicalEmailBlock.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      expect(blocks, hasLength(1));
    });

    test('first canonical email block has correct fields', () {
      final file = File('test/fixtures/admin/canonical_email_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map(
            (e) => MastodonAdminCanonicalEmailBlock.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      final first = blocks.first;
      expect(first.id, '1');
      expect(
        first.canonicalEmailHash,
        '2339ee162f4bdceb89ce5491b39f826a0e91a2b6703791e723c8b59e7c99aed9',
      );
    });
  });
}
