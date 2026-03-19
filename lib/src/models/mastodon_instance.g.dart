// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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

Map<String, dynamic> _$MastodonTimelineLiveFeedsToJson(
  MastodonTimelineLiveFeeds instance,
) => <String, dynamic>{
  'local': _$MastodonTimelineAccessLevelEnumMap[instance.local]!,
  'remote': _$MastodonTimelineAccessLevelEnumMap[instance.remote]!,
};

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

Map<String, dynamic> _$MastodonTimelineHashtagFeedsToJson(
  MastodonTimelineHashtagFeeds instance,
) => <String, dynamic>{
  'local': _$MastodonTimelineAccessLevelEnumMap[instance.local]!,
  'remote': _$MastodonTimelineAccessLevelEnumMap[instance.remote]!,
};

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
  trendingLinkFeeds: json['trending_link_feeds'] == null
      ? null
      : MastodonTimelineLiveFeeds.fromJson(
          json['trending_link_feeds'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MastodonTimelinesAccessToJson(
  MastodonTimelinesAccess instance,
) => <String, dynamic>{
  'live_feeds': instance.liveFeeds,
  'hashtag_feeds': instance.hashtagFeeds,
  'trending_link_feeds': instance.trendingLinkFeeds,
};

MastodonInstanceUrls _$MastodonInstanceUrlsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceUrls(
  streaming: json['streaming'] as String?,
  status: json['status'] as String?,
  about: json['about'] as String?,
  privacyPolicy: json['privacy_policy'] as String?,
  termsOfService: json['terms_of_service'] as String?,
);

Map<String, dynamic> _$MastodonInstanceUrlsToJson(
  MastodonInstanceUrls instance,
) => <String, dynamic>{
  'streaming': instance.streaming,
  'status': instance.status,
  'about': instance.about,
  'privacy_policy': instance.privacyPolicy,
  'terms_of_service': instance.termsOfService,
};

MastodonStatusesConfiguration _$MastodonStatusesConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonStatusesConfiguration(
  maxCharacters: (json['max_characters'] as num?)?.toInt() ?? 500,
  maxMediaAttachments: (json['max_media_attachments'] as num?)?.toInt() ?? 4,
  charactersReservedPerUrl:
      (json['characters_reserved_per_url'] as num?)?.toInt() ?? 23,
);

Map<String, dynamic> _$MastodonStatusesConfigurationToJson(
  MastodonStatusesConfiguration instance,
) => <String, dynamic>{
  'max_characters': instance.maxCharacters,
  'max_media_attachments': instance.maxMediaAttachments,
  'characters_reserved_per_url': instance.charactersReservedPerUrl,
};

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

Map<String, dynamic> _$MastodonMediaConfigurationToJson(
  MastodonMediaConfiguration instance,
) => <String, dynamic>{
  'supported_mime_types': instance.supportedMimeTypes,
  'description_limit': instance.descriptionLimit,
  'image_size_limit': instance.imageSizeLimit,
  'image_matrix_limit': instance.imageMatrixLimit,
  'video_size_limit': instance.videoSizeLimit,
  'video_frame_rate_limit': instance.videoFrameRateLimit,
  'video_matrix_limit': instance.videoMatrixLimit,
};

MastodonPollsConfiguration _$MastodonPollsConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonPollsConfiguration(
  maxOptions: (json['max_options'] as num?)?.toInt() ?? 4,
  maxCharactersPerOption:
      (json['max_characters_per_option'] as num?)?.toInt() ?? 50,
  minExpiration: (json['min_expiration'] as num?)?.toInt() ?? 300,
  maxExpiration: (json['max_expiration'] as num?)?.toInt() ?? 2629746,
);

Map<String, dynamic> _$MastodonPollsConfigurationToJson(
  MastodonPollsConfiguration instance,
) => <String, dynamic>{
  'max_options': instance.maxOptions,
  'max_characters_per_option': instance.maxCharactersPerOption,
  'min_expiration': instance.minExpiration,
  'max_expiration': instance.maxExpiration,
};

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

Map<String, dynamic> _$MastodonAccountsConfigurationToJson(
  MastodonAccountsConfiguration instance,
) => <String, dynamic>{
  'max_featured_tags': instance.maxFeaturedTags,
  'max_pinned_statuses': instance.maxPinnedStatuses,
  'max_profile_fields': instance.maxProfileFields,
  'profile_field_name_limit': instance.profileFieldNameLimit,
  'profile_field_value_limit': instance.profileFieldValueLimit,
};

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

Map<String, dynamic> _$MastodonInstanceConfigurationToJson(
  MastodonInstanceConfiguration instance,
) => <String, dynamic>{
  'urls': instance.urls,
  'statuses': instance.statuses,
  'media_attachments': instance.mediaAttachments,
  'polls': instance.polls,
  'accounts': instance.accounts,
  'timelines_access': instance.timelinesAccess,
  'translation_enabled': instance.translationEnabled,
  'limited_federation': instance.limitedFederation,
  'vapid_public_key': instance.vapidPublicKey,
};

MastodonInstanceThumbnail _$MastodonInstanceThumbnailFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceThumbnail(
  url: json['url'] as String,
  blurhash: json['blurhash'] as String?,
  versions: json['versions'] == null
      ? null
      : MastodonInstanceThumbnailVersions.fromJson(
          json['versions'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MastodonInstanceThumbnailToJson(
  MastodonInstanceThumbnail instance,
) => <String, dynamic>{
  'url': instance.url,
  'blurhash': instance.blurhash,
  'versions': instance.versions,
};

MastodonInstanceThumbnailVersions _$MastodonInstanceThumbnailVersionsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceThumbnailVersions(
  at1x: json['@1x'] as String?,
  at2x: json['@2x'] as String?,
);

Map<String, dynamic> _$MastodonInstanceThumbnailVersionsToJson(
  MastodonInstanceThumbnailVersions instance,
) => <String, dynamic>{'@1x': instance.at1x, '@2x': instance.at2x};

MastodonInstanceUsage _$MastodonInstanceUsageFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceUsage(
  activeMonth:
      (MastodonInstanceUsage._readActiveMonth(json, 'active_month') as num?)
          ?.toInt() ??
      0,
);

Map<String, dynamic> _$MastodonInstanceUsageToJson(
  MastodonInstanceUsage instance,
) => <String, dynamic>{'active_month': instance.activeMonth};

MastodonInstanceRegistrations _$MastodonInstanceRegistrationsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceRegistrations(
  enabled: json['enabled'] as bool? ?? false,
  approvalRequired: json['approval_required'] as bool? ?? false,
  message: json['message'] as String?,
  url: json['url'] as String?,
  minAge: (json['min_age'] as num?)?.toInt(),
  reasonRequired: json['reason_required'] as bool?,
);

Map<String, dynamic> _$MastodonInstanceRegistrationsToJson(
  MastodonInstanceRegistrations instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'approval_required': instance.approvalRequired,
  'message': instance.message,
  'url': instance.url,
  'min_age': instance.minAge,
  'reason_required': instance.reasonRequired,
};

MastodonInstanceContact _$MastodonInstanceContactFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceContact(
  email: json['email'] as String?,
  account: json['account'] == null
      ? null
      : MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MastodonInstanceContactToJson(
  MastodonInstanceContact instance,
) => <String, dynamic>{'email': instance.email, 'account': instance.account};

MastodonInstanceRule _$MastodonInstanceRuleFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceRule(
  id: json['id'] as String,
  text: json['text'] as String,
  hint: json['hint'] as String?,
  translations: (json['translations'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(
      k,
      MastodonInstanceRuleTranslation.fromJson(e as Map<String, dynamic>),
    ),
  ),
);

Map<String, dynamic> _$MastodonInstanceRuleToJson(
  MastodonInstanceRule instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'hint': instance.hint,
  'translations': instance.translations,
};

MastodonInstanceRuleTranslation _$MastodonInstanceRuleTranslationFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceRuleTranslation(
  text: json['text'] as String,
  hint: json['hint'] as String?,
);

Map<String, dynamic> _$MastodonInstanceRuleTranslationToJson(
  MastodonInstanceRuleTranslation instance,
) => <String, dynamic>{'text': instance.text, 'hint': instance.hint};

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
  icon: (json['icon'] as List<dynamic>?)
      ?.map((e) => MastodonInstanceIcon.fromJson(e as Map<String, dynamic>))
      .toList(),
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

Map<String, dynamic> _$MastodonInstanceToJson(MastodonInstance instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'title': instance.title,
      'version': instance.version,
      'source_url': instance.sourceUrl,
      'description': instance.description,
      'icon': instance.icon,
      'thumbnail': instance.thumbnail,
      'usage': instance.usage,
      'configuration': instance.configuration,
      'contact': instance.contact,
      'registrations': instance.registrations,
      'languages': instance.languages,
      'rules': instance.rules,
      'api_version_mastodon': instance.apiVersionMastodon,
    };

MastodonInstanceIcon _$MastodonInstanceIconFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceIcon(
  src: json['src'] as String,
  size: json['size'] as String,
);

Map<String, dynamic> _$MastodonInstanceIconToJson(
  MastodonInstanceIcon instance,
) => <String, dynamic>{'src': instance.src, 'size': instance.size};
