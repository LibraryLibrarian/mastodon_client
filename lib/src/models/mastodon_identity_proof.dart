import 'package:json_annotation/json_annotation.dart';

part 'mastodon_identity_proof.g.dart';

/// アカウントの本人確認証明情報
///
/// **非推奨**: Mastodon 3.5.0 以降は常に空配列を返す。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  /// 証明プロバイダー名（例: Keybase）
  final String provider;

  /// プロバイダー上のユーザー名
  final String providerUsername;

  /// 最終更新日時
  final String updatedAt;

  /// 証明のURL
  final String proofUrl;

  /// プロバイダー上のプロフィールURL
  final String profileUrl;
}
