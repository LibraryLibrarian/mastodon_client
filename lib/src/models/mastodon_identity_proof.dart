import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_identity_proof.freezed.dart';
part 'mastodon_identity_proof.g.dart';

/// Identity proof information for an account.
///
/// **Deprecated**: Always returns an empty array since Mastodon 3.5.0.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonIdentityProof with _$MastodonIdentityProof {
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
  @override
  final String provider;

  /// Username on the provider.
  @override
  final String providerUsername;

  /// Timestamp of the last update.
  @override
  final String updatedAt;

  /// URL of the proof.
  @override
  final String proofUrl;

  /// URL of the profile on the provider.
  @override
  final String profileUrl;
}
