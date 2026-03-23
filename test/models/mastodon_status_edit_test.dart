import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonStatusEdit.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/status_history.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonStatusEdit.fromJson(
        list.first as Map<String, dynamic>,
      );

      expect(obj.content, '<p>Hello, this is a test post for API testing!</p>');
      expect(obj.spoilerText, '');
      expect(obj.sensitive, false);
      expect(obj.createdAt, DateTime.parse('2026-03-21T10:47:16.755Z'));
      expect(obj.mediaAttachments, isEmpty);
      expect(obj.emojis, isEmpty);
      expect(obj.poll, isNull);
    });

    test('deserializes nested account', () {
      final file = File('test/fixtures/status_history.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final obj = MastodonStatusEdit.fromJson(
        list.first as Map<String, dynamic>,
      );
      final account = obj.account;

      expect(account.id, '116266741324121431');
      expect(account.username, 'testadmin');
      expect(account.acct, 'testadmin');
      expect(account.url, 'https://localhost:3001/@testadmin');
      expect(account.followersCount, 0);
      expect(account.followingCount, 0);
      expect(account.statusesCount, 5);
    });

    test('deserializes list of status edits', () {
      final file = File('test/fixtures/status_history.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final edits = list
          .map((e) => MastodonStatusEdit.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(edits.length, 1);
    });
  });
}
