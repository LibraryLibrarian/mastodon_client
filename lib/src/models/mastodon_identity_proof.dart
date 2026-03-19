import 'package:json_annotation/json_annotation.dart';

part 'mastodon_identity_proof.g.dart';

/// Identity proof information for an account.
///
/// **Deprecated**: Always returns an empty array since Mastodon 3.5.0.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonIdentityProof {
  const MastodonIdentityProof({
    required this.provider,
    required this.providerUsername,
    required this.updatedAt,
    required this.proofUrl,
    required this.profileUrl,
  });

  factory MastodonIdentityProof.fromJson(Map<String, dynamic> json) =>
      _$MastodonIdentityProofFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonIdentityProofToJson(this);

  /// Name of the proof provider (e.g. Keybase).
  final String provider;

  /// Username on the provider.
  final String providerUsername;

  /// Timestamp of the last update.
  final String updatedAt;

  /// URL of the proof.
  final String proofUrl;

  /// URL of the profile on the provider.
  final String profileUrl;
}
