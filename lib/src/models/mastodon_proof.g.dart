// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonProof _$MastodonProofFromJson(Map<String, dynamic> json) =>
    MastodonProof(
      avatar: json['avatar'] as String,
      signatures:
          (json['signatures'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MastodonProofSignature.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$MastodonProofToJson(MastodonProof instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'signatures': instance.signatures.map((e) => e.toJson()).toList(),
    };

MastodonProofSignature _$MastodonProofSignatureFromJson(
  Map<String, dynamic> json,
) => MastodonProofSignature(
  sigHash: json['sig_hash'] as String,
  kbUsername: json['kb_username'] as String,
);

Map<String, dynamic> _$MastodonProofSignatureToJson(
  MastodonProofSignature instance,
) => <String, dynamic>{
  'sig_hash': instance.sigHash,
  'kb_username': instance.kbUsername,
};
