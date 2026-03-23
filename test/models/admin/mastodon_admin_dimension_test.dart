import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonAdminDimension.fromJson', () {
    test('deserializes list of dimensions from fixture', () {
      final file = File('test/fixtures/admin/dimensions.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final dimensions = list
          .map(
            (e) => MastodonAdminDimension.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      expect(dimensions, hasLength(1));
    });

    test('first dimension has correct fields', () {
      final file = File('test/fixtures/admin/dimensions.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final dimensions = list
          .map(
            (e) => MastodonAdminDimension.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      final first = dimensions.first;
      expect(first.key, 'languages');
      expect(first.data, isEmpty);
    });
  });
}
