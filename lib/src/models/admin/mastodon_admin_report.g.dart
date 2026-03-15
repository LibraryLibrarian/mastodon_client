// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminReport _$MastodonAdminReportFromJson(
  Map<String, dynamic> json,
) => MastodonAdminReport(
  id: json['id'] as String,
  actionTaken: json['action_taken'] as bool? ?? false,
  actionTakenAt: const SafeDateTimeConverter().fromJson(
    json['action_taken_at'] as String?,
  ),
  category: json['category'] as String? ?? 'other',
  comment: json['comment'] as String? ?? '',
  forwarded: json['forwarded'] as bool? ?? false,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const SafeDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
  account: json['account'] == null
      ? null
      : MastodonAdminAccount.fromJson(json['account'] as Map<String, dynamic>),
  targetAccount: json['target_account'] == null
      ? null
      : MastodonAdminAccount.fromJson(
          json['target_account'] as Map<String, dynamic>,
        ),
  assignedAccount: json['assigned_account'] == null
      ? null
      : MastodonAdminAccount.fromJson(
          json['assigned_account'] as Map<String, dynamic>,
        ),
  actionTakenByAccount: json['action_taken_by_account'] == null
      ? null
      : MastodonAdminAccount.fromJson(
          json['action_taken_by_account'] as Map<String, dynamic>,
        ),
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => MastodonInstanceRule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);
