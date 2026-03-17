import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';

part 'mastodon_report.g.dart';

/// 通報エンティティ
///
/// 管理者向け通知やグループ化通知で参照される通報情報を表すモデル。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonReport {
  const MastodonReport({
    required this.id,
    required this.actionTaken,
    this.actionTakenAt,
    required this.category,
    required this.comment,
    required this.forwarded,
    this.createdAt,
    this.statusIds,
    this.ruleIds,
    this.targetAccount,
  });

  factory MastodonReport.fromJson(Map<String, dynamic> json) =>
      _$MastodonReportFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonReportToJson(this);

  /// 通報のID
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

  /// リモートサーバーに転送されたかどうか
  @JsonKey(defaultValue: false)
  final bool forwarded;

  /// 通報の作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// 通報に関連する投稿のIDリスト
  final List<String>? statusIds;

  /// 通報に関連するルールのIDリスト
  final List<String>? ruleIds;

  /// 通報対象のアカウント
  final MastodonAccount? targetAccount;
}
