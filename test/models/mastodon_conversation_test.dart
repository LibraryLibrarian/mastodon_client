import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonConversation.fromJson', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/conversations.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final conversations = list
          .map((e) => MastodonConversation.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(conversations, hasLength(1));

      final conv = conversations.first;
      expect(conv.id, equals('1'));
      expect(conv.unread, isFalse);
      expect(conv.accounts, hasLength(1));
      expect(conv.accounts.first.id, equals('116266789448809503'));
      expect(conv.accounts.first.username, equals('testuser2'));
      expect(conv.accounts.first.acct, equals('testuser2'));
      expect(conv.lastStatus, isNotNull);
      expect(conv.lastStatus!.id, equals('116266792229011955'));
      expect(conv.lastStatus!.visibility, MastodonVisibility.direct);
    });
  });
}
