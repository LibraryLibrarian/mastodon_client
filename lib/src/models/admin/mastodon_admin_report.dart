import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import '../mastodon_instance.dart';
import '../mastodon_status.dart';
import 'mastodon_admin_account.dart';

part 'mastodon_admin_report.freezed.dart';
part 'mastodon_admin_report.g.dart';

/// Admin-level report information.
///
/// Detailed report information returned by the Admin API.
/// Includes admin-specific details such as the assigned moderator and
/// resolution status, in addition to standard report information.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminReport with _$MastodonAdminReport {
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
  @override
  final String id;

  /// Whether action has been taken.
  @JsonKey(defaultValue: false)
  @override
  final bool actionTaken;

  /// Timestamp when action was taken.
  @SafeDateTimeConverter()
  @override
  final DateTime? actionTakenAt;

  /// Category of the report (`spam` / `legal` / `violation` / `other`).
  @JsonKey(defaultValue: 'other')
  @override
  final String category;

  /// Comment added by the reporter.
  @JsonKey(defaultValue: '')
  @override
  final String comment;

  /// Whether the report was forwarded to a remote instance.
  @JsonKey(defaultValue: false)
  @override
  final bool forwarded;

  /// Timestamp when the report was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Timestamp when the report was last updated.
  @SafeDateTimeConverter()
  @override
  final DateTime? updatedAt;

  /// Account of the reporter (admin-level information).
  @override
  final MastodonAdminAccount? account;

  /// Target account of the report (admin-level information).
  @override
  final MastodonAdminAccount? targetAccount;

  /// Moderator assigned to investigate.
  @override
  final MastodonAdminAccount? assignedAccount;

  /// Moderator who handled the report.
  @override
  final MastodonAdminAccount? actionTakenByAccount;

  /// List of statuses associated with the report.
  @JsonKey(defaultValue: <MastodonStatus>[])
  @override
  final List<MastodonStatus> statuses;

  /// List of rules that were violated.
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  @override
  final List<MastodonInstanceRule> rules;
}
