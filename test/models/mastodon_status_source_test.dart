import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonStatusSource.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/status_source.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonStatusSource.fromJson(json);

      expect(obj.id, '116266764647790665');
      expect(obj.text, 'Hello, this is a test post for API testing!');
      expect(obj.spoilerText, '');
    });
  });
}
