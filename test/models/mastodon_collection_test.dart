import 'dart:convert';
import 'dart:io';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonCollection.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/collection.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final collection = MastodonCollection.fromJson(json);

      expect(collection.id, isNotEmpty);
      expect(collection.name, isNotEmpty);
      expect(collection.local, isTrue);
      expect(collection.sensitive, isFalse);
      expect(collection.discoverable, isTrue);
      expect(collection.itemCount, 0);
      expect(collection.description, isNull);
      expect(collection.tag, isNull);
      expect(collection.createdAt, isA<DateTime>());
    });
  });

  group('MastodonFeatureApproval.fromJson', () {
    test('deserializes visibility scope lists', () {
      final approval = MastodonFeatureApproval.fromJson(const {
        'automatic': <String>['public'],
        'manual': <String>[],
        'current_user': 'automatic',
      });

      expect(approval.automatic, ['public']);
      expect(approval.manual, isEmpty);
      expect(approval.currentUser, 'automatic');
    });

    test('handles empty scopes and null current_user', () {
      final approval = MastodonFeatureApproval.fromJson(const {
        'automatic': <String>[],
        'manual': <String>[],
      });

      expect(approval.automatic, isEmpty);
      expect(approval.manual, isEmpty);
      expect(approval.currentUser, isNull);
    });
  });
}
