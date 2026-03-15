// GENERATED CODE - DO NOT MODIFY BY HAND

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
