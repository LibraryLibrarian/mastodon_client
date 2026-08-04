import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonOAuthUserInfo.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/oauth_userinfo.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final userInfo = MastodonOAuthUserInfo.fromJson(json);

      expect(userInfo.iss, equals('https://localhost:3001/'));
      expect(
        userInfo.sub,
        equals('https://localhost:3001/ap/users/116266741324121431'),
      );
      expect(userInfo.name, equals(''));
      expect(userInfo.preferredUsername, equals('testadmin'));
      expect(userInfo.profile, equals('https://localhost:3001/@testadmin'));
      expect(
        userInfo.picture,
        equals('https://localhost:3001/avatars/original/missing.png'),
      );
    });
  });
}
