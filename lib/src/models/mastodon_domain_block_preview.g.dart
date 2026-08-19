// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_domain_block_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonDomainBlockPreview _$MastodonDomainBlockPreviewFromJson(
  Map<String, dynamic> json,
) => MastodonDomainBlockPreview(
  followingCount: (json['following_count'] as num?)?.toInt() ?? 0,
  followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MastodonDomainBlockPreviewToJson(
  MastodonDomainBlockPreview instance,
) => <String, dynamic>{
  'following_count': instance.followingCount,
  'followers_count': instance.followersCount,
};
