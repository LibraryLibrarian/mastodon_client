// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonRelationship _$MastodonRelationshipFromJson(
  Map<String, dynamic> json,
) => MastodonRelationship(
  id: json['id'] as String,
  following: json['following'] as bool? ?? false,
  showingReblogs: json['showing_reblogs'] as bool? ?? true,
  notifying: json['notifying'] as bool? ?? false,
  followedBy: json['followed_by'] as bool? ?? false,
  blocking: json['blocking'] as bool? ?? false,
  blockedBy: json['blocked_by'] as bool? ?? false,
  muting: json['muting'] as bool? ?? false,
  mutingNotifications: json['muting_notifications'] as bool? ?? false,
  requested: json['requested'] as bool? ?? false,
  requestedBy: json['requested_by'] as bool? ?? false,
  domainBlocking: json['domain_blocking'] as bool? ?? false,
  endorsed: json['endorsed'] as bool? ?? false,
  note: json['note'] as String? ?? '',
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);
