import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminDomainBlock.fromJson', () {
    test('deserializes single domain block from fixture', () {
      final file = File('test/fixtures/admin/domain_block.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonAdminDomainBlock.fromJson(json);

      expect(obj.id, '1');
      expect(obj.domain, 'spam.example.com');
      expect(
        obj.digest,
        '6d2c4ec71792d50d6e19f3a20e35865232e75bc87478fceb8384d901dd7283d5',
      );
      expect(obj.severity, MastodonAdminDomainBlockSeverity.suspend);
      expect(obj.rejectMedia, isFalse);
      expect(obj.rejectReports, isFalse);
      expect(obj.privateComment, isNull);
      expect(obj.publicComment, isNull);
      expect(obj.obfuscate, isFalse);
      expect(obj.createdAt, isNotNull);
    });

    test('deserializes list of domain blocks from fixture', () {
      final file = File('test/fixtures/admin/domain_blocks.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final blocks = list
          .map(
            (e) => MastodonAdminDomainBlock.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      expect(blocks, hasLength(1));

      final first = blocks.first;
      expect(first.id, '1');
      expect(first.domain, 'spam.example.com');
      expect(
        first.digest,
        '6d2c4ec71792d50d6e19f3a20e35865232e75bc87478fceb8384d901dd7283d5',
      );
      expect(first.severity, MastodonAdminDomainBlockSeverity.suspend);
      expect(first.rejectMedia, isFalse);
      expect(first.rejectReports, isFalse);
      expect(first.obfuscate, isFalse);
      expect(first.createdAt, DateTime.utc(2026, 3, 21, 10, 56, 4, 927));
    });
  });
}
