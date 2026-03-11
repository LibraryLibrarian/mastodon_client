// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_status_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonStatusContext _$MastodonStatusContextFromJson(
  Map<String, dynamic> json,
) => MastodonStatusContext(
  ancestors:
      (json['ancestors'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  descendants:
      (json['descendants'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);
