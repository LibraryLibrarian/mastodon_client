// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_instance_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonInstanceV1Urls _$MastodonInstanceV1UrlsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceV1Urls(streamingApi: json['streaming_api'] as String?);

MastodonInstanceV1Stats _$MastodonInstanceV1StatsFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceV1Stats(
  userCount: (json['user_count'] as num?)?.toInt() ?? 0,
  statusCount: (json['status_count'] as num?)?.toInt() ?? 0,
  domainCount: (json['domain_count'] as num?)?.toInt() ?? 0,
);

MastodonInstanceV1Configuration _$MastodonInstanceV1ConfigurationFromJson(
  Map<String, dynamic> json,
) => MastodonInstanceV1Configuration(
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
);

MastodonInstanceV1 _$MastodonInstanceV1FromJson(
  Map<String, dynamic> json,
) => MastodonInstanceV1(
  uri: json['uri'] as String,
  title: json['title'] as String? ?? '',
  version: json['version'] as String? ?? '',
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => MastodonInstanceRule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  shortDescription: json['short_description'] as String?,
  description: json['description'] as String?,
  email: json['email'] as String?,
  urls: json['urls'] == null
      ? null
      : MastodonInstanceV1Urls.fromJson(json['urls'] as Map<String, dynamic>),
  stats: json['stats'] == null
      ? null
      : MastodonInstanceV1Stats.fromJson(json['stats'] as Map<String, dynamic>),
  thumbnail: json['thumbnail'] as String?,
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  registrations: json['registrations'] as bool? ?? false,
  approvalRequired: json['approval_required'] as bool? ?? false,
  invitesEnabled: json['invites_enabled'] as bool? ?? false,
  configuration: json['configuration'] == null
      ? null
      : MastodonInstanceV1Configuration.fromJson(
          json['configuration'] as Map<String, dynamic>,
        ),
  contactAccount: json['contact_account'] == null
      ? null
      : MastodonAccount.fromJson(
          json['contact_account'] as Map<String, dynamic>,
        ),
);
