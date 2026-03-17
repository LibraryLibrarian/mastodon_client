// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonReport _$MastodonReportFromJson(Map<String, dynamic> json) =>
    MastodonReport(
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
      statusIds: (json['status_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ruleIds: (json['rule_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      targetAccount: json['target_account'] == null
          ? null
          : MastodonAccount.fromJson(
              json['target_account'] as Map<String, dynamic>,
            ),
    );
