import 'package:json_annotation/json_annotation.dart';

part 'mastodon_proof.g.dart';

/// Proof information returned by an identity verification provider.
///
/// Retrieved via `GET /api/proofs`.
///
/// **Deprecated**: The identity proof feature was removed in Mastodon 3.5.0.
/// Provided for backward compatibility with older server versions.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonProof {
  /// Creates a [MastodonProof] with the given fields.
  const MastodonProof({
    required this.avatar,
    required this.signatures,
  });

  /// Creates a [MastodonProof] from a JSON map.
  factory MastodonProof.fromJson(Map<String, dynamic> json) =>
      _$MastodonProofFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonProofToJson(this);

  /// Avatar URL on the provider.
  final String avatar;

  /// List of signature information.
  @JsonKey(defaultValue: <MastodonProofSignature>[])
  final List<MastodonProofSignature> signatures;
}

/// Signature information for an identity proof.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonProofSignature {
  /// Creates a [MastodonProofSignature] with the given fields.
  const MastodonProofSignature({
    required this.sigHash,
    required this.kbUsername,
  });

  /// Creates a [MastodonProofSignature] from a JSON map.
  factory MastodonProofSignature.fromJson(Map<String, dynamic> json) =>
      _$MastodonProofSignatureFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonProofSignatureToJson(this);

  /// Hash value of the signature.
  final String sigHash;

  /// Username on Keybase.
  final String kbUsername;
}
