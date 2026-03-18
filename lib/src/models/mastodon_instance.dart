import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_instance.g.dart';

/// Public access level of a timeline.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonTimelineAccessLevel {
  /// Viewable by anyone, including unauthenticated users.
  public,

  /// Viewable only by authenticated users.
  authenticated,

  /// Disabled (not viewable).
  disabled,
}

/// Access settings for live feeds (real-time timelines).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTimelineLiveFeeds {
  const MastodonTimelineLiveFeeds({
    required this.local,
    required this.remote,
  });

  factory MastodonTimelineLiveFeeds.fromJson(Map<String, dynamic> json) =>
      _$MastodonTimelineLiveFeedsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTimelineLiveFeedsToJson(this);

  static Object? _readLocal(Map<dynamic, dynamic> json, String key) =>
      json['local'] ?? 'public';

  static Object? _readRemote(Map<dynamic, dynamic> json, String key) =>
      json['remote'] ?? 'public';

  /// Access level for the local timeline.
  @JsonKey(
    readValue: _readLocal,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel local;

  /// Access level for the federated timeline.
  @JsonKey(
    readValue: _readRemote,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel remote;
}

/// Access settings for hashtag feeds.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTimelineHashtagFeeds {
  const MastodonTimelineHashtagFeeds({
    required this.local,
    required this.remote,
  });

  factory MastodonTimelineHashtagFeeds.fromJson(Map<String, dynamic> json) =>
      _$MastodonTimelineHashtagFeedsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTimelineHashtagFeedsToJson(this);

  static Object? _readLocal(Map<dynamic, dynamic> json, String key) =>
      json['local'] ?? 'public';

  static Object? _readRemote(Map<dynamic, dynamic> json, String key) =>
      json['remote'] ?? 'public';

  @JsonKey(
    readValue: _readLocal,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel local;

  @JsonKey(
    readValue: _readRemote,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel remote;
}

/// Timeline access settings for the instance
/// (`configuration.timelines_access`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTimelinesAccess {
  const MastodonTimelinesAccess({
    this.liveFeeds,
    this.hashtagFeeds,
    this.trendingLinkFeeds,
  });

  factory MastodonTimelinesAccess.fromJson(Map<String, dynamic> json) =>
      _$MastodonTimelinesAccessFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTimelinesAccessToJson(this);

  /// Access settings for live feeds. Both timelines are considered public if
  /// null.
  final MastodonTimelineLiveFeeds? liveFeeds;

  /// Access settings for hashtag feeds.
  final MastodonTimelineHashtagFeeds? hashtagFeeds;

  /// Access settings for trending link feeds (Mastodon 4.5+).
  final MastodonTimelineLiveFeeds? trendingLinkFeeds;
}

/// URL settings for the instance (`configuration.urls`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceUrls {
  const MastodonInstanceUrls({
    this.streaming,
    this.status,
    this.about,
    this.privacyPolicy,
    this.termsOfService,
  });

  factory MastodonInstanceUrls.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceUrlsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceUrlsToJson(this);

  /// WebSocket streaming connection URL.
  final String? streaming;

  /// URL of the instance status page.
  final String? status;

  /// URL of the instance about page.
  final String? about;

  /// URL of the privacy policy.
  final String? privacyPolicy;

  /// URL of the terms of service.
  final String? termsOfService;
}

/// Status posting limits (`configuration.statuses`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusesConfiguration {
  const MastodonStatusesConfiguration({
    required this.maxCharacters,
    required this.maxMediaAttachments,
    required this.charactersReservedPerUrl,
  });

  factory MastodonStatusesConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusesConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusesConfigurationToJson(this);

  /// Maximum number of characters per status.
  @JsonKey(defaultValue: 500)
  final int maxCharacters;

  /// Maximum number of media attachments.
  @JsonKey(defaultValue: 4)
  final int maxMediaAttachments;

  /// Number of characters consumed by a URL.
  @JsonKey(defaultValue: 23)
  final int charactersReservedPerUrl;
}

/// Media attachment limits (`configuration.media_attachments`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMediaConfiguration {
  const MastodonMediaConfiguration({
    required this.supportedMimeTypes,
    this.descriptionLimit,
    this.imageSizeLimit,
    this.imageMatrixLimit,
    this.videoSizeLimit,
    this.videoFrameRateLimit,
    this.videoMatrixLimit,
  });

  factory MastodonMediaConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonMediaConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonMediaConfigurationToJson(this);

  /// List of accepted MIME types.
  @JsonKey(defaultValue: <String>[])
  final List<String> supportedMimeTypes;

  /// Maximum character count for media alt text.
  final int? descriptionLimit;

  /// Maximum file size for images (bytes).
  final int? imageSizeLimit;

  /// Maximum pixel count for images (width x height).
  final int? imageMatrixLimit;

  /// Maximum file size for videos (bytes).
  final int? videoSizeLimit;

  /// Maximum frame rate for videos.
  final int? videoFrameRateLimit;

  /// Maximum pixel count for videos (width x height).
  final int? videoMatrixLimit;
}

