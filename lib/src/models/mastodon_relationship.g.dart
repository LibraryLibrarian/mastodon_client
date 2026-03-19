// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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

Map<String, dynamic> _$MastodonRelationshipToJson(
  MastodonRelationship instance,
) => <String, dynamic>{
  'id': instance.id,
  'following': instance.following,
  'showing_reblogs': instance.showingReblogs,
  'notifying': instance.notifying,
  'languages': instance.languages,
  'followed_by': instance.followedBy,
  'blocking': instance.blocking,
  'blocked_by': instance.blockedBy,
  'muting': instance.muting,
  'muting_notifications': instance.mutingNotifications,
  'requested': instance.requested,
  'requested_by': instance.requestedBy,
  'domain_blocking': instance.domainBlocking,
  'endorsed': instance.endorsed,
  'note': instance.note,
};
