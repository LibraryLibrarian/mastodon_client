import 'package:json_annotation/json_annotation.dart';

part 'mastodon_domain_block.g.dart';

/// ドメインブロックの制限レベル
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonDomainBlockSeverity {
  /// ブロック対象ドメインのユーザーをタイムラインや通知から非表示
  silence,

  /// ブロック対象ドメインからのメッセージをすべて拒否・破棄
  suspend,

  /// 未知または将来追加される制限レベル
  unknown,
}

/// インスタンスがブロックしているドメインの情報
///
/// `GET /api/v1/instance/domain_blocks`
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonDomainBlock {
  const MastodonDomainBlock({
    required this.domain,
    required this.digest,
    required this.severity,
    this.comment,
  });

  factory MastodonDomainBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonDomainBlockFromJson(json);

  /// ブロック対象のドメイン名
  final String domain;

  /// ドメイン文字列の SHA256 ハッシュダイジェスト
  final String digest;

  /// ブロックの制限レベル
  @JsonKey(unknownEnumValue: MastodonDomainBlockSeverity.unknown)
  final MastodonDomainBlockSeverity severity;

  /// ドメインブロックの理由（任意）
  final String? comment;
}
