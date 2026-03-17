import 'package:json_annotation/json_annotation.dart';

part 'mastodon_proof.g.dart';

/// 本人確認プロバイダーから返される証明情報
///
/// `GET /api/proofs` で取得される。
///
/// **非推奨**: Mastodon 3.5.0 以降では本人確認証明機能は削除されている。
/// 古いサーバーバージョンとの互換性のために提供される。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonProof {
  /// 各フィールドを指定して [MastodonProof] を生成する
  const MastodonProof({
    required this.avatar,
    required this.signatures,
  });

  /// JSON マップから [MastodonProof] を生成する
  factory MastodonProof.fromJson(Map<String, dynamic> json) =>
      _$MastodonProofFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonProofToJson(this);

  /// プロバイダー上のアバターURL
  final String avatar;

  /// 署名情報のリスト
  @JsonKey(defaultValue: <MastodonProofSignature>[])
  final List<MastodonProofSignature> signatures;
}

/// 本人確認証明の署名情報
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonProofSignature {
  /// 各フィールドを指定して [MastodonProofSignature] を生成する
  const MastodonProofSignature({
    required this.sigHash,
    required this.kbUsername,
  });

  /// JSON マップから [MastodonProofSignature] を生成する
  factory MastodonProofSignature.fromJson(Map<String, dynamic> json) =>
      _$MastodonProofSignatureFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonProofSignatureToJson(this);

  /// 署名のハッシュ値
  final String sigHash;

  /// Keybase 上のユーザー名
  final String kbUsername;
}
