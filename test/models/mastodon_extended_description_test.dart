import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonExtendedDescription.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/extended_description.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonExtendedDescription.fromJson(json);

      expect(obj.updatedAt, isNull);
      expect(obj.content, '');
    });
  });
}
