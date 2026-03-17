import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_email_domain_block.g.dart';

/// 管理者向けメールドメインブロック情報
///
/// サインアップが禁止されているメールドメインの情報。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminEmailDomainBlock {
  const MastodonAdminEmailDomainBlock({
    required this.id,
    required this.domain,
    this.createdAt,
    this.history = const [],
  });

  factory MastodonAdminEmailDomainBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminEmailDomainBlockFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonAdminEmailDomainBlockToJson(this);

  /// ブロックのデータベース内 ID
  final String id;

  /// サインアップが禁止されているメールドメイン
  final String domain;

  /// ドメインがブロックされた日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// 直近の日別利用統計
  @JsonKey(defaultValue: <MastodonAdminEmailDomainBlockHistory>[])
  final List<MastodonAdminEmailDomainBlockHistory> history;
}

/// メールドメインブロックの日別利用統計
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminEmailDomainBlockHistory {
  const MastodonAdminEmailDomainBlockHistory({
    required this.day,
    required this.accounts,
    required this.uses,
  });

  factory MastodonAdminEmailDomainBlockHistory.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonAdminEmailDomainBlockHistoryFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() =>
      _$MastodonAdminEmailDomainBlockHistoryToJson(this);

  /// 該当日の深夜0時の UNIX タイムスタンプ（文字列）
  final String day;

  /// その日のアカウント登録試行数（文字列）
  final String accounts;

  /// その日の IP 登録試行数（文字列）
  final String uses;
}
