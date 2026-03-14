import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_search_result.g.dart';

/// v2 検索結果
///
/// `GET /api/v2/search` のレスポンスに対応する。
/// [hashtags] は [MastodonTag] オブジェクトの配列として返される。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonSearchResult {
  const MastodonSearchResult({
    required this.accounts,
    required this.statuses,
    required this.hashtags,
  });

  factory MastodonSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MastodonSearchResultFromJson(json);

  /// 検索にマッチしたアカウントの一覧
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// 検索にマッチした投稿の一覧
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// 検索にマッチしたハッシュタグの一覧（Tag オブジェクト）
  @JsonKey(defaultValue: <MastodonTag>[])
  final List<MastodonTag> hashtags;
}

/// v1 検索結果（非推奨）
///
/// `GET /api/v1/search` のレスポンスに対応する。
/// v2 との主な違いとして、[hashtags] は Tag オブジェクトではなく
/// 単純な文字列の配列として返される。
///
/// Mastodon 3.0.0 で v1 search エンドポイントは削除されたため、
/// 2.x 系以前のインスタンスでのみ使用可能。
@Deprecated('Mastodon 3.0.0 で削除済み。代わりに MastodonSearchResult (v2) を使用してください')
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonSearchResultV1 {
  @Deprecated('Mastodon 3.0.0 で削除済み。代わりに MastodonSearchResult (v2) を使用してください')
  const MastodonSearchResultV1({
    required this.accounts,
    required this.statuses,
    required this.hashtags,
  });

  @Deprecated('Mastodon 3.0.0 で削除済み。代わりに MastodonSearchResult (v2) を使用してください')
  factory MastodonSearchResultV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonSearchResultV1FromJson(json);

  /// 検索にマッチしたアカウントの一覧
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// 検索にマッチした投稿の一覧
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// 検索にマッチしたハッシュタグ名の一覧（文字列）
  ///
  /// v1 では Tag オブジェクトではなく単純な文字列配列が返される。
  @JsonKey(defaultValue: <String>[])
  final List<String> hashtags;
}
