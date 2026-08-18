import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_admin_dimension.freezed.dart';
part 'mastodon_admin_dimension.g.dart';

/// Admin-level dimension (qualitative) data.
///
/// Represents qualitative statistical information about the server.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminDimension with _$MastodonAdminDimension {
  const MastodonAdminDimension({required this.key, this.data = const []});

  factory MastodonAdminDimension.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDimensionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminDimensionToJson(this);

  /// Identifier key of the dimension.
  @override
  final String key;

  /// List of data entries for the dimension.
  @JsonKey(defaultValue: <MastodonAdminDimensionData>[])
  @override
  final List<MastodonAdminDimensionData> data;
}

/// Individual data entry for a dimension.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminDimensionData with _$MastodonAdminDimensionData {
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
  @override
  final String key;

  /// Human-readable key name.
  @override
  final String humanKey;

  /// Value.
  @override
  final String value;

  /// Unit of the value (e.g. `bytes`).
  @override
  final String? unit;

  /// Human-readable representation of the value.
  @override
  final String? humanValue;
}
