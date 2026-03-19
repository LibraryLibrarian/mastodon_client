import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_cohort.g.dart';

/// Admin-level retention cohort data.
///
/// Represents the retention rate of users who registered during a specific
/// period.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminCohort {
  const MastodonAdminCohort({
    this.period,
    required this.frequency,
    this.data = const [],
  });

  factory MastodonAdminCohort.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminCohortFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminCohortToJson(this);

  /// Start timestamp of the cohort period (midnight).
  @SafeDateTimeConverter()
  final DateTime? period;

  /// Granularity of the data (`day` or `month`).
  final String frequency;

  /// List of retention data entries.
  @JsonKey(defaultValue: <MastodonAdminCohortData>[])
  final List<MastodonAdminCohortData> data;
}

/// Individual retention data entry for a cohort.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminCohortData {
  const MastodonAdminCohortData({
    this.date,
    required this.rate,
    required this.value,
  });

  factory MastodonAdminCohortData.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminCohortDataFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminCohortDataToJson(this);

  /// Start timestamp of the bucket (midnight).
  @SafeDateTimeConverter()
  final DateTime? date;

  /// Retention rate (as a decimal percentage).
  final double rate;

  /// Number of active users (string representation of an integer).
  final String value;
}
