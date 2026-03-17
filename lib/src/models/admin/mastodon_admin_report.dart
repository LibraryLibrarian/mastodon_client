import 'package:json_annotation/json_annotation.dart';

import '../json_converters.dart';
import '../mastodon_instance.dart';
import '../mastodon_status.dart';
import 'mastodon_admin_account.dart';

part 'mastodon_admin_report.g.dart';

/// 管理者向け通報情報
///
/// Admin API で返される通報の詳細情報。
/// 通常の通報情報に加え、担当モデレーターや対応状況などの管理情報を含む。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminReport {
  const MastodonAdminReport({
    required this.id,
    required this.actionTaken,
    this.actionTakenAt,
    required this.category,
    required this.comment,
    required this.forwarded,
    this.createdAt,
    this.updatedAt,
    this.account,
    this.targetAccount,
    this.assignedAccount,
    this.actionTakenByAccount,
    this.statuses = const [],
    this.rules = const [],
  });

  factory MastodonAdminReport.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminReportFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonAdminReportToJson(this);

  /// 通報のデータベース内 ID
  final String id;

  /// 対応が完了したかどうか
  @JsonKey(defaultValue: false)
  final bool actionTaken;

  /// 対応が完了した日時
  @SafeDateTimeConverter()
  final DateTime? actionTakenAt;

  /// 通報のカテゴリ（`spam` / `legal` / `violation` / `other`）
  @JsonKey(defaultValue: 'other')
  final String category;

  /// 通報者が付記したコメント
  @JsonKey(defaultValue: '')
  final String comment;

  /// リモートインスタンスに転送されたかどうか
  @JsonKey(defaultValue: false)
  final bool forwarded;

  /// 通報の作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// 通報の最終更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// 通報者のアカウント（管理者向け情報）
  final MastodonAdminAccount? account;

  /// 通報対象のアカウント（管理者向け情報）
  final MastodonAdminAccount? targetAccount;

  /// 調査を担当しているモデレーター
  final MastodonAdminAccount? assignedAccount;

  /// 通報を処理したモデレーター
  final MastodonAdminAccount? actionTakenByAccount;

  /// 通報に関連する投稿のリスト
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// 違反したルールのリスト
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  final List<MastodonInstanceRule> rules;
}
