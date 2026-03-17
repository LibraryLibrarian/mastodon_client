import 'package:json_annotation/json_annotation.dart';

part 'mastodon_unread_notification_count.g.dart';

/// 未読通知の件数（Mastodon 4.3+）
///
/// `GET /api/v1/notifications/unread_count`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonUnreadNotificationCount {
  const MastodonUnreadNotificationCount({required this.count});

  factory MastodonUnreadNotificationCount.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonUnreadNotificationCountFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() =>
      _$MastodonUnreadNotificationCountToJson(this);

  /// 未読通知の件数
  @JsonKey(defaultValue: 0)
  final int count;
}
