import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonMarker.fromJson', () {
    late Map<String, dynamic> fixtureMap;

    setUp(() {
      final file = File('test/fixtures/markers.json');
      fixtureMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    });

    test('deserializes "home" marker', () {
      final obj = MastodonMarker.fromJson(
        fixtureMap['home'] as Map<String, dynamic>,
      );

      expect(obj.lastReadId, '116266764647790665');
      expect(obj.version, 1);
      expect(obj.updatedAt, isNotNull);
      expect(obj.updatedAt, DateTime.parse('2026-03-21T10:52:25.102Z'));
    });

    test('deserializes "notifications" marker', () {
      final obj = MastodonMarker.fromJson(
        fixtureMap['notifications'] as Map<String, dynamic>,
      );

      expect(obj.lastReadId, '0');
      expect(obj.version, 0);
      expect(obj.updatedAt, isNotNull);
      expect(obj.updatedAt, DateTime.parse('2026-03-21T10:52:25.107Z'));
    });

    test('fixture contains both home and notifications keys', () {
      expect(fixtureMap.containsKey('home'), true);
      expect(fixtureMap.containsKey('notifications'), true);
    });
  });
}
