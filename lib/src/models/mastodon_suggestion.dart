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
}