/// Poll limits (`configuration.polls`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPollsConfiguration {
  const MastodonPollsConfiguration({
    required this.maxOptions,
    required this.maxCharactersPerOption,
    required this.minExpiration,
    required this.maxExpiration,
  });

  factory MastodonPollsConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollsConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPollsConfigurationToJson(this);

  /// Maximum number of poll options.
  @JsonKey(defaultValue: 4)
  final int maxOptions;

  /// Maximum character count per option.
  @JsonKey(defaultValue: 50)
  final int maxCharactersPerOption;

  /// Minimum poll duration in seconds.
  @JsonKey(defaultValue: 300)
  final int minExpiration;

  /// Maximum poll duration in seconds.
  @JsonKey(defaultValue: 2629746)
  final int maxExpiration;
}

/// Account limits (`configuration.accounts`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountsConfiguration {
  const MastodonAccountsConfiguration({
    required this.maxFeaturedTags,
    required this.maxPinnedStatuses,
    required this.maxProfileFields,
    required this.profileFieldNameLimit,
    required this.profileFieldValueLimit,
  });

  factory MastodonAccountsConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountsConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAccountsConfigurationToJson(this);

  /// Maximum number of featured tags.
  @JsonKey(defaultValue: 10)
  final int maxFeaturedTags;

  /// Maximum number of pinned statuses.
  @JsonKey(defaultValue: 5)
  final int maxPinnedStatuses;

  /// Maximum number of profile fields.
  @JsonKey(defaultValue: 4)
  final int maxProfileFields;

  /// Maximum character count for profile field labels.
  @JsonKey(defaultValue: 255)
  final int profileFieldNameLimit;

  /// Maximum character count for profile field values.
  @JsonKey(defaultValue: 255)
  final int profileFieldValueLimit;
}

/// Instance configuration and limits (`configuration`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceConfiguration {
  const MastodonInstanceConfiguration({
    required this.urls,
    this.statuses,
    this.mediaAttachments,
    this.polls,
    this.accounts,
    this.timelinesAccess,
    this.translationEnabled,
    this.limitedFederation,
    this.vapidPublicKey,
  });

  factory MastodonInstanceConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceConfigurationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceConfigurationToJson(this);

  static Object? _readUrls(Map<dynamic, dynamic> json, String key) =>
      json['urls'] ?? const <String, dynamic>{};

  static Object? _readTranslationEnabled(
    Map<dynamic, dynamic> json,
    String key,
  ) => (json['translation'] as Map<dynamic, dynamic>?)?['enabled'];

  static Object? _readVapidPublicKey(
    Map<dynamic, dynamic> json,
    String key,
  ) => (json['vapid'] as Map<dynamic, dynamic>?)?['public_key'];

  /// URL settings (including streaming URL).
  @JsonKey(readValue: _readUrls)
  final MastodonInstanceUrls urls;

  /// Status posting limits.
  final MastodonStatusesConfiguration? statuses;

  /// Media attachment limits.
  final MastodonMediaConfiguration? mediaAttachments;

  /// Poll limits.
  final MastodonPollsConfiguration? polls;

  /// Account limits.
  final MastodonAccountsConfiguration? accounts;

  /// Timeline access settings. Both timelines are considered public if null.
  final MastodonTimelinesAccess? timelinesAccess;

  /// Whether the translation feature is enabled.
  @JsonKey(readValue: _readTranslationEnabled)
  final bool? translationEnabled;

  /// Whether federation is limited (Mastodon 4.3+).
  final bool? limitedFederation;

  /// VAPID public key (for Web Push notifications).
  @JsonKey(readValue: _readVapidPublicKey)
  final String? vapidPublicKey;
}

/// Thumbnail image information for the instance (`thumbnail`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceThumbnail {
  const MastodonInstanceThumbnail({
    required this.url,
    this.blurhash,
    this.versions,
  });

  factory MastodonInstanceThumbnail.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceThumbnailFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceThumbnailToJson(this);

  /// URL of the thumbnail image.
  final String url;

  /// Blurhash of the thumbnail image.
  final String? blurhash;

  /// Resolution-specific thumbnail versions.
  final MastodonInstanceThumbnailVersions? versions;
}

/// Resolution-specific thumbnail versions (`thumbnail.versions`).
@JsonSerializable()
class MastodonInstanceThumbnailVersions {
  const MastodonInstanceThumbnailVersions({this.at1x, this.at2x});

  factory MastodonInstanceThumbnailVersions.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonInstanceThumbnailVersionsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceThumbnailVersionsToJson(this);

  /// Standard resolution (1x) thumbnail URL.
  @JsonKey(name: '@1x')
  final String? at1x;

  /// High resolution (2x) thumbnail URL.
  @JsonKey(name: '@2x')
  final String? at2x;
}

