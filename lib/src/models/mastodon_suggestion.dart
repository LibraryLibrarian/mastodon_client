import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_suggestion.g.dart';

/// フォロー候補として提案されたアカウントとその理由
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonSuggestion {
  /// 各フィールドを指定して [MastodonSuggestion] を生成する
  const MastodonSuggestion({
    required this.source,
    required this.account,
  });

  /// JSON マップから [MastodonSuggestion] を生成する
  factory MastodonSuggestion.fromJson(Map<String, dynamic> json) =>
      _$MastodonSuggestionFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonSuggestionToJson(this);

  /// 提案の理由を示す文字列
  ///
  /// 公式で定義されている値:
  /// - `staff`: スタッフ推薦
  /// - `past_interactions`: 過去のインタラクションに基づく
  /// - `global`: グローバルな人気に基づく
  final String source;

  /// 提案されたアカウント
  final MastodonAccount account;
}
