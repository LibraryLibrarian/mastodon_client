import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_domain_block.g.dart';

/// 管理者向けドメインブロックの制限レベル
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonAdminDomainBlockSeverity {
  /// サイレンス（タイムラインや通知から非表示）
  silence,

  /// 凍結（全通信を拒否）
  suspend,

  /// 操作なし
  noop,
}

/// 管理者向けドメインブロック情報
///
/// フェデレーションがブロックされているドメインの詳細情報。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminDomainBlock {
  const MastodonAdminDomainBlock({
    required this.id,
    required this.domain,
    required this.digest,
    required this.severity,
    this.rejectMedia = false,
    this.rejectReports = false,
    this.privateComment,
    this.publicComment,
    this.obfuscate = false,
    this.createdAt,
  });

  factory MastodonAdminDomainBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDomainBlockFromJson(json);

  /// ドメインブロックのデータベース内 ID
  final String id;

  /// ブロック対象のドメイン
  final String domain;

  /// ドメインの SHA256 ダイジェスト
  final String digest;

  /// ブロックの制限レベル
  @JsonKey(unknownEnumValue: MastodonAdminDomainBlockSeverity.silence)
  final MastodonAdminDomainBlockSeverity severity;

  /// メディア添付を拒否するかどうか
  @JsonKey(defaultValue: false)
  final bool rejectMedia;

  /// 通報を拒否するかどうか
  @JsonKey(defaultValue: false)
  final bool rejectReports;

  /// 管理者向けの非公開コメント
  final String? privateComment;

  /// 一般公開用のコメント
  final String? publicComment;

  /// 公開表示時にドメイン名を難読化するかどうか
  @JsonKey(defaultValue: false)
  final bool obfuscate;

  /// ドメインがブロックされた日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;
}
