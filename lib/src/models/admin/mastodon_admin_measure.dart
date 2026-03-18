import 'package:json_annotation/json_annotation.dart';

part 'mastodon_admin_measure.g.dart';

/// Admin-level measure (quantitative) data.
///
/// Represents quantitative statistical information about the server.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminMeasure {
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
  final String key;

  /// Unit of the value.
  final String? unit;

  /// Total value for the period (string representation of an integer).
  final String total;

  /// Human-readable representation of the value.
  final String? humanValue;

  /// Total value for the previous period (string representation of an integer).
  final String? previousTotal;

  /// List of daily data buckets.
  @JsonKey(defaultValue: <MastodonAdminMeasureData>[])
  final List<MastodonAdminMeasureData> data;
}

/// Daily data entry for a measure.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminMeasureData {
  const MastodonAdminMeasureData({
    required this.date,
    required this.value,
  });

  factory MastodonAdminMeasureData.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminMeasureDataFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminMeasureDataToJson(this);

  /// Date (midnight timestamp).
  final String date;

  /// Value for the day (string representation of an integer).
  final String value;
}
