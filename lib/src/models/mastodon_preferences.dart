import 'package:json_annotation/json_annotation.dart';

part 'mastodon_preferences.g.dart';

/// User account preferences model.
///
/// Retrieved via `GET /api/v1/preferences`.
/// Preferences are changed via `PATCH /api/v1/accounts/update_credentials`.
@JsonSerializable()
class MastodonPreferences {
  /// Creates a [MastodonPreferences] with the given fields.
  const MastodonPreferences({
    required this.postingDefaultVisibility,
    required this.postingDefaultSensitive,
    this.postingDefaultLanguage,
    this.postingDefaultQuotePolicy,
    required this.readingExpandMedia,
    required this.readingExpandSpoilers,
  });

  /// Creates a [MastodonPreferences] from a JSON map.
  factory MastodonPreferences.fromJson(Map<String, dynamic> json) =>
      _$MastodonPreferencesFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPreferencesToJson(this);

  /// Default visibility for new posts (`public` / `unlisted` / `private` / `direct`).
  @JsonKey(name: 'posting:default:visibility', defaultValue: 'public')
  final String postingDefaultVisibility;

  /// Whether to mark new posts as sensitive by default.
  @JsonKey(name: 'posting:default:sensitive', defaultValue: false)
  final bool postingDefaultSensitive;

  /// Default language for new posts (ISO 639-1 code, `null` if unset).
  @JsonKey(name: 'posting:default:language')
  final String? postingDefaultLanguage;

  /// Default quote policy (v4.5.0+).
  @JsonKey(name: 'posting:default:quote_policy')
  final String? postingDefaultQuotePolicy;

  /// Auto-display setting for media attachments (`default` / `show_all` / `hide_all`).
  @JsonKey(name: 'reading:expand:media', defaultValue: 'default')
  final String readingExpandMedia;

  /// Whether to expand content warnings (CW) by default.
  @JsonKey(name: 'reading:expand:spoilers', defaultValue: false)
  final bool readingExpandSpoilers;
}
