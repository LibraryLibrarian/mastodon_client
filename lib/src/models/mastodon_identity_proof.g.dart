// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_identity_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonIdentityProof _$MastodonIdentityProofFromJson(
  Map<String, dynamic> json,
) => MastodonIdentityProof(
  provider: json['provider'] as String,
  providerUsername: json['provider_username'] as String,
  updatedAt: json['updated_at'] as String,
  proofUrl: json['proof_url'] as String,
  profileUrl: json['profile_url'] as String,
);

Map<String, dynamic> _$MastodonIdentityProofToJson(
  MastodonIdentityProof instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'provider_username': instance.providerUsername,
  'updated_at': instance.updatedAt,
  'proof_url': instance.proofUrl,
  'profile_url': instance.profileUrl,
};
