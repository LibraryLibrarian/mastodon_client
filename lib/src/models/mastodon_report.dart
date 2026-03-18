import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';

part 'mastodon_report.g.dart';

/// Report entity.
///
/// Model representing report information referenced by admin notifications
/// and grouped notifications.
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

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonReportToJson(this);

  /// ID of the report.
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

  /// Whether the report was forwarded to a remote server.
  @JsonKey(defaultValue: false)
  final bool forwarded;

  /// Timestamp when the report was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// List of status IDs associated with the report.
  final List<String>? statusIds;

  /// List of rule IDs associated with the report.
  final List<String>? ruleIds;

  /// Target account of the report.
  final MastodonAccount? targetAccount;
}
