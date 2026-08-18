import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_instance.freezed.dart';
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
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTimelineLiveFeeds with _$MastodonTimelineLiveFeeds {
  const MastodonTimelineLiveFeeds({required this.local, required this.remote});

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
  @override
  final MastodonTimelineAccessLevel local;

  /// Access level for the federated timeline.
  @JsonKey(
    readValue: _readRemote,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  @override
  final MastodonTimelineAccessLevel remote;
}

/// Access settings for hashtag feeds.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTimelineHashtagFeeds with _$MastodonTimelineHashtagFeeds {
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
  @override
  final MastodonTimelineAccessLevel local;

  @JsonKey(
    readValue: _readRemote,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  @override
  final MastodonTimelineAccessLevel remote;
}

/// Timeline access settings for the instance
/// (`configuration.timelines_access`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTimelinesAccess with _$MastodonTimelinesAccess {
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
  @override
  final MastodonTimelineLiveFeeds? liveFeeds;

  /// Access settings for hashtag feeds.
  @override
  final MastodonTimelineHashtagFeeds? hashtagFeeds;

  /// Access settings for trending link feeds (Mastodon 4.5+).
  @override
  final MastodonTimelineLiveFeeds? trendingLinkFeeds;
}

/// URL settings for the instance (`configuration.urls`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceUrls with _$MastodonInstanceUrls {
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
  @override
  final String? streaming;

  /// URL of the instance status page.
  @override
  final String? status;

  /// URL of the instance about page.
  @override
  final String? about;

  /// URL of the privacy policy.
  @override
  final String? privacyPolicy;

  /// URL of the terms of service.
  @override
  final String? termsOfService;
}

/// Status posting limits (`configuration.statuses`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusesConfiguration with _$MastodonStatusesConfiguration {
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
  @override
  final int maxCharacters;

  /// Maximum number of media attachments.
  @JsonKey(defaultValue: 4)
  @override
  final int maxMediaAttachments;

  /// Number of characters consumed by a URL.
  @JsonKey(defaultValue: 23)
  @override
  final int charactersReservedPerUrl;
}

/// Media attachment limits (`configuration.media_attachments`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMediaConfiguration with _$MastodonMediaConfiguration {
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
  @override
  final List<String> supportedMimeTypes;

  /// Maximum character count for media alt text.
  @override
  final int? descriptionLimit;

  /// Maximum file size for images (bytes).
  @override
  final int? imageSizeLimit;

  /// Maximum pixel count for images (width x height).
  @override
  final int? imageMatrixLimit;

  /// Maximum file size for videos (bytes).
  @override
  final int? videoSizeLimit;

  /// Maximum frame rate for videos.
  @override
  final int? videoFrameRateLimit;

  /// Maximum pixel count for videos (width x height).
  @override
  final int? videoMatrixLimit;
}

/// Poll limits (`configuration.polls`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPollsConfiguration with _$MastodonPollsConfiguration {
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
  @override
  final int maxOptions;

  /// Maximum character count per option.
  @JsonKey(defaultValue: 50)
  @override
  final int maxCharactersPerOption;

  /// Minimum poll duration in seconds.
  @JsonKey(defaultValue: 300)
  @override
  final int minExpiration;

  /// Maximum poll duration in seconds.
  @JsonKey(defaultValue: 2629746)
  @override
  final int maxExpiration;
}

/// Account limits (`configuration.accounts`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountsConfiguration with _$MastodonAccountsConfiguration {
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
  @override
  final int maxFeaturedTags;

  /// Maximum number of pinned statuses.
  @JsonKey(defaultValue: 5)
  @override
  final int maxPinnedStatuses;

  /// Maximum number of profile fields.
  @JsonKey(defaultValue: 4)
  @override
  final int maxProfileFields;

  /// Maximum character count for profile field labels.
  @JsonKey(defaultValue: 255)
  @override
  final int profileFieldNameLimit;

  /// Maximum character count for profile field values.
  @JsonKey(defaultValue: 255)
  @override
  final int profileFieldValueLimit;
}

/// Instance configuration and limits (`configuration`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceConfiguration with _$MastodonInstanceConfiguration {
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

  static Object? _readVapidPublicKey(Map<dynamic, dynamic> json, String key) =>
      (json['vapid'] as Map<dynamic, dynamic>?)?['public_key'];

  /// URL settings (including streaming URL).
  @JsonKey(readValue: _readUrls)
  @override
  final MastodonInstanceUrls urls;

  /// Status posting limits.
  @override
  final MastodonStatusesConfiguration? statuses;

  /// Media attachment limits.
  @override
  final MastodonMediaConfiguration? mediaAttachments;

  /// Poll limits.
  @override
  final MastodonPollsConfiguration? polls;

  /// Account limits.
  @override
  final MastodonAccountsConfiguration? accounts;

  /// Timeline access settings. Both timelines are considered public if null.
  @override
  final MastodonTimelinesAccess? timelinesAccess;

  /// Whether the translation feature is enabled.
  @JsonKey(readValue: _readTranslationEnabled)
  @override
  final bool? translationEnabled;

  /// Whether federation is limited (Mastodon 4.3+).
  @override
  final bool? limitedFederation;

  /// VAPID public key (for Web Push notifications).
  @JsonKey(readValue: _readVapidPublicKey)
  @override
  final String? vapidPublicKey;
}

