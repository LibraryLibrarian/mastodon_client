import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_suggestion.g.dart';

/// Suggested account to follow and the reason for the suggestion.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonSuggestion {
  /// Creates a [MastodonSuggestion] with the given fields.
  const MastodonSuggestion({
    required this.source,
    required this.account,
    this.sources = const <String>[],
  });

  /// Creates a [MastodonSuggestion] from a JSON map.
  factory MastodonSuggestion.fromJson(Map<String, dynamic> json) =>
      _$MastodonSuggestionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonSuggestionToJson(this);

  /// String indicating the reason for the suggestion.
  ///
  /// Officially defined values are `staff` (staff recommendation),
  /// `past_interactions` (based on past interactions), and
  /// `global` (based on global popularity).
  final String source;

  /// Suggested account.
  final MastodonAccount account;

  /// Reasons for the suggestion, in the current (non-legacy) vocabulary.
  ///
  /// Values include `featured`, `most_followed`, `most_interactions`,
  /// `similar_to_recently_followed` and `friends_of_friends`. [source] is a
  /// lossy mapping of the first entry onto the legacy three-value vocabulary,
  /// so prefer this field when distinguishing suggestion reasons.
  @JsonKey(defaultValue: <String>[])
  final List<String> sources;
}
