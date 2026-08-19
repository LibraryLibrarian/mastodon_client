import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_annual_report.freezed.dart';
part 'mastodon_annual_report.g.dart';

/// A generated annual usage report.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAnnualReport with _$MastodonAnnualReport {
  const MastodonAnnualReport({
    required this.year,
    required this.data,
    required this.schemaVersion,
    required this.accountId,
    this.shareUrl,
  });

  factory MastodonAnnualReport.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnualReportFromJson(json);

  Map<String, dynamic> toJson() => _$MastodonAnnualReportToJson(this);

  @override
  final int year;

  @override
  final Map<String, dynamic> data;

  @override
  final int schemaVersion;

  @override
  final String? shareUrl;

  @override
  final String accountId;
}

/// Compound response returned by annual report list and detail endpoints.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAnnualReportsResult with _$MastodonAnnualReportsResult {
  const MastodonAnnualReportsResult({
    this.annualReports = const <MastodonAnnualReport>[],
    this.accounts = const <MastodonAccount>[],
    this.statuses = const <MastodonStatus>[],
  });

  factory MastodonAnnualReportsResult.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnualReportsResultFromJson(json);

  Map<String, dynamic> toJson() => _$MastodonAnnualReportsResultToJson(this);

  @JsonKey(defaultValue: <MastodonAnnualReport>[])
  @override
  final List<MastodonAnnualReport> annualReports;

  @JsonKey(defaultValue: <MastodonAccount>[])
  @override
  final List<MastodonAccount> accounts;

  @JsonKey(defaultValue: <MastodonStatus>[])
  @override
  final List<MastodonStatus> statuses;
}

/// Generation state returned by the annual report state endpoint.
enum MastodonAnnualReportState {
  available,
  generating,
  eligible,
  ineligible,
  unknown;

  static MastodonAnnualReportState fromJson(String? value) => switch (value) {
    'available' => available,
    'generating' => generating,
    'eligible' => eligible,
    'ineligible' => ineligible,
    _ => unknown,
  };
}
