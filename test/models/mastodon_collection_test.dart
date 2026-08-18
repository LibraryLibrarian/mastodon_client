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
      expect(collection.items, isEmpty);
      expect(collection.createdAt, isA<DateTime>());
    });

    test('deserializes a shallow tag returned by Mastodon 4.6.3', () {
      final file = File('test/fixtures/collection_tagged.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final collection = MastodonCollection.fromJson(json);

      expect(collection.tag, isNotNull);
      expect(collection.tag!.name, 'probetag');
      expect(collection.tag!.url, 'https://mastodon.test/tags/probetag');
    });

    test('deserializes collection items with conditional account IDs', () {
      final collection = MastodonCollection.fromJson({
        'id': 'collection-id',
        'name': 'collection',
        'items': <Map<String, dynamic>>[
          {
            'id': 'pending-item',
            'state': 'pending',
            'created_at': '2026-08-04T11:22:47.000Z',
            'account_id': 'account-id',
          },
          {
            'id': 'rejected-item',
            'state': 'rejected',
            'created_at': '2026-08-04T11:23:47.000Z',
          },
        ],
      });

      expect(collection.items, hasLength(2));
      expect(collection.items.first.accountId, 'account-id');
      expect(collection.items.first.createdAt, isA<DateTime>());
      expect(collection.items.last.accountId, isNull);
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
