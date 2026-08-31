import 'dart:convert';
import 'dart:io';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonMutedAccount.fromJson', () {
    Map<String, dynamic> loadMutedAccount() {
      final list =
          jsonDecode(File('test/fixtures/mutes.json').readAsStringSync())
              as List<dynamic>;
      return Map<String, dynamic>.from(list.single as Map<String, dynamic>);
    }

    test('deserializes a timed mute from the fixture', () {
      final mutedAccount = MastodonMutedAccount.fromJson(loadMutedAccount());

      expect(mutedAccount.account.username, 'e2e_admin');
      expect(
        mutedAccount.muteExpiresAt,
        DateTime.utc(2026, 9, 7, 15, 47, 31, 818),
      );
    });

    test('deserializes an indefinite mute', () {
      final json = loadMutedAccount()..['mute_expires_at'] = null;

      final mutedAccount = MastodonMutedAccount.fromJson(json);

      expect(mutedAccount.muteExpiresAt, isNull);
    });

    test('accepts servers that omit mute_expires_at', () {
      final json = loadMutedAccount()..remove('mute_expires_at');

      expect(MastodonMutedAccount.fromJson(json).muteExpiresAt, isNull);
    });

    test('serializes to Mastodon\'s flat muted-account shape', () {
      final mutedAccount = MastodonMutedAccount.fromJson(loadMutedAccount());
      final json = mutedAccount.toJson();

      expect(json['username'], 'e2e_admin');
      expect(json, isNot(contains('account')));
      expect(json, containsPair('mute_expires_at', '2026-09-07T15:47:31.818Z'));
    });
  });
}
