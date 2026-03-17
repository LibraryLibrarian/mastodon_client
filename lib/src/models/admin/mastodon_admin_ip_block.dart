import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_ip_block.g.dart';

/// IP ブロックの制限レベル
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonAdminIpBlockSeverity {
  /// サインアップ時に承認が必要
  signUpRequiresApproval,

  /// サインアップをブロック
  signUpBlock,

  /// すべてのアクセスを拒否
  noAccess,
}

/// 管理者向け IP ブロック情報
///
/// ブロックされている IP アドレス範囲の情報。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminIpBlock {
  const MastodonAdminIpBlock({
    required this.id,
    required this.ip,
    required this.severity,
    this.comment,
    this.createdAt,
    this.expiresAt,
  });

  factory MastodonAdminIpBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminIpBlockFromJson(json);

  /// IP ブロックのデータベース内 ID
  final String id;

  /// ブロック対象の IP アドレス範囲（CIDR 表記）
  final String ip;

  /// ブロックの制限レベル
  @JsonKey(unknownEnumValue: MastodonAdminIpBlockSeverity.signUpBlock)
  final MastodonAdminIpBlockSeverity severity;

  /// ブロックの理由
  @JsonKey(defaultValue: '')
  final String? comment;

  /// ブロックの作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// ブロックの有効期限（null の場合は無期限）
  @SafeDateTimeConverter()
  final DateTime? expiresAt;
}
