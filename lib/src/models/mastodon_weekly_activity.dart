import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_weekly_activity.freezed.dart';
part 'mastodon_weekly_activity.g.dart';

/// Weekly activity statistics of the instance.
///
/// `GET /api/v1/instance/activity`
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonWeeklyActivity with _$MastodonWeeklyActivity {
  const MastodonWeeklyActivity({
    required this.week,
    required this.statuses,
    required this.logins,
    required this.registrations,
  });

  factory MastodonWeeklyActivity.fromJson(Map<String, dynamic> json) =>
      _$MastodonWeeklyActivityFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonWeeklyActivityToJson(this);

  /// UNIX timestamp at the start of the week (string).
  @JsonKey(defaultValue: '0')
  @override
  final String week;

  /// Number of statuses posted during the week (string).
  @JsonKey(defaultValue: '0')
  @override
  final String statuses;

  /// Number of users who logged in during the week (string).
  @JsonKey(defaultValue: '0')
  @override
  final String logins;

  /// Number of users who registered during the week (string).
  @JsonKey(defaultValue: '0')
  @override
  final String registrations;
}
