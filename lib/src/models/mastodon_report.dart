import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';

part 'mastodon_report.freezed.dart';
part 'mastodon_report.g.dart';

/// Report entity.
///
/// Model representing report information referenced by admin notifications
/// and grouped notifications.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonReport with _$MastodonReport {
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

  /// Whether the report was forwarded to a remote server.
  @JsonKey(defaultValue: false)
  @override
  final bool forwarded;

  /// Timestamp when the report was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// List of status IDs associated with the report.
  @override
  final List<String>? statusIds;

  /// List of rule IDs associated with the report.
  @override
  final List<String>? ruleIds;

  /// Target account of the report.
  @override
  final MastodonAccount? targetAccount;
}
