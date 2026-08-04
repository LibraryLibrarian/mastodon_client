import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonPrivacyPolicy.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/privacy_policy.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonPrivacyPolicy.fromJson(json);

      expect(obj.updatedAt, isNotNull);
      expect(obj.updatedAt, DateTime.parse('2022-10-07T00:00:00+00:00'));
      expect(obj.content, contains('<p>This privacy policy describes'));
      expect(obj.content, contains('localhost:3001'));
      expect(obj.content, contains('<h1>What information do we collect?</h1>'));
      expect(obj.content, contains('Do we use cookies?'));
    });
  });
}
