import 'package:json_annotation/json_annotation.dart';

part 'mastodon_admin_measure.g.dart';

/// 管理者向けメジャー（定量）データ
///
/// サーバーの定量的な統計情報を表す。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  /// メジャーの識別キー
  final String key;

  /// 値の単位
  final String? unit;

  /// 期間内の合計値（整数の文字列表現）
  final String total;

  /// 人間が読める形式の値
  final String? humanValue;

  /// 前期間の合計値（整数の文字列表現）
  final String? previousTotal;

  /// 日別のデータバケットリスト
  @JsonKey(defaultValue: <MastodonAdminMeasureData>[])
  final List<MastodonAdminMeasureData> data;
}

/// メジャーの日別データ
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminMeasureData {
  const MastodonAdminMeasureData({
    required this.date,
    required this.value,
  });

  factory MastodonAdminMeasureData.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminMeasureDataFromJson(json);

  /// 日付（深夜0時のタイムスタンプ）
  final String date;

  /// その日の値（整数の文字列表現）
  final String value;
}
