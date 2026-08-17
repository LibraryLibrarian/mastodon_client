// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

// アカウントのインライン JSON ヘルパー
Map<String, dynamic> _minimalAccountJson({
  String id = '116266741324121431',
  String username = 'suggested_user',
}) => <String, dynamic>{
  'id': id,
  'username': username,
  'acct': username,
  'display_name': 'Suggested User',
  'locked': false,
  'bot': false,
  'created_at': '2024-01-01T00:00:00.000Z',
  'note': '<p>A great person to follow.</p>',
  'url': 'https://mastodon.example/@$username',
  'avatar': 'https://mastodon.example/avatars/original/missing.png',
  'avatar_static': 'https://mastodon.example/avatars/original/missing.png',
  'header': 'https://mastodon.example/headers/original/missing.png',
  'header_static': 'https://mastodon.example/headers/original/missing.png',
  'followers_count': 200,
  'following_count': 50,
  'statuses_count': 300,
  'emojis': <dynamic>[],
  'fields': <dynamic>[],
};

void main() {
  group('MastodonSuggestion.fromJson', () {
    test('deserializes staff suggestion', () {
      final json = <String, dynamic>{
        'source': 'staff',
        'account': _minimalAccountJson(id: '111', username: 'staff_pick'),
      };
      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.source, 'staff');
      expect(suggestion.account.id, '111');
      expect(suggestion.account.username, 'staff_pick');
      expect(suggestion.account.displayName, 'Suggested User');
      expect(suggestion.account.followersCount, 200);
      expect(suggestion.account.followingCount, 50);
      expect(suggestion.account.statusesCount, 300);
    });

    test('deserializes past_interactions suggestion', () {
      final json = <String, dynamic>{
        'source': 'past_interactions',
        'account': _minimalAccountJson(id: '222', username: 'old_friend'),
      };
      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.source, 'past_interactions');
      expect(suggestion.account.id, '222');
      expect(suggestion.account.username, 'old_friend');
    });

    test('deserializes global suggestion', () {
      final json = <String, dynamic>{
        'source': 'global',
        'account': _minimalAccountJson(id: '333', username: 'popular_user'),
      };
      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.source, 'global');
      expect(suggestion.account.id, '333');
      expect(suggestion.account.username, 'popular_user');
      expect(suggestion.account.acct, 'popular_user');
      expect(suggestion.account.locked, isFalse);
      expect(suggestion.account.bot, isFalse);
    });

    test('account note is deserialized correctly', () {
      final json = <String, dynamic>{
        'source': 'staff',
        'account': _minimalAccountJson(),
      };
      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.account.note, '<p>A great person to follow.</p>');
    });

    test('deserializes a null legacy source for a FASP suggestion', () {
      final json = <String, dynamic>{
        'source': null,
        'sources': <String>['fasp'],
        'account': _minimalAccountJson(),
      };

      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.source, isNull);
      expect(suggestion.sources, <String>['fasp']);
    });

    test('deserializes a suggestion when the legacy source is absent', () {
      final json = <String, dynamic>{
        'sources': <String>['featured'],
        'account': _minimalAccountJson(),
      };

      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.source, isNull);
      expect(suggestion.sources, <String>['featured']);
    });
  });

  group('MastodonSuggestion.sources', () {
    test('deserializes sources from fixture', () {
      final file = File('test/fixtures/suggestions.json');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final suggestions = list
          .map((e) => MastodonSuggestion.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(suggestions, isNotEmpty);
      expect(suggestions.first.sources, contains('featured'));
    });

    test('sources carries values that source flattens away', () {
      // source は sources.first を旧3値へ写像した劣化版。
      // most_followed と most_interactions はどちらも global に潰れる
      final json = <String, dynamic>{
        'source': 'global',
        'sources': <String>['most_interactions'],
        'account': _minimalAccountJson(),
      };
      final suggestion = MastodonSuggestion.fromJson(json);

      expect(suggestion.source, 'global');
      expect(suggestion.sources, <String>['most_interactions']);
    });

    test('sources defaults to an empty list when the key is absent', () {
      final json = <String, dynamic>{
        'source': 'staff',
        'account': _minimalAccountJson(),
      };

      expect(MastodonSuggestion.fromJson(json).sources, isEmpty);
    });
  });
}
