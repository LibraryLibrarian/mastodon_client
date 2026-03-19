// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonPreferences _$MastodonPreferencesFromJson(
  Map<String, dynamic> json,
) => MastodonPreferences(
  postingDefaultVisibility:
      json['posting:default:visibility'] as String? ?? 'public',
  postingDefaultSensitive: json['posting:default:sensitive'] as bool? ?? false,
  postingDefaultLanguage: json['posting:default:language'] as String?,
  postingDefaultQuotePolicy: json['posting:default:quote_policy'] as String?,
  readingExpandMedia: json['reading:expand:media'] as String? ?? 'default',
  readingExpandSpoilers: json['reading:expand:spoilers'] as bool? ?? false,
);

Map<String, dynamic> _$MastodonPreferencesToJson(
  MastodonPreferences instance,
) => <String, dynamic>{
  'posting:default:visibility': instance.postingDefaultVisibility,
  'posting:default:sensitive': instance.postingDefaultSensitive,
  'posting:default:language': instance.postingDefaultLanguage,
  'posting:default:quote_policy': instance.postingDefaultQuotePolicy,
  'reading:expand:media': instance.readingExpandMedia,
  'reading:expand:spoilers': instance.readingExpandSpoilers,
};
