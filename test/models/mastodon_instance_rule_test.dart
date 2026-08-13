import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonInstanceRule.fromJson', () {
    test('deserializes list from fixture', () {
      final file = File('test/fixtures/instance_rules.json');
      final jsonList = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      final rules = jsonList
          .cast<Map<String, dynamic>>()
          .map(MastodonInstanceRule.fromJson)
          .toList();

      expect(rules, hasLength(2));

      final first = rules.first;
      expect(first.id, '1');
      expect(first.text, 'Be respectful to others');
      expect(first.hint, '');
      expect(first.translations, isEmpty);

      final second = rules[1];
      expect(second.id, '2');
      expect(second.text, 'No spam or advertising');
      expect(second.hint, '');
      expect(second.translations, isEmpty);
    });

    test('deserializes rule with hint and translations', () {
      final json = <String, dynamic>{
        'id': '3',
        'text': 'No illegal content',
        'hint': 'This includes copyright violations.',
        'translations': {
          'ja': {'text': '違法なコンテンツは禁止です', 'hint': '著作権侵害も含まれます。'},
        },
      };
      final rule = MastodonInstanceRule.fromJson(json);

      expect(rule.id, '3');
      expect(rule.text, 'No illegal content');
      expect(rule.hint, 'This includes copyright violations.');
      expect(rule.translations, isNotNull);
      expect(rule.translations!['ja']!.text, '違法なコンテンツは禁止です');
      expect(rule.translations!['ja']!.hint, '著作権侵害も含まれます。');
    });

    test('deserializes rule with null hint', () {
      final json = <String, dynamic>{
        'id': '4',
        'text': 'Keep it civil',
        'hint': null,
        'translations': null,
      };
      final rule = MastodonInstanceRule.fromJson(json);

      expect(rule.id, '4');
      expect(rule.text, 'Keep it civil');
      expect(rule.hint, isNull);
      expect(rule.translations, isNull);
    });
  });
}
