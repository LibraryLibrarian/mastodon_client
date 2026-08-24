// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_annual_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAnnualReport _$MastodonAnnualReportFromJson(
  Map<String, dynamic> json,
) => MastodonAnnualReport(
  year: (json['year'] as num).toInt(),
  data: json['data'] as Map<String, dynamic>,
  schemaVersion: (json['schema_version'] as num).toInt(),
  accountId: json['account_id'] as String,
  shareUrl: json['share_url'] as String?,
);

Map<String, dynamic> _$MastodonAnnualReportToJson(
  MastodonAnnualReport instance,
) => <String, dynamic>{
  'year': instance.year,
  'data': instance.data,
  'schema_version': instance.schemaVersion,
  'share_url': instance.shareUrl,
  'account_id': instance.accountId,
};

MastodonAnnualReportsResult _$MastodonAnnualReportsResultFromJson(
  Map<String, dynamic> json,
) => MastodonAnnualReportsResult(
  annualReports:
      (json['annual_reports'] as List<dynamic>?)
          ?.map((e) => MastodonAnnualReport.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonAnnualReportsResultToJson(
  MastodonAnnualReportsResult instance,
) => <String, dynamic>{
  'annual_reports': instance.annualReports.map((e) => e.toJson()).toList(),
  'accounts': instance.accounts.map((e) => e.toJson()).toList(),
  'statuses': instance.statuses.map((e) => e.toJson()).toList(),
};
