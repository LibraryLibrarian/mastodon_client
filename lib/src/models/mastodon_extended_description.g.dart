// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_extended_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonExtendedDescription _$MastodonExtendedDescriptionFromJson(
  Map<String, dynamic> json,
) => MastodonExtendedDescription(
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
  content: json['content'] as String? ?? '',
);
