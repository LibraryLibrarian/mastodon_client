import 'package:json_annotation/json_annotation.dart';

part 'mastodon_admin_dimension.g.dart';

/// Admin-level dimension (qualitative) data.
///
/// Represents qualitative statistical information about the server.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminDimension {
  const MastodonAdminDimension({
    required this.key,
    this.data = const [],
  });

  factory MastodonAdminDimension.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDimensionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminDimensionToJson(this);

  /// Identifier key of the dimension.
  final String key;

  /// List of data entries for the dimension.
  @JsonKey(defaultValue: <MastodonAdminDimensionData>[])
  final List<MastodonAdminDimensionData> data;
}

/// Individual data entry for a dimension.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminDimensionData {
  const MastodonAdminDimensionData({
    required this.key,
    required this.humanKey,
    required this.value,
    this.unit,
    this.humanValue,
  });

  factory MastodonAdminDimensionData.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDimensionDataFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminDimensionDataToJson(this);

  /// Identifier key of the data entry.
  final String key;

  /// Human-readable key name.
  final String humanKey;

  /// Value.
  final String value;

  /// Unit of the value (e.g. `bytes`).
  final String? unit;

  /// Human-readable representation of the value.
  final String? humanValue;
}
