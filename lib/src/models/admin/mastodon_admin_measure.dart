import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_admin_measure.freezed.dart';
part 'mastodon_admin_measure.g.dart';

/// Admin-level measure (quantitative) data.
///
/// Represents quantitative statistical information about the server.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminMeasure with _$MastodonAdminMeasure {
  const MastodonAdminMeasure({
    required this.key,
    this.unit,
    required this.total,
    this.humanValue,
    this.previousTotal,
    this.data = const [],
  });

  factory MastodonAdminMeasure.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminMeasureFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminMeasureToJson(this);

  /// Identifier key of the measure.
  @override
  final String key;

  /// Unit of the value.
  @override
  final String? unit;

  /// Total value for the period (string representation of an integer).
  @override
  final String total;

  /// Human-readable representation of the value.
  @override
  final String? humanValue;

  /// Total value for the previous period (string representation of an integer).
  @override
  final String? previousTotal;

  /// List of daily data buckets.
  @JsonKey(defaultValue: <MastodonAdminMeasureData>[])
  @override
  final List<MastodonAdminMeasureData> data;
}

/// Daily data entry for a measure.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminMeasureData with _$MastodonAdminMeasureData {
  const MastodonAdminMeasureData({required this.date, required this.value});

  factory MastodonAdminMeasureData.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminMeasureDataFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminMeasureDataToJson(this);

  /// Date (midnight timestamp).
  @override
  final String date;

  /// Value for the day (string representation of an integer).
  @override
  final String value;
}
