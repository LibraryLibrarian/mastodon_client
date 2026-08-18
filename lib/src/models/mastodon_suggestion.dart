import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_suggestion.freezed.dart';
part 'mastodon_suggestion.g.dart';

/// Suggested account to follow and the reason for the suggestion.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonSuggestion with _$MastodonSuggestion {
  /// Creates a [MastodonSuggestion] with the given fields.
  const MastodonSuggestion({
    // ignore: remove_deprecations_in_breaking_versions
    @Deprecated('Deprecated in Mastodon 4.3.0. Use sources instead')
    this.source,
    required this.account,
    this.sources = const <String>[],
  });

  /// Creates a [MastodonSuggestion] from a JSON map.
  factory MastodonSuggestion.fromJson(Map<String, dynamic> json) =>
      _$MastodonSuggestionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonSuggestionToJson(this);

  /// Legacy string indicating the reason for the suggestion.
  ///
  /// Officially defined values are `staff` (staff recommendation),
  /// `past_interactions` (based on past interactions), and
  /// `global` (based on global popularity). This can be `null` when the server
  /// does not provide a legacy value or cannot map an entry from [sources].
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 4.3.0. Use sources instead')
  @override
  final String? source;

  /// Suggested account.
  @override
  final MastodonAccount account;

  /// Reasons for the suggestion, in the current (non-legacy) vocabulary.
  ///
  /// Values include `featured`, `most_followed`, `most_interactions`,
  /// `similar_to_recently_followed` and `friends_of_friends`. The legacy source
  /// field is a lossy mapping of the first entry onto the legacy three-value
  /// vocabulary, so prefer this field when distinguishing suggestion reasons.
  @JsonKey(defaultValue: <String>[])
  @override
  final List<String> sources;
}
