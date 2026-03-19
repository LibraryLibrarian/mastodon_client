// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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

Map<String, dynamic> _$MastodonReportToJson(MastodonReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action_taken': instance.actionTaken,
      'action_taken_at': const SafeDateTimeConverter().toJson(
        instance.actionTakenAt,
      ),
      'category': instance.category,
      'comment': instance.comment,
      'forwarded': instance.forwarded,
      'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
      'status_ids': instance.statusIds,
      'rule_ids': instance.ruleIds,
      'target_account': instance.targetAccount?.toJson(),
    };
