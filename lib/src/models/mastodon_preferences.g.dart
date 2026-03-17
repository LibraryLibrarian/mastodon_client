// GENERATED CODE - DO NOT MODIFY BY HAND

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
