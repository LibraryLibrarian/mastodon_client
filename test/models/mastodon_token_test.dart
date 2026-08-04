import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonToken.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/token.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final token = MastodonToken.fromJson(json);

      expect(
        token.accessToken,
        equals('22Dp7qzTjByYWwvhipgsrbWaDd6Uo43uOA4260CQ8u4'),
      );
      expect(token.tokenType, equals('Bearer'));
      expect(token.scope, equals('read'));
      expect(token.createdAt, equals(1774270753));
    });
  });
}
