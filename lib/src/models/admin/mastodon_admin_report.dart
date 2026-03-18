import 'package:json_annotation/json_annotation.dart';

import '../json_converters.dart';
import '../mastodon_instance.dart';
import '../mastodon_status.dart';
import 'mastodon_admin_account.dart';

part 'mastodon_admin_report.g.dart';

/// Admin-level report information.
///
/// Detailed report information returned by the Admin API.
/// Includes admin-specific details such as the assigned moderator and
/// resolution status, in addition to standard report information.
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

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminReportToJson(this);

  /// Database ID of the report.
  final String id;

  /// Whether action has been taken.
  @JsonKey(defaultValue: false)
  final bool actionTaken;

  /// Timestamp when action was taken.
  @SafeDateTimeConverter()
  final DateTime? actionTakenAt;

  /// Category of the report (`spam` / `legal` / `violation` / `other`).
  @JsonKey(defaultValue: 'other')
  final String category;

  /// Comment added by the reporter.
  @JsonKey(defaultValue: '')
  final String comment;

  /// Whether the report was forwarded to a remote instance.
  @JsonKey(defaultValue: false)
  final bool forwarded;

  /// Timestamp when the report was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Timestamp when the report was last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// Account of the reporter (admin-level information).
  final MastodonAdminAccount? account;

  /// Target account of the report (admin-level information).
  final MastodonAdminAccount? targetAccount;

  /// Moderator assigned to investigate.
  final MastodonAdminAccount? assignedAccount;

  /// Moderator who handled the report.
  final MastodonAdminAccount? actionTakenByAccount;

  /// List of statuses associated with the report.
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// List of rules that were violated.
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  final List<MastodonInstanceRule> rules;
}
