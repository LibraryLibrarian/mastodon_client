import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonStatusContext.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/status_context.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      final context = MastodonStatusContext.fromJson(json);

      // ancestors は空配列
      expect(context.ancestors, isEmpty);

      // descendants
      expect(context.descendants, hasLength(1));

      final reply = context.descendants.first;
      expect(reply.id, isNotEmpty);
      expect(reply.inReplyToId, isNotEmpty);
      expect(reply.inReplyToAccountId, isNotEmpty);
      expect(reply.visibility, equals(MastodonVisibility.public));
      expect(reply.content, isNotEmpty);
      expect(reply.repliesCount, equals(0));
      expect(reply.reblogsCount, equals(0));
      expect(reply.favouritesCount, equals(0));
      expect(reply.favourited, isFalse);
      expect(reply.reblogged, isFalse);
      expect(reply.muted, isFalse);
      expect(reply.bookmarked, isFalse);

      // nested account (連合越しの返信: acct にリモートホストが付く)
      expect(reply.account.id, isNotEmpty);
      expect(reply.account.acct, contains('@'));

      // empty relations
      expect(reply.mediaAttachments, isEmpty);
      expect(reply.mentions, isEmpty);
      expect(reply.tags, isEmpty);
      expect(reply.emojis, isEmpty);

      // nullable fields
      expect(reply.reblog, isNull);
      expect(reply.poll, isNull);
      expect(reply.editedAt, isNull);
    });
  });
}
