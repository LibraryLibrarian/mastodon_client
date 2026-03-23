import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonPoll.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/poll.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final poll = MastodonPoll.fromJson(json);

      expect(poll.id, equals('1'));
      expect(poll.expired, isFalse);
      expect(poll.multiple, isFalse);
      expect(poll.votesCount, equals(0));
      expect(poll.votersCount, equals(0));
      expect(poll.voted, isTrue);
      expect(poll.ownVotes, isEmpty);
      expect(
        poll.expiresAt,
        equals(DateTime.utc(2026, 3, 22, 10, 52, 24, 198)),
      );
      expect(poll.options, hasLength(3));
      expect(poll.options[0].title, equals('Dart'));
      expect(poll.options[0].votesCount, equals(0));
      expect(poll.options[1].title, equals('Kotlin'));
      expect(poll.options[2].title, equals('Swift'));
      expect(poll.emojis, isEmpty);
    });
  });
}
