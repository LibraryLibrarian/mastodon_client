import 'package:freezed_annotation/freezed_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_cohort.freezed.dart';
part 'mastodon_admin_cohort.g.dart';

/// Admin-level retention cohort data.
///
/// Represents the retention rate of users who registered during a specific
/// period.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminCohort with _$MastodonAdminCohort {
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
  @override
  final DateTime? period;

  /// Granularity of the data (`day` or `month`).
  @override
  final String frequency;

  /// List of retention data entries.
  @JsonKey(defaultValue: <MastodonAdminCohortData>[])
  @override
  final List<MastodonAdminCohortData> data;
}

/// Individual retention data entry for a cohort.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminCohortData with _$MastodonAdminCohortData {
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
  @override
  final DateTime? date;

  /// Retention rate (as a decimal percentage).
  @override
  final double rate;

  /// Number of active users (string representation of an integer).
  @override
  final String value;
}
