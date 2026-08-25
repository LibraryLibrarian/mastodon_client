import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

/// 実応答のキーがモデルに取り込まれているかを機械的に検証する。
///
/// 通常の fixture テストは「モデルが読むフィールドが正しく読めているか」しか
/// 見ておらず、モデルが読んでいないキーは json_serializable が黙って捨てるため
/// 素通りする。issue #13 の欠落フィールド群はこの穴から入り込んだ。
///
/// ここでは fixture のトップレベルキーが `toJson()` の出力キーに含まれることを
/// 確認し、含まれないものを欠落として検出する。
void main() {
  /// `toJson()` のキーが実応答のキーと意図的に食い違う箇所。
  ///
  /// readValue でネストした値を平坦化しているフィールドは、出力キーが実応答の
  /// キーと一致しないため個別に除外する。
  const knownDivergences = <String, Set<String>>{
    // apiVersionMastodon が api_versions.mastodon を平坦化して読む
    'instance_v2.json': {'api_versions'},
  };

  final cases = <String, Map<String, dynamic> Function(Map<String, dynamic>)>{
    'status.json': (json) => MastodonStatus.fromJson(json).toJson(),
    'status_filtered.json': (json) => MastodonStatus.fromJson(json).toJson(),
    'timelines_public.json': (json) => MastodonStatus.fromJson(json).toJson(),
    'account.json': (json) => MastodonAccount.fromJson(json).toJson(),
    'verify_credentials.json': (json) =>
        MastodonCredentialAccount.fromJson(json).toJson(),
    'instance_v2.json': (json) => MastodonInstance.fromJson(json).toJson(),
    'notifications.json': (json) =>
        MastodonNotification.fromJson(json).toJson(),
    'notifications_specialized.json': (json) =>
        MastodonNotification.fromJson(json).toJson(),
    'relationships.json': (json) =>
        MastodonRelationship.fromJson(json).toJson(),
    'suggestions.json': (json) => MastodonSuggestion.fromJson(json).toJson(),
    'preferences.json': (json) => MastodonPreferences.fromJson(json).toJson(),
    'preview_card.json': (json) => MastodonPreviewCard.fromJson(json).toJson(),
    'poll.json': (json) => MastodonPoll.fromJson(json).toJson(),
    'media_attachment.json': (json) =>
        MastodonMediaAttachment.fromJson(json).toJson(),
    'collection.json': (json) => MastodonCollection.fromJson(json).toJson(),
    'collection_tagged.json': (json) =>
        MastodonCollection.fromJson(json).toJson(),
    'streaming_announcement_reaction.json': (json) =>
        MastodonStreamingAnnouncementReaction.fromJson(json).toJson(),
  };

  group('fixture key coverage', () {
    cases.forEach((fixture, roundTrip) {
      test('$fixture: every response key is read by the model', () {
        final decoded = jsonDecode(
          File('test/fixtures/$fixture').readAsStringSync(),
        );
        final entries = decoded is List<dynamic> ? decoded : [decoded];

        for (var index = 0; index < entries.length; index++) {
          final json = entries[index] as Map<String, dynamic>;
          final missing = json.keys.toSet()
            ..removeAll(roundTrip(json).keys)
            ..removeAll(knownDivergences[fixture] ?? const <String>{});

          expect(
            missing,
            isEmpty,
            reason:
                'サーバーが返しているが $fixture のモデルが読んでいないキー '
                '(要素 $index): ${missing.toList()..sort()}\n'
                'モデルにフィールドを追加するか、意図的な差異なら '
                'knownDivergences に登録すること',
          );
        }
      });
    });
  });
}