/// Usage statistics of the instance (`usage`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceUsage {
  const MastodonInstanceUsage({required this.activeMonth});

  factory MastodonInstanceUsage.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceUsageFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceUsageToJson(this);

  static Object? _readActiveMonth(Map<dynamic, dynamic> json, String key) =>
      (json['users'] as Map<String, dynamic>?)?['active_month'];

  /// Number of active users in the past month.
  @JsonKey(readValue: _readActiveMonth, defaultValue: 0)
  final int activeMonth;
}

/// Registration settings for the instance (`registrations`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceRegistrations {
  const MastodonInstanceRegistrations({
    required this.enabled,
    required this.approvalRequired,
    this.message,
    this.url,
    this.minAge,
    this.reasonRequired,
  });

  factory MastodonInstanceRegistrations.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceRegistrationsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceRegistrationsToJson(this);

  /// Whether new registrations are accepted.
  @JsonKey(defaultValue: false)
  final bool enabled;

  /// Whether admin approval is required.
  @JsonKey(defaultValue: false)
  final bool approvalRequired;

  /// Message displayed when registration is disabled.
  final String? message;

  /// Custom registration URL for external authentication (SSO, etc.)
  /// (Mastodon 4.2+).
  final String? url;

  /// Minimum age required to register (Mastodon 4.4+).
  final int? minAge;

  /// Whether a reason is required when approval is needed (Mastodon 4.4+).
  final bool? reasonRequired;
}

/// Contact information for the instance (`contact`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceContact {
  const MastodonInstanceContact({this.email, this.account});

  factory MastodonInstanceContact.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceContactFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceContactToJson(this);

  /// Contact email address of the administrator.
  final String? email;

  /// Administrator account.
  final MastodonAccount? account;
}

/// Instance rule (`rules`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceRule {
  const MastodonInstanceRule({
    required this.id,
    required this.text,
    this.hint,
    this.translations,
  });

  factory MastodonInstanceRule.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceRuleFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceRuleToJson(this);

  /// ID of the rule.
  final String id;

  /// Body text of the rule.
  final String text;

  /// Supplementary description of the rule.
  final String? hint;

  /// Translation map keyed by language code.
  final Map<String, MastodonInstanceRuleTranslation>? translations;
}

/// Translation of an instance rule (`rules[].translations`).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceRuleTranslation {
  const MastodonInstanceRuleTranslation({
    required this.text,
    this.hint,
  });

  factory MastodonInstanceRuleTranslation.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonInstanceRuleTranslationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceRuleTranslationToJson(this);

  /// Translated body text of the rule.
  final String text;

  /// Translated supplementary description of the rule.
  final String? hint;
}

/// Mastodon instance information.
///
/// Corresponds to the response from `/api/v2/instance`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstance {
  const MastodonInstance({
    required this.domain,
    required this.title,
    required this.version,
    required this.configuration,
    required this.rules,
    this.sourceUrl,
    this.description,
    this.icon,
    this.thumbnail,
    this.usage,
    this.contact,
    this.registrations,
    this.languages,
    this.apiVersionMastodon,
  });

  factory MastodonInstance.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceToJson(this);

  static Object? _readConfiguration(Map<dynamic, dynamic> json, String key) =>
      json['configuration'] ?? const <String, dynamic>{};

  static Object? _readApiVersionMastodon(
    Map<dynamic, dynamic> json,
    String key,
  ) => (json['api_versions'] as Map<dynamic, dynamic>?)?['mastodon'];

  /// Domain name of the instance.
  final String domain;

  /// Title of the instance.
  @JsonKey(defaultValue: '')
  final String title;

  /// Mastodon version string (e.g. `4.3.0`).
  @JsonKey(defaultValue: '')
  final String version;

  /// URL of the source code repository. Can be used for fork detection.
  final String? sourceUrl;

  /// Description of the instance (HTML format).
  final String? description;

  /// List of instance icon images (Mastodon 4.3+).
  final List<MastodonInstanceIcon>? icon;

  /// Thumbnail image of the instance.
  final MastodonInstanceThumbnail? thumbnail;

  /// Usage statistics of the instance.
  final MastodonInstanceUsage? usage;

  /// Configuration and limits.
  @JsonKey(readValue: _readConfiguration)
  final MastodonInstanceConfiguration configuration;

  /// Contact information (admin email and account).
  final MastodonInstanceContact? contact;

  /// Registration settings.
  final MastodonInstanceRegistrations? registrations;

  /// List of supported language codes.
  final List<String>? languages;

  /// List of instance rules.
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  final List<MastodonInstanceRule> rules;

  /// Mastodon API version number (`api_versions.mastodon`).
  @JsonKey(readValue: _readApiVersionMastodon)
  final int? apiVersionMastodon;
}

/// Instance icon image (`icon`, Mastodon 4.3+).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceIcon {
  const MastodonInstanceIcon({
    required this.src,
    required this.size,
  });

  factory MastodonInstanceIcon.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceIconFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceIconToJson(this);

  /// URL of the icon image.
  final String src;

  /// Size of the icon (e.g. `48x48`, `72x72`).
  final String size;
}
