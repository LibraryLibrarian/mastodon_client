// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonTimelineLiveFeeds _$MastodonTimelineLiveFeedsFromJson(
  Map<String, dynamic> json,
) => MastodonTimelineLiveFeeds(
  local: $enumDecode(
    _$MastodonTimelineAccessLevelEnumMap,
    MastodonTimelineLiveFeeds._readLocal(json, 'local'),
    unknownValue: MastodonTimelineAccessLevel.public,
  ),
  remote: $enumDecode(
    _$MastodonTimelineAccessLevelEnumMap,
    MastodonTimelineLiveFeeds._readRemote(json, 'remote'),
    unknownValue: MastodonTimelineAccessLevel.public,
  ),
);

const _$MastodonTimelineAccessLevelEnumMap = {
  MastodonTimelineAccessLevel.public: 'public',
  MastodonTimelineAccessLevel.authenticated: 'authenticated',
  MastodonTimelineAccessLevel.disabled: 'disabled',
};

MastodonTimelineHashtagFeeds _$MastodonTimelineHashtagFeedsFromJson(
  Map<String, dynamic> json,
) => MastodonTimelineHashtagFeeds(
  local: $enumDecode(
    _$MastodonTimelineAccessLevelEnumMap,
    MastodonTimelineHashtagFeeds._readLocal(json, 'local'),
    unknownValue: MastodonTimelineAccessLevel.public,
  ),
  remote: $enumDecode(
    _$MastodonTimelineAccessLevelEnumMap,
    MastodonTimelineHashtagFeeds._readRemote(json, 'remote'),
    unknownValue: MastodonTimelineAccessLevel.public,
  ),
);

MastodonTimelinesAccess _$MastodonTimelinesAccessFromJson(
  Map<String, dynamic> json,
) => MastodonTimelinesAccess(
  liveFeeds: json['live_feeds'] == null
      ? null
      : MastodonTimelineLiveFeeds.fromJson(
          json['live_feeds'] as Map<String, dynamic>,
        ),
  hashtagFeeds: json['hashtag_feeds'] == null
      ? null
      : MastodonTimelineHashtagFeeds.fromJson(
          json['hashtag_feeds'] as Map<String, dynamic>,
        ),
);

MastodonInstanceUrls _$MastodonInstanceUrlsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceUrls(
  streaming: json['streaming'] as String?,
  status: json['status'] as String?,
  about: json['about'] as String?,
  privacyPolicy: json['privacy_policy'] as String?,
  termsOfService: json['terms_of_service'] as String?,
);

MastodonStatusesConfiguration _$MastodonStatusesConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonStatusesConfiguration(
  maxCharacters: (json['max_characters'] as num?)?.toInt() ?? 500,
  maxMediaAttachments: (json['max_media_attachments'] as num?)?.toInt() ?? 4,
  charactersReservedPerUrl:
      (json['characters_reserved_per_url'] as num?)?.toInt() ?? 23,
);

