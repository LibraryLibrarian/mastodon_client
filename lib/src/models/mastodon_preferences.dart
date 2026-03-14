import 'package:json_annotation/json_annotation.dart';

part 'mastodon_preferences.g.dart';

/// ユーザーのアカウント設定を表すモデル
///
/// `GET /api/v1/preferences` で取得される。
/// 設定の変更は `PATCH /api/v1/accounts/update_credentials` で行う。
@JsonSerializable(createToJson: false)
class MastodonPreferences {
  /// 各フィールドを指定して [MastodonPreferences] を生成する
  const MastodonPreferences({
    required this.postingDefaultVisibility,
    required this.postingDefaultSensitive,
    this.postingDefaultLanguage,
    this.postingDefaultQuotePolicy,
    required this.readingExpandMedia,
    required this.readingExpandSpoilers,
  });

  /// JSON マップから [MastodonPreferences] を生成する
  factory MastodonPreferences.fromJson(Map<String, dynamic> json) =>
      _$MastodonPreferencesFromJson(json);

  /// 新規投稿のデフォルト公開範囲（`public` / `unlisted` / `private` / `direct`）
  @JsonKey(name: 'posting:default:visibility', defaultValue: 'public')
  final String postingDefaultVisibility;

  /// 新規投稿をデフォルトで閲覧注意にするかどうか
  @JsonKey(name: 'posting:default:sensitive', defaultValue: false)
  final bool postingDefaultSensitive;

  /// 新規投稿のデフォルト言語（ISO 639-1 コード、未設定時は `null`）
  @JsonKey(name: 'posting:default:language')
  final String? postingDefaultLanguage;

  /// 引用に関するデフォルトポリシー（v4.5.0+）
  @JsonKey(name: 'posting:default:quote_policy')
  final String? postingDefaultQuotePolicy;

  /// メディア添付ファイルの自動表示設定（`default` / `show_all` / `hide_all`）
  @JsonKey(name: 'reading:expand:media', defaultValue: 'default')
  final String readingExpandMedia;

  /// CW（コンテンツ警告）をデフォルトで展開するかどうか
  @JsonKey(name: 'reading:expand:spoilers', defaultValue: false)
  final bool readingExpandSpoilers;
}
