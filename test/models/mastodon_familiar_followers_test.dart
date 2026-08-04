import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonFamiliarFollowers.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/familiar_followers.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonFamiliarFollowers.fromJson(
        list.first as Map<String, dynamic>,
      );

      expect(obj.id, '116266789448809503');
      expect(obj.accounts, isEmpty);
    });

    test('deserializes list of familiar followers', () {
      final file = File('test/fixtures/familiar_followers.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final items = list
          .map(
            (e) =>
                MastodonFamiliarFollowers.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      expect(items.length, 1);
      expect(items.first.id, '116266789448809503');
    });
  });
}
