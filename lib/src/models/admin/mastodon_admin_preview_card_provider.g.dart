// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_preview_card_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminPreviewCardProvider _$MastodonAdminPreviewCardProviderFromJson(
  Map<String, dynamic> json,
) => MastodonAdminPreviewCardProvider(
  id: json['id'] as String,
  domain: json['domain'] as String,
  trendable: json['trendable'] as bool?,
  reviewedAt: const SafeDateTimeConverter().fromJson(
    json['reviewed_at'] as String?,
  ),
  requestedReviewAt: const SafeDateTimeConverter().fromJson(
    json['requested_review_at'] as String?,
  ),
  requiresReview: json['requires_review'] as bool?,
);

Map<String, dynamic> _$MastodonAdminPreviewCardProviderToJson(
  MastodonAdminPreviewCardProvider instance,
) => <String, dynamic>{
  'id': instance.id,
  'domain': instance.domain,
  'trendable': instance.trendable,
  'reviewed_at': const SafeDateTimeConverter().toJson(instance.reviewedAt),
  'requested_review_at': const SafeDateTimeConverter().toJson(
    instance.requestedReviewAt,
  ),
  'requires_review': instance.requiresReview,
};