MastodonMediaConfiguration _$MastodonMediaConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonMediaConfiguration(
  supportedMimeTypes:
      (json['supported_mime_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  descriptionLimit: (json['description_limit'] as num?)?.toInt(),
  imageSizeLimit: (json['image_size_limit'] as num?)?.toInt(),
  imageMatrixLimit: (json['image_matrix_limit'] as num?)?.toInt(),
  videoSizeLimit: (json['video_size_limit'] as num?)?.toInt(),
  videoFrameRateLimit: (json['video_frame_rate_limit'] as num?)?.toInt(),
  videoMatrixLimit: (json['video_matrix_limit'] as num?)?.toInt(),
);

MastodonPollsConfiguration _$MastodonPollsConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonPollsConfiguration(
  maxOptions: (json['max_options'] as num?)?.toInt() ?? 4,
  maxCharactersPerOption:
      (json['max_characters_per_option'] as num?)?.toInt() ?? 50,
  minExpiration: (json['min_expiration'] as num?)?.toInt() ?? 300,
  maxExpiration: (json['max_expiration'] as num?)?.toInt() ?? 2629746,
);

MastodonAccountsConfiguration _$MastodonAccountsConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonAccountsConfiguration(
  maxFeaturedTags: (json['max_featured_tags'] as num?)?.toInt() ?? 10,
  maxPinnedStatuses: (json['max_pinned_statuses'] as num?)?.toInt() ?? 5,
  maxProfileFields: (json['max_profile_fields'] as num?)?.toInt() ?? 4,
  profileFieldNameLimit:
      (json['profile_field_name_limit'] as num?)?.toInt() ?? 255,
  profileFieldValueLimit:
      (json['profile_field_value_limit'] as num?)?.toInt() ?? 255,
);

MastodonInstanceConfiguration _$MastodonInstanceConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceConfiguration(
  urls: MastodonInstanceUrls.fromJson(
    MastodonInstanceConfiguration._readUrls(json, 'urls')
        as Map<String, dynamic>,
  ),
  statuses: json['statuses'] == null
      ? null
      : MastodonStatusesConfiguration.fromJson(
          json['statuses'] as Map<String, dynamic>,
        ),
  mediaAttachments: json['media_attachments'] == null
      ? null
      : MastodonMediaConfiguration.fromJson(
          json['media_attachments'] as Map<String, dynamic>,
        ),
  polls: json['polls'] == null
      ? null
      : MastodonPollsConfiguration.fromJson(
          json['polls'] as Map<String, dynamic>,
        ),
  accounts: json['accounts'] == null
      ? null
      : MastodonAccountsConfiguration.fromJson(
          json['accounts'] as Map<String, dynamic>,
        ),
  timelinesAccess: json['timelines_access'] == null
      ? null
      : MastodonTimelinesAccess.fromJson(
          json['timelines_access'] as Map<String, dynamic>,
        ),
  translationEnabled:
      MastodonInstanceConfiguration._readTranslationEnabled(
            json,
            'translation_enabled',
          )
          as bool?,
  limitedFederation: json['limited_federation'] as bool?,
  vapidPublicKey:
      MastodonInstanceConfiguration._readVapidPublicKey(
            json,
            'vapid_public_key',
          )
          as String?,
);

MastodonInstanceThumbnail _$MastodonInstanceThumbnailFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceThumbnail(
  url: json['url'] as String,
  blurhash: json['blurhash'] as String?,
);

MastodonInstanceUsage _$MastodonInstanceUsageFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceUsage(
  activeMonth:
      (MastodonInstanceUsage._readActiveMonth(json, 'active_month') as num?)
          ?.toInt() ??
      0,
);

MastodonInstanceRegistrations _$MastodonInstanceRegistrationsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceRegistrations(
  enabled: json['enabled'] as bool? ?? false,
  approvalRequired: json['approval_required'] as bool? ?? false,
  message: json['message'] as String?,
);

MastodonInstanceContact _$MastodonInstanceContactFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceContact(
  email: json['email'] as String?,
  account: json['account'] == null
      ? null
      : MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
);

MastodonInstanceRule _$MastodonInstanceRuleFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceRule(
  id: json['id'] as String,
  text: json['text'] as String,
  hint: json['hint'] as String?,
);

MastodonInstance _$MastodonInstanceFromJson(
  Map<String, dynamic> json,
) => MastodonInstance(
  domain: json['domain'] as String,
  title: json['title'] as String? ?? '',
  version: json['version'] as String? ?? '',
  configuration: MastodonInstanceConfiguration.fromJson(
    MastodonInstance._readConfiguration(json, 'configuration')
        as Map<String, dynamic>,
  ),
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => MastodonInstanceRule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  sourceUrl: json['source_url'] as String?,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] == null
      ? null
      : MastodonInstanceThumbnail.fromJson(
          json['thumbnail'] as Map<String, dynamic>,
        ),
  usage: json['usage'] == null
      ? null
      : MastodonInstanceUsage.fromJson(json['usage'] as Map<String, dynamic>),
  contact: json['contact'] == null
      ? null
      : MastodonInstanceContact.fromJson(
          json['contact'] as Map<String, dynamic>,
        ),
  registrations: json['registrations'] == null
      ? null
      : MastodonInstanceRegistrations.fromJson(
          json['registrations'] as Map<String, dynamic>,
        ),
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  apiVersionMastodon:
      (MastodonInstance._readApiVersionMastodon(json, 'api_version_mastodon')
              as num?)
          ?.toInt(),
);
