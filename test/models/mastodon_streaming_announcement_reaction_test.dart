import 'dart:convert';
import 'dart:io';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonStreamingAnnouncementReaction.fromJson', () {
    test('deserializes from fixture', () {
      final json =
          jsonDecode(
                File(
                  'test/fixtures/streaming_announcement_reaction.json',
                ).readAsStringSync(),
              )
              as Map<String, dynamic>;

      final reaction = MastodonStreamingAnnouncementReaction.fromJson(json);

      expect(reaction.name, 'wave');
      expect(reaction.count, 3);
      expect(reaction.announcementId, '42');
      expect(reaction.toJson(), json);
    });
  });
}
