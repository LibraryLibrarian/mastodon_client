import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_filter.g.dart';

/// フィルターのアクション種別（v2）
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonFilterAction {
  /// マッチしたコンテンツに警告を表示する（デフォルト）
  warn,

  /// マッチしたコンテンツを完全に非表示にする
  hide,

  /// マッチしたメディアをぼかす（Mastodon 4.4.0+）
  blur,
}

/// フィルターグループ（v2、Mastodon 4.0+）
///
/// `/api/v2/filters` のレスポンスに対応する。
/// サーバーサイドでフィルタリングを行い、1つのフィルターに複数のキーワードや
/// ステータスを関連付けることができる。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonFilter {
  const MastodonFilter({
    required this.id,
    required this.title,
    required this.context,
    required this.filterAction,
    required this.keywords,
    required this.statuses,
    this.expiresAt,
  });

  factory MastodonFilter.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterFromJson(json);

  /// フィルターの内部 ID
  final String id;

  /// フィルターグループの名前
  @JsonKey(defaultValue: '')
  final String title;

  /// フィルターが適用されるコンテキスト（`home`, `notifications`, `public`, `thread`, `account`）
  @JsonKey(defaultValue: <String>[])
  final List<String> context;

  /// 有効期限。`null` の場合は無期限
  @SafeDateTimeConverter()
  final DateTime? expiresAt;

  /// マッチ時のアクション
  @JsonKey(unknownEnumValue: MastodonFilterAction.warn)
  final MastodonFilterAction filterAction;

  /// このフィルターに属するキーワード群
  @JsonKey(defaultValue: <MastodonFilterKeyword>[])
  final List<MastodonFilterKeyword> keywords;

  /// このフィルターに属するステータスフィルター群
  @JsonKey(defaultValue: <MastodonFilterStatus>[])
  final List<MastodonFilterStatus> statuses;
}

/// フィルターキーワード
///
/// `/api/v2/filters/:filter_id/keywords` のレスポンスに対応する
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonFilterKeyword {
  const MastodonFilterKeyword({
    required this.id,
    required this.keyword,
    required this.wholeWord,
  });

  factory MastodonFilterKeyword.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterKeywordFromJson(json);

  /// FilterKeyword の内部 ID
  final String id;

  /// フィルター対象のキーワード文字列
  @JsonKey(defaultValue: '')
  final String keyword;

  /// 単語境界を考慮するかどうか
  @JsonKey(defaultValue: false)
  final bool wholeWord;
}

/// ステータスフィルター
///
/// `/api/v2/filters/:filter_id/statuses` のレスポンスに対応する
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonFilterStatus {
  const MastodonFilterStatus({
    required this.id,
    required this.statusId,
  });

  factory MastodonFilterStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterStatusFromJson(json);

  /// FilterStatus の内部 ID
  final String id;

  /// フィルター対象のステータス ID
  @JsonKey(defaultValue: '')
  final String statusId;
}

/// v1 フィルター（非推奨、Mastodon 4.0 で廃止予定）
///
/// `/api/v1/filters` のレスポンスに対応する。
/// クライアントサイドフィルタリング用で、1フィルター = 1キーワードの構造。
@Deprecated('Mastodon 4.0.0 で非推奨。代わりに MastodonFilter (v2) を使用してください')
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonFilterV1 {
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに MastodonFilter (v2) を使用してください')
  const MastodonFilterV1({
    required this.id,
    required this.phrase,
    required this.context,
    required this.irreversible,
    required this.wholeWord,
    this.expiresAt,
  });

  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに MastodonFilter (v2) を使用してください')
  factory MastodonFilterV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterV1FromJson(json);

  /// フィルターの内部 ID
  final String id;

  /// フィルター対象のテキスト
  @JsonKey(defaultValue: '')
  final String phrase;

  /// フィルターが適用されるコンテキスト（`home`, `notifications`, `public`, `thread`, `account`）
  @JsonKey(defaultValue: <String>[])
  final List<String> context;

  /// 有効期限。`null` の場合は無期限
  @SafeDateTimeConverter()
  final DateTime? expiresAt;

  /// ホーム・通知で一致するエンティティをサーバー側で不可逆的に除外するか
  @JsonKey(defaultValue: false)
  final bool irreversible;

  /// 単語境界を考慮してマッチングするか
  @JsonKey(defaultValue: false)
  final bool wholeWord;
}