/// Thumbnail image information for the instance (`thumbnail`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceThumbnail with _$MastodonInstanceThumbnail {
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
  @override
  final String url;

  /// Blurhash of the thumbnail image.
  @override
  final String? blurhash;

  /// Resolution-specific thumbnail versions.
  @override
  final MastodonInstanceThumbnailVersions? versions;
}

/// Resolution-specific thumbnail versions (`thumbnail.versions`).
@Freezed(toStringOverride: false)
@JsonSerializable()
class MastodonInstanceThumbnailVersions
    with _$MastodonInstanceThumbnailVersions {
  const MastodonInstanceThumbnailVersions({this.at1x, this.at2x});

  factory MastodonInstanceThumbnailVersions.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonInstanceThumbnailVersionsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceThumbnailVersionsToJson(this);

  /// Standard resolution (1x) thumbnail URL.
  @JsonKey(name: '@1x')
  @override
  final String? at1x;

  /// High resolution (2x) thumbnail URL.
  @JsonKey(name: '@2x')
  @override
  final String? at2x;
}

/// Usage statistics of the instance (`usage`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceUsage with _$MastodonInstanceUsage {
  const MastodonInstanceUsage({required this.activeMonth});

  factory MastodonInstanceUsage.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceUsageFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceUsageToJson(this);

  static Object? _readActiveMonth(Map<dynamic, dynamic> json, String key) =>
      (json['users'] as Map<String, dynamic>?)?['active_month'];

  /// Number of active users in the past month.
  @JsonKey(readValue: _readActiveMonth, defaultValue: 0)
  @override
  final int activeMonth;
}

/// Registration settings for the instance (`registrations`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceRegistrations with _$MastodonInstanceRegistrations {
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
  @override
  final bool enabled;

  /// Whether admin approval is required.
  @JsonKey(defaultValue: false)
  @override
  final bool approvalRequired;

  /// Message displayed when registration is disabled.
  @override
  final String? message;

  /// Custom registration URL for external authentication (SSO, etc.)
  /// (Mastodon 4.2+).
  @override
  final String? url;

  /// Minimum age required to register (Mastodon 4.4+).
  @override
  final int? minAge;

  /// Whether a reason is required when approval is needed (Mastodon 4.4+).
  @override
  final bool? reasonRequired;
}

/// Contact information for the instance (`contact`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceContact with _$MastodonInstanceContact {
  const MastodonInstanceContact({this.email, this.account});

  factory MastodonInstanceContact.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceContactFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceContactToJson(this);

  /// Contact email address of the administrator.
  @override
  final String? email;

  /// Administrator account.
  @override
  final MastodonAccount? account;
}

/// Instance rule (`rules`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceRule with _$MastodonInstanceRule {
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
  @override
  final String id;

  /// Body text of the rule.
  @override
  final String text;

  /// Supplementary description of the rule.
  @override
  final String? hint;

  /// Translation map keyed by language code.
  @override
  final Map<String, MastodonInstanceRuleTranslation>? translations;
}

/// Translation of an instance rule (`rules[].translations`).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceRuleTranslation with _$MastodonInstanceRuleTranslation {
  const MastodonInstanceRuleTranslation({required this.text, this.hint});

  factory MastodonInstanceRuleTranslation.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceRuleTranslationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceRuleTranslationToJson(this);

  /// Translated body text of the rule.
  @override
  final String text;

  /// Translated supplementary description of the rule.
  @override
  final String? hint;
}

/// Mastodon instance information.
///
/// Corresponds to the response from `/api/v2/instance`.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstance with _$MastodonInstance {
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
    this.wrapstodon,
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
  @override
  final String domain;

  /// Title of the instance.
  @JsonKey(defaultValue: '')
  @override
  final String title;

  /// Mastodon version string (e.g. `4.3.0`).
  @JsonKey(defaultValue: '')
  @override
  final String version;

  /// URL of the source code repository. Can be used for fork detection.
  @override
  final String? sourceUrl;

  /// Description of the instance (HTML format).
  @override
  final String? description;

  /// List of instance icon images (Mastodon 4.3+).
  @override
  final List<MastodonInstanceIcon>? icon;

  /// Thumbnail image of the instance.
  @override
  final MastodonInstanceThumbnail? thumbnail;

  /// Usage statistics of the instance.
  @override
  final MastodonInstanceUsage? usage;

  /// Configuration and limits.
  @JsonKey(readValue: _readConfiguration)
  @override
  final MastodonInstanceConfiguration configuration;

  /// Contact information (admin email and account).
  @override
  final MastodonInstanceContact? contact;

  /// Registration settings.
  @override
  final MastodonInstanceRegistrations? registrations;

  /// List of supported language codes.
  @override
  final List<String>? languages;

  /// List of instance rules.
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  @override
  final List<MastodonInstanceRule> rules;

  /// Mastodon API version number (`api_versions.mastodon`).
  @JsonKey(readValue: _readApiVersionMastodon)
  @override
  final int? apiVersionMastodon;

  /// Year of the annual report campaign currently being offered, or null
  /// when no campaign is running.
  ///
  /// The instance only advertises a campaign while the feature is enabled and
  /// the campaign window is open, so this is null for most of the year.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final int? wrapstodon;
}

/// Instance icon image (`icon`, Mastodon 4.3+).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceIcon with _$MastodonInstanceIcon {
  const MastodonInstanceIcon({required this.src, required this.size});

  factory MastodonInstanceIcon.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceIconFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonInstanceIconToJson(this);

  /// URL of the icon image.
  @override
  final String src;

  /// Size of the icon (e.g. `48x48`, `72x72`).
  @override
  final String size;
}
