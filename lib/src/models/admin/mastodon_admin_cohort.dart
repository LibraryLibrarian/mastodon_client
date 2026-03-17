import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_cohort.g.dart';

/// 管理者向けリテンションコホートデータ
///
/// 特定の期間に登録したユーザーのリテンション率を表す。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminCohort {
  const MastodonAdminCohort({
    this.period,
    required this.frequency,
    this.data = const [],
  });

  factory MastodonAdminCohort.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminCohortFromJson(json);

  /// コホート期間の開始日時（深夜0時）
  @SafeDateTimeConverter()
  final DateTime? period;

  /// データの粒度（`day` または `month`）
  final String frequency;

  /// リテンションデータのリスト
  @JsonKey(defaultValue: <MastodonAdminCohortData>[])
  final List<MastodonAdminCohortData> data;
}

/// コホートの個別リテンションデータ
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminCohortData {
  const MastodonAdminCohortData({
    this.date,
    required this.rate,
    required this.value,
  });

  factory MastodonAdminCohortData.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminCohortDataFromJson(json);

  /// バケット開始日時（深夜0時）
  @SafeDateTimeConverter()
  final DateTime? date;

  /// リテンション率（小数のパーセンテージ）
  final double rate;

  /// アクティブユーザー数（整数の文字列表現）
  final String value;
}
