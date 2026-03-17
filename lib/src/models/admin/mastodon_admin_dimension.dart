import 'package:json_annotation/json_annotation.dart';

part 'mastodon_admin_dimension.g.dart';

/// 管理者向けディメンション（次元）データ
///
/// サーバーの定性的な統計情報を表す。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminDimension {
  const MastodonAdminDimension({
    required this.key,
    this.data = const [],
  });

  factory MastodonAdminDimension.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDimensionFromJson(json);

  /// ディメンションの識別キー
  final String key;

  /// ディメンションのデータ項目リスト
  @JsonKey(defaultValue: <MastodonAdminDimensionData>[])
  final List<MastodonAdminDimensionData> data;
}

/// ディメンションの個別データ項目
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  /// データ項目の識別キー
  final String key;

  /// 人間が読めるキー名
  final String humanKey;

  /// 値
  final String value;

  /// 値の単位（例: `bytes`）
  final String? unit;

  /// 人間が読める形式の値
  final String? humanValue;
}
