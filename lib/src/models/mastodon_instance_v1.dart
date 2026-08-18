import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_instance.dart';

part 'mastodon_instance_v1.freezed.dart';
part 'mastodon_instance_v1.g.dart';

/// v1 instance URL settings.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Urls with _$MastodonInstanceV1Urls {
  const MastodonInstanceV1Urls({this.streamingApi});

  factory MastodonInstanceV1Urls.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1UrlsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceV1UrlsToJson(this);

  /// URL of the WebSocket streaming API.
  @override
  final String? streamingApi;
}

/// v1 instance statistics.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Stats with _$MastodonInstanceV1Stats {
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
  @override
  final int userCount;

  /// Number of statuses.
  @JsonKey(defaultValue: 0)
  @override
  final int statusCount;

  /// Number of known domains.
  @JsonKey(defaultValue: 0)
  @override
  final int domainCount;
}

/// v1 instance configuration.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Configuration with _$MastodonInstanceV1Configuration {
  const MastodonInstanceV1Configuration({
    this.statuses,
    this.mediaAttachments,
    this.polls,
  });

  factory MastodonInstanceV1Configuration.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1ConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceV1ConfigurationToJson(this);

  /// Status posting limits.
  @override
  final MastodonStatusesConfiguration? statuses;

  /// Media attachment limits.
  @override
  final MastodonMediaConfiguration? mediaAttachments;

  /// Poll limits.
  @override
  final MastodonPollsConfiguration? polls;
}

/// Mastodon instance information in v1 format.
///
/// Corresponds to the response from `/api/v1/instance`.
///
/// **Deprecated**: Use [MastodonInstance] (v2) for Mastodon 4.0.0 and later.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1 with _$MastodonInstanceV1 {
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
  @override
  final String uri;

  /// Name of the server.
  @JsonKey(defaultValue: '')
  @override
  final String title;

  /// Short description of the server.
  @override
  final String? shortDescription;

  /// Detailed description of the server.
  @override
  final String? description;

  /// Contact email address of the administrator.
  @override
  final String? email;

  /// Mastodon version string.
  @JsonKey(defaultValue: '')
  @override
  final String version;

  /// URL settings (including streaming API URL).
  @override
  final MastodonInstanceV1Urls? urls;

  /// Instance statistics.
  @override
  final MastodonInstanceV1Stats? stats;

  /// Thumbnail image URL of the server.
  @override
  final String? thumbnail;

  /// List of supported language codes.
  @override
  final List<String>? languages;

  /// Whether new registrations are accepted.
  @JsonKey(defaultValue: false)
  @override
  final bool registrations;

  /// Whether admin approval is required for registration.
  @JsonKey(defaultValue: false)
  @override
  final bool approvalRequired;

  /// Whether invites are enabled (Mastodon 3.1.4+).
  @JsonKey(defaultValue: false)
  @override
  final bool invitesEnabled;

  /// Server configuration and limits (Mastodon 3.4.2+).
  @override
  final MastodonInstanceV1Configuration? configuration;

  /// Administrator account information.
  @override
  final MastodonAccount? contactAccount;

  /// Server rules (Mastodon 3.4.0+).
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  @override
  final List<MastodonInstanceRule> rules;
}
