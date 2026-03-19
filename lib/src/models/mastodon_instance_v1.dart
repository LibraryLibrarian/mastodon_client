import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_instance.dart';

part 'mastodon_instance_v1.g.dart';

/// v1 instance URL settings.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Urls {
  const MastodonInstanceV1Urls({this.streamingApi});

  factory MastodonInstanceV1Urls.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1UrlsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceV1UrlsToJson(this);

  /// URL of the WebSocket streaming API.
  final String? streamingApi;
}

/// v1 instance statistics.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Stats {
  const MastodonInstanceV1Stats({
    required this.userCount,
    required this.statusCount,
    required this.domainCount,
  });

  factory MastodonInstanceV1Stats.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1StatsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceV1StatsToJson(this);

  /// Number of registered users.
  @JsonKey(defaultValue: 0)
  final int userCount;

  /// Number of statuses.
  @JsonKey(defaultValue: 0)
  final int statusCount;

  /// Number of known domains.
  @JsonKey(defaultValue: 0)
  final int domainCount;
}

/// v1 instance configuration.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Configuration {
  const MastodonInstanceV1Configuration({
    this.statuses,
    this.mediaAttachments,
    this.polls,
  });

  factory MastodonInstanceV1Configuration.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonInstanceV1ConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceV1ConfigurationToJson(this);

  /// Status posting limits.
  final MastodonStatusesConfiguration? statuses;

  /// Media attachment limits.
  final MastodonMediaConfiguration? mediaAttachments;

  /// Poll limits.
  final MastodonPollsConfiguration? polls;
}

/// Mastodon instance information in v1 format.
///
/// Corresponds to the response from `/api/v1/instance`.
///
/// **Deprecated**: Use [MastodonInstance] (v2) for Mastodon 4.0.0 and later.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1 {
  const MastodonInstanceV1({
    required this.uri,
    required this.title,
    required this.version,
    required this.rules,
    this.shortDescription,
    this.description,
    this.email,
    this.urls,
    this.stats,
    this.thumbnail,
    this.languages,
    required this.registrations,
    required this.approvalRequired,
    required this.invitesEnabled,
    this.configuration,
    this.contactAccount,
  });

  factory MastodonInstanceV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1FromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceV1ToJson(this);

  /// Domain of the server.
  final String uri;

  /// Name of the server.
  @JsonKey(defaultValue: '')
  final String title;

  /// Short description of the server.
  final String? shortDescription;

  /// Detailed description of the server.
  final String? description;

  /// Contact email address of the administrator.
  final String? email;

  /// Mastodon version string.
  @JsonKey(defaultValue: '')
  final String version;

  /// URL settings (including streaming API URL).
  final MastodonInstanceV1Urls? urls;

  /// Instance statistics.
  final MastodonInstanceV1Stats? stats;

  /// Thumbnail image URL of the server.
  final String? thumbnail;

  /// List of supported language codes.
  final List<String>? languages;

  /// Whether new registrations are accepted.
  @JsonKey(defaultValue: false)
  final bool registrations;

  /// Whether admin approval is required for registration.
  @JsonKey(defaultValue: false)
  final bool approvalRequired;

  /// Whether invites are enabled (Mastodon 3.1.4+).
  @JsonKey(defaultValue: false)
  final bool invitesEnabled;

  /// Server configuration and limits (Mastodon 3.4.2+).
  final MastodonInstanceV1Configuration? configuration;

  /// Administrator account information.
  final MastodonAccount? contactAccount;

  /// Server rules (Mastodon 3.4.0+).
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  final List<MastodonInstanceRule> rules;
}
