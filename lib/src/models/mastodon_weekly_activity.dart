import 'package:json_annotation/json_annotation.dart';

part 'mastodon_weekly_activity.g.dart';

/// インスタンスの週間アクティビティ統計
///
/// `GET /api/v1/instance/activity`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonWeeklyActivity {
  const MastodonWeeklyActivity({
    required this.week,
    required this.statuses,
    required this.logins,
    required this.registrations,
  });

  factory MastodonWeeklyActivity.fromJson(Map<String, dynamic> json) =>
      _$MastodonWeeklyActivityFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonWeeklyActivityToJson(this);

  /// 週の開始時点の UNIX タイムスタンプ（文字列）
  @JsonKey(defaultValue: '0')
  final String week;

  /// その週に投稿された投稿数（文字列）
  @JsonKey(defaultValue: '0')
  final String statuses;

  /// その週にログインしたユーザー数（文字列）
  @JsonKey(defaultValue: '0')
  final String logins;

  /// その週に登録したユーザー数（文字列）
  @JsonKey(defaultValue: '0')
  final String registrations;
}
