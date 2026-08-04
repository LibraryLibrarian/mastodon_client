import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonApplication.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/app_verify_credentials.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonApplication.fromJson(json);

      expect(obj.id, '2');
      expect(obj.name, 'mastodon_client_test');
      expect(obj.website, isNull);
      expect(obj.scopes, contains('read'));
      expect(obj.scopes, contains('write'));
      expect(obj.scopes, contains('follow'));
      expect(obj.scopes, contains('push'));
      expect(obj.scopes, contains('admin:read'));
      expect(obj.scopes, contains('admin:write'));
      expect(obj.redirectUris, ['urn:ietf:wg:oauth:2.0:oob']);
      // ignore: deprecated_member_use_from_same_package
      expect(obj.vapidKey, startsWith('BElU32nVl4v6dZV8'));
    });
  });
}
