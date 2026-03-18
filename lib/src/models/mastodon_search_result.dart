import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_search_result.g.dart';

/// v2 search result.
///
/// Corresponds to the response from `GET /api/v2/search`.
/// [hashtags] is returned as an array of [MastodonTag] objects.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonSearchResult {
  const MastodonSearchResult({
    required this.accounts,
    required this.statuses,
    required this.hashtags,
  });

  factory MastodonSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MastodonSearchResultFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonSearchResultToJson(this);

  /// List of accounts matching the search.
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// List of statuses matching the search.
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// List of hashtags matching the search (Tag objects).
  @JsonKey(defaultValue: <MastodonTag>[])
  final List<MastodonTag> hashtags;
}

/// v1 search result (deprecated).
///
/// Corresponds to the response from `GET /api/v1/search`.
/// The main difference from v2 is that [hashtags] is returned as a simple
/// string array rather than Tag objects.
///
/// The v1 search endpoint was removed in Mastodon 3.0.0 and is only
/// available on 2.x instances.
@Deprecated('Removed in Mastodon 3.0.0. Use MastodonSearchResult (v2) instead')
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonSearchResultV1 {
  @Deprecated(
    'Removed in Mastodon 3.0.0. Use MastodonSearchResult (v2) instead',
  )
  const MastodonSearchResultV1({
    required this.accounts,
    required this.statuses,
    required this.hashtags,
  });

  @Deprecated(
    'Removed in Mastodon 3.0.0. Use MastodonSearchResult (v2) instead',
  )
  factory MastodonSearchResultV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonSearchResultV1FromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonSearchResultV1ToJson(this);

  /// List of accounts matching the search.
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// List of statuses matching the search.
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// List of hashtag names matching the search (strings).
  ///
  /// In v1, a simple string array is returned rather than Tag objects.
  @JsonKey(defaultValue: <String>[])
  final List<String> hashtags;
}
